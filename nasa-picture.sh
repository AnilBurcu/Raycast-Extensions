#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title NASA Picture of the Day
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 🚀

# Documentation:
# @raycast.description Get NASA's Astronomy Picture of the Day
# @raycast.author Perikles

echo "--- 🚀 NASA Astronomy Picture of the Day ---\n"

# Fetch APOD
API_KEY="DEMO_KEY"
RESPONSE=$(curl -s "https://api.nasa.gov/planetary/apod?api_key=$API_KEY")

# Extract data using grep and sed
TITLE=$(echo "$RESPONSE" | grep -o '"title":"[^"]*' | cut -d'"' -f4)
EXPLANATION=$(echo "$RESPONSE" | grep -o '"explanation":"[^"]*' | cut -d'"' -f4 | head -c 200)
URL=$(echo "$RESPONSE" | grep -o '"url":"[^"]*' | cut -d'"' -f4)

echo "📸 $TITLE\n"
echo "📝 ${EXPLANATION}...\n"

# Open image
open "$URL"

echo "✅ Image opened in browser!"