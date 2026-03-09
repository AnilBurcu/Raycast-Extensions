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

MONTH=$(date +%-m)
DAY=$(date +%-d)
MONTH_NAME=$(date +%B)

echo "Today in History -- $MONTH_NAME $DAY"
echo "========================================="
echo ""

RESPONSE=$(curl -s "https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$MONTH/$DAY" \
    -H "Accept: application/json" \
    -H "User-Agent: RaycastScript/1.0")

if [ -z "$RESPONSE" ]; then
    echo "Couldn't fetch events from Wikipedia"
    exit 1
fi

YEARS=$(echo "$RESPONSE" | grep -o '"year":[0-9-]*' | head -5 | cut -d':' -f2)
TEXTS=$(echo "$RESPONSE" | grep -o '"text":"[^"]*' | head -5 | cut -d'"' -f4)

if [ -z "$YEARS" ]; then
    echo "No events found"
    exit 1
fi

paste <(echo "$YEARS") <(echo "$TEXTS") | while IFS=$'\t' read -r year text; do
    echo "[$year] $text" | fold -s -w 60
    echo ""
done

echo "---"
echo "en.wikipedia.org/wiki/${MONTH_NAME}_${DAY}"
