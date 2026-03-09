#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title NASA Picture of the Day
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 🚀

# Documentation:
# @raycast.description Fetches and displays NASA's Astronomy Picture of the Day (APOD). Uses the NASA DEMO_KEY with limited requests.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

echo -e "--- 🚀 NASA Astronomy Picture of the Day ---\n"

# Fetch APOD
API_KEY="DEMO_KEY"
RESPONSE=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

if [ -z "$RESPONSE" ]; then
    echo "❌ Failed to fetch data from NASA API"
    exit 1
fi

# Extract data using grep and sed
TITLE=$(echo "$RESPONSE" | grep -o '"title":"[^"]*' | cut -d'"' -f4)
EXPLANATION=$(echo "$RESPONSE" | grep -o '"explanation":"[^"]*' | cut -d'"' -f4 | head -c 200)
URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*' | cut -d'"' -f4)

if [ -z "$URL" ]; then
    echo "❌ Could not parse NASA API response"
    exit 1
fi

echo -e "📸 $TITLE\n"
echo -e "📝 ${EXPLANATION}...\n"

# Open image in default browser
open "$URL"

echo "✅ Image opened in browser!"
