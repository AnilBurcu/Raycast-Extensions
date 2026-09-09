#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Development Caches
# @raycast.mode fullOutput
# @raycast.packageName Development Tools

# Optional parameters:
# @raycast.icon 🧹
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Nuke dev caches (npm, yarn, pods, xcode, gradle, expo, simulator, etc)
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Raycast 2.x runs scripts with a bare PATH (/usr/bin:/bin:/usr/sbin:/sbin).
# Put Homebrew, rbenv shims (cocoapods) and user-local tools on PATH explicitly.
for brew_bin in /opt/homebrew/bin/brew /usr/local/bin/brew; do
    if [ -x "$brew_bin" ]; then
        eval "$("$brew_bin" shellenv)"
        break
    fi
done
export PATH="$HOME/.rbenv/shims:$HOME/.local/bin:$PATH"

# Raycast 2.x does not expand "~" in @raycast.currentDirectoryPath (spawn fails
# with ENOENT), so the directive is gone and we cd here instead.
cd "$HOME" || exit 1

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

# Helper: total bytes used by a list of paths
total_size_bytes() {
    local total=0
    for path in "$@"; do
        if [ -e "$path" ]; then
            local size
            size=$(du -sk "$path" 2>/dev/null | awk '{print $1}')
            if [ -n "$size" ]; then
                total=$((total + size * 1024))
            fi
        fi
    done
    echo "$total"
}

# Paths to track
PATHS=(
    "$HOME/Library/Developer/Xcode/DerivedData"
    "$HOME/Library/Caches/com.apple.dt.Xcode"
    "$HOME/Library/Developer/CoreSimulator/Caches"
    "$HOME/.gradle/caches"
    "$HOME/.android/build-cache"
    "$HOME/Library/Caches/CocoaPods"
    "$HOME/.npm"
    "$HOME/.yarn/cache"
    "$HOME/.expo"
)

echo "🔍 Checking sizes before cleanup..."
echo ""

du -sh "${PATHS[@]}" 2>/dev/null

BEFORE_BYTES=$(total_size_bytes "${PATHS[@]}")

echo ""
echo "🧹 Cleaning dev caches..."
echo ""

# ---------- Node / JS ----------
if command -v npm &> /dev/null; then
    echo "→ npm cache clean --force"
    npm cache clean --force
else
    echo "✗ npm not found, skipping"
fi

if command -v yarn &> /dev/null; then
    echo "→ yarn cache clean"
    yarn cache clean
else
    echo "✗ yarn not found, skipping"
fi

# ---------- Watchman ----------
if command -v watchman &> /dev/null; then
    echo "→ watchman watch-del-all"
    watchman watch-del-all
else
    echo "✗ watchman not found, skipping"
fi

# ---------- Metro / Haste temp ----------
# Raycast does not export TMPDIR; fall back to the per-user temp dir.
TMP_DIR="${TMPDIR:-$(getconf DARWIN_USER_TEMP_DIR 2>/dev/null)}"
if [ -n "$TMP_DIR" ] && [ -d "$TMP_DIR" ]; then
    echo "→ clearing metro/haste temp files in $TMP_DIR"
    rm -rf "$TMP_DIR"/metro-*
    rm -rf "$TMP_DIR"/haste-map-*
else
    echo "✗ no temp dir found, skipping metro/haste cleanup"
fi

# ---------- Expo ----------
if [ -d ~/.expo ]; then
    echo "→ rm -rf ~/.expo"
    rm -rf ~/.expo
else
    echo "✗ no ~/.expo folder, skipping"
fi

# ---------- CocoaPods ----------
if command -v pod &> /dev/null; then
    echo "→ pod cache clean --all"
    pod cache clean --all
else
    echo "✗ cocoapods not found, skipping"
fi

# ---------- Xcode ----------
if [ -d ~/Library/Developer/Xcode/DerivedData ]; then
    echo "→ rm -rf DerivedData/*"
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
else
    echo "✗ no DerivedData folder, skipping"
fi

if [ -d ~/Library/Caches/com.apple.dt.Xcode ]; then
    echo "→ rm -rf Xcode caches"
    rm -rf ~/Library/Caches/com.apple.dt.Xcode
else
    echo "✗ no Xcode cache folder, skipping"
fi

# ---------- iOS Simulator ----------
if [ -d ~/Library/Developer/CoreSimulator/Caches ]; then
    echo "→ rm -rf CoreSimulator caches"
    rm -rf ~/Library/Developer/CoreSimulator/Caches/*
else
    echo "✗ no CoreSimulator caches folder, skipping"
fi

if command -v xcrun &> /dev/null; then
    echo "→ xcrun simctl delete unavailable"
    xcrun simctl delete unavailable
else
    echo "✗ xcrun not found, skipping"
fi

# ---------- Gradle / Android ----------
if [ -d ~/.gradle/caches ]; then
    echo "→ rm -rf ~/.gradle/caches"
    rm -rf ~/.gradle/caches/
else
    echo "✗ no gradle caches folder, skipping"
fi

if [ -d ~/.android/build-cache ]; then
    echo "→ rm -rf ~/.android/build-cache"
    rm -rf ~/.android/build-cache/
else
    echo "✗ no android build-cache folder, skipping"
fi

echo ""
echo "📊 Sizes after cleanup..."
echo ""

du -sh "${PATHS[@]}" 2>/dev/null

AFTER_BYTES=$(total_size_bytes "${PATHS[@]}")
FREED_BYTES=$((BEFORE_BYTES - AFTER_BYTES))

echo ""
echo "─────────────────────────────────────────"
echo "📦 Before:  $(human_readable "$BEFORE_BYTES")"
echo "📦 After:   $(human_readable "$AFTER_BYTES")"
echo "🎉 Freed:   $(human_readable "$FREED_BYTES")"
echo "─────────────────────────────────────────"
echo ""
echo "✅ All done."
