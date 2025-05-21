#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Clear Clipboard
# @raycast.mode silent
# @raycast.packageName System
# @raycast.icon 🧽

# Clear clipboard
pbcopy < /dev/null

# Output
echo "🧹 Clipboard cleared!"
