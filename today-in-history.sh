#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Today in History
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📜

# Documentation:
# @raycast.description What happened on this day in history
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

if ! command -v jq &> /dev/null; then
    echo "jq is required (built into macOS 15+, or: brew install jq)"
    exit 1
fi

MONTH=$(date +%-m)
DAY=$(date +%-d)
MONTH_NAME=$(date +%B)

echo "Today in History -- $MONTH_NAME $DAY"
echo "========================================="
echo ""

RESPONSE=$(curl -sf --max-time 15 "https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$MONTH/$DAY" \
    -H "Accept: application/json" \
    -H "User-Agent: RaycastScript/1.0 (https://github.com/AnilBurcu/Raycast-Extensions)")

if [ -z "$RESPONSE" ]; then
    echo "Couldn't fetch events from Wikipedia"
    exit 1
fi

# Take the first 5 events, newest first, as "year<TAB>text" lines.
EVENTS=$(echo "$RESPONSE" | jq -r '
    (.events // [])
    | map(select(.year != null and .text != null))
    | .[:5]
    | sort_by(-.year)
    | .[]
    | "\(.year)\t\(.text)"
' 2>/dev/null)

if [ -z "$EVENTS" ]; then
    echo "No events found"
    exit 1
fi

while IFS=$'\t' read -r year text; do
    echo "[$year] $text" | fold -s -w 60
    echo ""
done <<< "$EVENTS"

echo "---"
echo "https://en.wikipedia.org/wiki/${MONTH_NAME}_${DAY}"
