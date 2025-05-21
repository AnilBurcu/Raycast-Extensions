#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Random Wikipedia Article
# @raycast.mode compact
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 📚

# Documentation:
# @raycast.author Perikles B

# Fetch a random Wikipedia article's URL
ARTICLE_URL=$(curl -s "https://en.wikipedia.org/wiki/Special:Random")

# Extract the article title from the URL
ARTICLE_TITLE=$(curl -s "$ARTICLE_URL" | grep -oP '(?<=<title>)(.*?)(?= - Vikipedi)</title>')

# Open the random article in the default web browser
open "https://en.wikipedia.org/wiki$ARTICLE_URL"

# Output the article title and link in Raycast
echo "📖 Random Turkish Wikipedia Article:\n$ARTICLE_TITLE\n\n[Open Article](https://en.wikipedia.org/wiki$ARTICLE_URL)"
