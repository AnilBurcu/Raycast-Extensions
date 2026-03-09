#!/bin/bash
# @raycast.schemaVersion 1
# @raycast.title Flush DNS Cache
# @raycast.mode compact
# @raycast.packageName System
# @raycast.icon 🧹
# @raycast.author Perikles B

# DNS cache temizle (artık şifre sormuyor)
sudo /usr/bin/dscacheutil -flushcache
sudo /usr/bin/killall -HUP mDNSResponder

echo "🧹 DNS Cache temizlendi!"