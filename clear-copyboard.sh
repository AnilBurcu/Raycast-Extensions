#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Clipboard History
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🧽

# Documentation:
# @raycast.description Wipe the clipboard
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

pbcopy < /dev/null
