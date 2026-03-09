#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Homebrew Maintenance
# @raycast.mode fullOutput
# @raycast.packageName System Maintenance

# Optional parameters:
# @raycast.icon 🍺
# @raycast.currentDirectoryPath ~

# Documentation:
# @raycast.description Updates, upgrades, cleans, and checks for issues with Homebrew packages.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

echo "--- 🍺 Homebrew Maintenance Starting ---"

# 1. Update Homebrew
echo -e "\n--- 1/5: Updating Homebrew ---"
brew update

# 2. Upgrade Packages
echo -e "\n--- 2/5: Upgrading Packages ---"
brew upgrade

# 3. Cleanup Old Versions
echo -e "\n--- 3/5: Cleaning Up Old Versions ---"
brew cleanup --prune=all

# 4. Remove Unused Dependencies
echo -e "\n--- 4/5: Removing Unused Dependencies ---"
brew autoremove

# 5. Health Check
echo -e "\n--- 5/5: Running Health Check ---"
brew doctor

echo -e "\n✅ Homebrew Maintenance Complete!"