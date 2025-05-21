#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Ask ChatGPT
# @raycast.mode silent
# @raycast.argument1 { "type": "text", "placeholder": "What do you want to ask?" }
# @raycast.packageName ChatGPT

# Optional parameters:
# @raycast.icon /Users/perikles/Desktop/Files/Code/Raycast Extensions/gpt.png

# Documentation:
# @raycast.author Perikles B

# Open ChatGPT app
open -a "ChatGPT"

# Wait for it to fully launch
sleep 1.95

# AppleScript to:
# - Activate the app
# - Press Cmd+N to start new chat
# - Type the question
# - Press Enter
osascript <<EOD
tell application "System Events"
    delay 0.2
    tell application "ChatGPT" to activate
    delay 0.5
    keystroke "n" using command down
    delay 0.5
    keystroke "$1"
    delay 0.2
    key code 36 -- Press Enter
end tell
EOD
