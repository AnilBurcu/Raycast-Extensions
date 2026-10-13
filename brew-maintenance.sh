#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Homebrew Maintenance
# @raycast.mode fullOutput
# @raycast.packageName System Maintenance

# Optional parameters:
# @raycast.icon 🍺

# Documentation:
# @raycast.description Update, upgrade (incl. greedy casks) & cleanup homebrew
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Raycast 2.x runs scripts with a bare PATH (/usr/bin:/bin:/usr/sbin:/sbin),
# so Homebrew has to be located and put on PATH explicitly.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$brew_bin" ]; then
        eval "$("$brew_bin" shellenv)"
        break
    fi
done
export HOMEBREW_NO_ENV_HINTS=1

# Raycast 2.x does not expand "~" in @raycast.currentDirectoryPath (spawn fails
# with ENOENT), so the directive is gone and we cd here instead.
cd "$HOME" || exit 1

START_TIME=$(date +%s)

# Helper: human-readable bytes
human_readable() {
    local bytes=$1
    if [ "$bytes" -ge 1073741824 ]; then
        awk -v b="$bytes" 'BEGIN { printf "%.2f GB", b/1073741824 }'
    elif [ "$bytes" -ge 1048576 ]; then
        awk -v b="$bytes" 'BEGIN { printf "%.2f MB", b/1048576 }'
    elif [ "$bytes" -ge 1024 ]; then
        awk -v b="$bytes" 'BEGIN { printf "%.2f KB", b/1024 }'
    else
        echo "${bytes} B"
    fi
}

# Get brew cache size in bytes
brew_cache_size() {
    local cache_dir
    cache_dir=$(brew --cache 2>/dev/null)
    if [ -d "$cache_dir" ]; then
        local size
        size=$(du -sk "$cache_dir" 2>/dev/null | awk '{print $1}')
        echo $((size * 1024))
    else
        echo 0
    fi
}

if ! command -v brew &> /dev/null; then
    echo "❌ Homebrew not found (looked in /opt/homebrew/bin and /usr/local/bin)"
    exit 1
fi

# Each brew step is logged so a failure's reason can be repeated in the summary.
LOG=$(mktemp -t brew-maintenance) || exit 1
trap 'rm -f "$LOG"' EXIT
FAILURES=()

run_brew() {
    brew "$@" 2>&1 | tee "$LOG"
    return "${PIPESTATUS[0]}"
}

record_failure() {
    local reason
    reason=$(grep -m1 '^Error:' "$LOG")
    FAILURES+=("$1${reason:+: ${reason#Error: }}")
}

echo "🍺 Running brew maintenance..."
echo ""

echo "→ brew update"
run_brew update || record_failure "brew update"

echo ""
echo "→ brew upgrade --greedy (includes auto-updating casks)"
if ! run_brew upgrade --greedy; then
    # Some errors make Homebrew exit before the rest of the queue is installed,
    # e.g. a formula without a bottle (supabase) while Xcode is older than
    # Homebrew's minimum. Retry whatever is still outdated one at a time so a
    # single bad package doesn't hold back git & co.
    REMAINING=$(brew outdated --greedy --quiet 2>/dev/null)
    if [ -z "$REMAINING" ]; then
        record_failure "brew upgrade"
    else
        echo ""
        echo "⚠️  brew upgrade stopped early, retrying the rest one by one"
        for pkg in $REMAINING; do
            echo ""
            echo "→ brew upgrade --greedy $pkg"
            run_brew upgrade --greedy "$pkg" || record_failure "$pkg"
        done
    fi
fi

# Measured here rather than at start, so bottles downloaded by the upgrade
# count towards what cleanup frees.
BEFORE_BYTES=$(brew_cache_size)

echo ""
echo "→ brew cleanup --prune=all"
run_brew cleanup --prune=all || record_failure "brew cleanup"

echo ""
echo "→ brew autoremove"
run_brew autoremove || record_failure "brew autoremove"

# doctor exits non-zero whenever it has a warning, so it is informational only.
echo ""
echo "→ brew doctor"
brew doctor

AFTER_BYTES=$(brew_cache_size)
FREED_BYTES=$((BEFORE_BYTES - AFTER_BYTES))
END_TIME=$(date +%s)
ELAPSED=$((END_TIME - START_TIME))

echo ""
echo "─────────────────────────────────────────"
echo "📦 Cache before cleanup: $(human_readable "$BEFORE_BYTES")"
echo "📦 Cache after cleanup:  $(human_readable "$AFTER_BYTES")"
if [ "$FREED_BYTES" -gt 0 ]; then
    echo "🎉 Freed:                $(human_readable "$FREED_BYTES")"
fi
echo "⏱  Took:                 ${ELAPSED}s"
echo "─────────────────────────────────────────"
echo ""

if [ ${#FAILURES[@]} -gt 0 ]; then
    echo "⚠️  Finished with errors:"
    for failure in "${FAILURES[@]}"; do
        echo "   • $failure"
    done
    exit 1
fi

echo "✅ Done."
