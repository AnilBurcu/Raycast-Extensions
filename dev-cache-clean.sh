#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Clean Development Caches
# @raycast.mode fullOutput
# @raycast.packageName Development Tools

# Optional parameters:
# @raycast.icon 🧹
# @raycast.currentDirectoryPath ~

# Documentation:
# @raycast.description Nuke dev caches (npm, pods, xcode, gradle, etc)
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

echo "Cleaning dev caches..."
echo ""

if command -v npm &> /dev/null; then
    echo "npm cache clean --force"
    npm cache clean --force
else
    echo "npm not found, skipping"
fi

if command -v watchman &> /dev/null; then
    echo "watchman watch-del-all"
    watchman watch-del-all
else
    echo "watchman not found, skipping"
fi

echo "clearing metro/haste temp files"
rm -rf "$TMPDIR"/metro-*
rm -rf "$TMPDIR"/haste-map-*

if command -v pod &> /dev/null; then
    echo "pod cache clean --all"
    pod cache clean --all
else
    echo "cocoapods not found, skipping"
fi

if [ -d ~/Library/Developer/Xcode/DerivedData ]; then
    echo "rm -rf DerivedData/*"
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
else
    echo "no DerivedData folder, skipping"
fi

echo "clearing gradle caches"
rm -rf ~/.gradle/caches/
rm -rf ~/.android/build-cache/

echo ""
echo "All done."
