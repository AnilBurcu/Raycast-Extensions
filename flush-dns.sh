#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Flush DNS Cache
# @raycast.mode compact
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 📡
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Flush DNS cache (asks for your admin password)
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Raycast has no terminal, so `sudo` cannot prompt for a password there.
# Use the macOS admin-privileges dialog instead, which works from a GUI process.
if osascript -e 'do shell script "/usr/bin/dscacheutil -flushcache; /usr/bin/killall -HUP mDNSResponder" with administrator privileges' >/dev/null 2>&1; then
    echo "✅ DNS cache flushed"
else
    echo "❌ Failed to flush DNS (cancelled or wrong password)"
    exit 1
fi
