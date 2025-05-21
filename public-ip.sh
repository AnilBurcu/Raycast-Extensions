#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Get Public IP Address
# @raycast.mode compact
# @raycast.packageName System

# Optional parameters:
# @raycast.icon 🛜

# Documentation:
# @raycast.author Perikles B

# Fetch public IP using the ifconfig.me API
PUBLIC_IP=$(curl -s ifconfig.me)

# Output the result in Raycast
echo "🌐 Your Public IP: $PUBLIC_IP"
