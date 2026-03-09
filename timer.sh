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
# @raycast.description Sets a timer for a specified number of minutes and sends a macOS notification when done.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

MINUTES="$1"

# Validate input is a positive number
if ! [[ "$MINUTES" =~ ^[0-9]+$ ]] || [ "$MINUTES" -eq 0 ]; then
    echo "❌ Please enter a valid number of minutes"
    exit 1
fi

SECONDS_TOTAL=$((MINUTES * 60))

# Schedule notification in the background
(sleep "$SECONDS_TOTAL" && osascript -e "display notification \"Your $MINUTES minute timer is up!\" with title \"⏱️ Timer\" sound name \"Glass\"") &

echo "⏱️ Timer set for $MINUTES minute(s)"
