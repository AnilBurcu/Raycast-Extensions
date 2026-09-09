#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Timer
# @raycast.mode compact
# @raycast.packageName Productivity

# Optional parameters:
# @raycast.icon ⏱️
# @raycast.argument1 { "type": "text", "placeholder": "Minutes", "optional": false }

# Documentation:
# @raycast.description Simple minute timer with notification
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

MINUTES="$1"

if ! [[ "$MINUTES" =~ ^[0-9]+$ ]] || [ "$MINUTES" -eq 0 ]; then
    echo "Enter a number greater than 0"
    exit 1
fi

SECS=$((MINUTES * 60))

# Fully detach the countdown: Raycast 2.x waits on the script's stdout/stderr
# pipes, so the background job must not inherit them or the command hangs.
nohup /bin/bash -c "sleep $SECS && /usr/bin/osascript -e 'display notification \"$MINUTES min timer done\" with title \"Timer\" sound name \"Glass\"'" >/dev/null 2>&1 &
disown

echo "Timer set: $MINUTES min"
