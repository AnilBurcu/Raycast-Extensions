#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Flush DNS Cache
# @raycast.mode compact
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🧹
# @raycast.needsConfirmation true

# Documentation:
# @raycast.description Flushes the macOS DNS cache by restarting mDNSResponder.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Flush DNS cache
sudo /usr/bin/dscacheutil -flushcache
sudo /usr/bin/killall -HUP mDNSResponder

echo "🧹 DNS cache flushed!"
