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

if ! command -v jq &> /dev/null; then
    echo "jq is required (built into macOS 15+, or: brew install jq)"
    exit 1
fi

RESPONSE=$(curl -sf --max-time 15 "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

if [ -z "$RESPONSE" ]; then
    echo "Failed to reach NASA API"
    exit 1
fi

if ! echo "$RESPONSE" | jq -e 'type == "object" and has("url")' >/dev/null 2>&1; then
    ERR=$(echo "$RESPONSE" | jq -r '.error.message // .msg // "Could not parse response"' 2>/dev/null)
    echo "${ERR:-Could not parse response}"
    exit 1
fi

TITLE=$(echo "$RESPONSE" | jq -r '.title // "Untitled"')
DATE=$(echo "$RESPONSE" | jq -r '.date // ""')
EXPLANATION=$(echo "$RESPONSE" | jq -r '.explanation // ""' | head -c 400)
MEDIA=$(echo "$RESPONSE" | jq -r '.media_type // "image"')
URL=$(echo "$RESPONSE" | jq -r '.hdurl // .url')

echo "$TITLE"
[ -n "$DATE" ] && echo "$DATE"
echo ""
echo "${EXPLANATION}..." | fold -s -w 70
echo ""
if [ "$MEDIA" != "image" ]; then
    echo "($MEDIA)"
fi
echo "$URL"
open "$URL"
echo "Opened in browser"
