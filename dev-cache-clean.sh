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
# @raycast.description Cleans all development caches: NPM, Watchman, Metro, CocoaPods, Xcode, and Gradle.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

echo "--- 🧹 Development Caches Cleanup Starting ---"

# 1. NPM Cache
echo -e "\n--- 1/6: Cleaning NPM Cache ---"
if command -v npm &> /dev/null; then
    npm cache clean --force
    echo "✅ NPM cache cleaned"
else
    echo "⏭️ NPM not installed, skipping"
fi

# 2. Watchman
echo -e "\n--- 2/6: Cleaning Watchman ---"
if command -v watchman &> /dev/null; then
    watchman watch-del-all
    echo "✅ Watchman watches cleared"
else
    echo "⏭️ Watchman not installed, skipping"
fi

# 3. Metro Cache
echo -e "\n--- 3/6: Cleaning Metro Cache ---"
rm -rf "$TMPDIR"/metro-*
rm -rf "$TMPDIR"/haste-map-*
echo "✅ Metro cache cleaned"

# 4. CocoaPods Cache
echo -e "\n--- 4/6: Cleaning CocoaPods Cache ---"
if command -v pod &> /dev/null; then
    pod cache clean --all
    echo "✅ CocoaPods cache cleaned"
else
    echo "⏭️ CocoaPods not installed, skipping"
fi

# 5. Xcode DerivedData
echo -e "\n--- 5/6: Cleaning Xcode Cache ---"
if [ -d ~/Library/Developer/Xcode/DerivedData ]; then
    rm -rf ~/Library/Developer/Xcode/DerivedData/*
    echo "✅ Xcode DerivedData cleaned"
else
    echo "⏭️ Xcode DerivedData not found, skipping"
fi

# 6. Gradle Cache
echo -e "\n--- 6/6: Cleaning Gradle Cache ---"
rm -rf ~/.gradle/caches/
rm -rf ~/.android/build-cache/
echo "✅ Gradle cache cleaned"

echo -e "\n✅ Development Caches Cleanup Complete!"
