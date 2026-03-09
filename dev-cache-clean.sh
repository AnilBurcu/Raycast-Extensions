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
# @raycast.description Cleans all development caches: NPM, Watchman, Metro, CocoaPods, Xcode, Gradle
# @raycast.author Perikles

echo "--- 🧹 Development Caches Cleanup Starting ---"

# 1. NPM Cache
echo -e "\n--- 1/6: Cleaning NPM Cache ---"
npm cache clean --force
if [ $? -eq 0 ]; then
    echo "✅ NPM cache cleaned"
else
    echo "❌ NPM cache cleanup failed"
fi

# 2. Watchman
echo -e "\n--- 2/6: Cleaning Watchman ---"
watchman watch-del-all
echo "✅ Watchman watches cleared"

# 3. Metro Cache
echo -e "\n--- 3/6: Cleaning Metro Cache ---"
rm -rf $TMPDIR/metro-*
rm -rf $TMPDIR/haste-map-*
echo "✅ Metro cache cleaned"

# 4. CocoaPods Cache
echo -e "\n--- 4/6: Cleaning CocoaPods Cache ---"
pod cache clean --all
echo "✅ CocoaPods cache cleaned"

# 5. Xcode DerivedData
echo -e "\n--- 5/6: Cleaning Xcode Cache ---"
rm -rf ~/Library/Developer/Xcode/DerivedData/*
echo "✅ Xcode DerivedData cleaned"

# 6. Gradle Cache
echo -e "\n--- 6/6: Cleaning Gradle Cache ---"
rm -rf ~/.gradle/caches/
rm -rf ~/.android/build-cache/
echo "✅ Gradle cache cleaned"

echo -e "\n✅ Development Caches Cleanup Complete!"