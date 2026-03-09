#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Today in History
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📜

# Documentation:
# @raycast.description Shows notable historical events that happened on today's date, powered by the Wikipedia API.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

MONTH=$(date +%-m)
DAY=$(date +%-d)
MONTH_NAME=$(date +%B)

echo "╔══════════════════════════════════════════╗"
echo "║         📜 TODAY IN HISTORY              ║"
echo "║            $MONTH_NAME $DAY"
echo "╠══════════════════════════════════════════╣"

# Fetch from Wikipedia On This Day API
RESPONSE=$(curl -s "https://en.wikipedia.org/api/rest_v1/feed/onthisday/events/$MONTH/$DAY" \
    -H "Accept: application/json" \
    -H "User-Agent: RaycastScript/1.0")

if [ -z "$RESPONSE" ]; then
    echo "║  ❌ Failed to fetch historical events"
    echo "╚══════════════════════════════════════════╝"
    exit 1
fi

# Extract years and texts
YEARS=$(echo "$RESPONSE" | grep -o '"year":[0-9-]*' | head -5 | cut -d':' -f2)
TEXTS=$(echo "$RESPONSE" | grep -o '"text":"[^"]*' | head -5 | cut -d'"' -f4)

if [ -z "$YEARS" ]; then
    echo "║  ❌ Could not parse historical events"
    echo "╚══════════════════════════════════════════╝"
    exit 1
fi

echo "║"

paste <(echo "$YEARS") <(echo "$TEXTS") | while IFS=$'\t' read -r year text; do
    echo "║  📅 $year"
    echo "║  $text" | fold -s -w 42 | while IFS= read -r line; do echo "║  $line"; done
    echo "║"
    echo "║  ──────────────────────────────────────"
    echo "║"
done

echo "║  🔗 en.wikipedia.org/wiki/${MONTH_NAME}_${DAY}"
echo "║"
echo "╚══════════════════════════════════════════╝"
