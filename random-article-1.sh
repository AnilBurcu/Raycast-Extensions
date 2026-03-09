#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Random Wikipedia Article
# @raycast.mode compact
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📚

# Documentation:
# @raycast.description Open a random Wikipedia article
# @raycast.author Perikles

# Turkish Wikipedia
open "https://en.wikipedia.org/wiki/Special:Random"
echo "📚 Random English Wikipedia article opened!"