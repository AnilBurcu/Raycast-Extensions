#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Random Wikipedia Article
# @raycast.mode compact
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📚

# Documentation:
# @raycast.description Opens a random English Wikipedia article in the default browser.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Open random English Wikipedia article
open "https://en.wikipedia.org/wiki/Special:Random"
echo "📚 Random Wikipedia article opened!"
