#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title NASA Picture of the Day
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 🚀

# Documentation:
# @raycast.description NASA Astronomy Picture of the Day
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

API_KEY="DEMO_KEY"  # rate limited, get your own at api.nasa.gov
RESPONSE=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

if [ -z "$RESPONSE" ]; then
    echo "Failed to reach NASA API"
    exit 1
fi

TITLE=$(echo "$RESPONSE" | grep -o '"title":"[^"]*' | cut -d'"' -f4)
EXPLANATION=$(echo "$RESPONSE" | grep -o '"explanation":"[^"]*' | cut -d'"' -f4 | head -c 200)
URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*' | cut -d'"' -f4)

if [ -z "$URL" ]; then
    echo "Couldn't parse response"
    exit 1
fi

echo "$TITLE"
echo ""
echo "${EXPLANATION}..."
echo ""
open "$URL"
echo "Opened in browser"
