#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clear Clipboard History
# @raycast.mode silent
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🧽

# Documentation:
# @raycast.description Clears the system clipboard contents.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Clear system clipboard
pbcopy < /dev/null
