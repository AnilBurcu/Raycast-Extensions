#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Flush DNS Cache
# @raycast.mode compact
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🧹

# Documentation:
# @raycast.author Perikles B

# Flush DNS cache (requires sudo, so it will prompt you for your password)
sudo killall -HUP mDNSResponder

# Output the result in Raycast
echo "🔄 DNS Cache Flushed!"
