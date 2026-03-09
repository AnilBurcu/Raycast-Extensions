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
# @raycast.description Update, upgrade & cleanup homebrew
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

echo "Running brew maintenance..."
echo ""

echo "> brew update"
brew update

echo ""
echo "> brew upgrade"
brew upgrade

echo ""
echo "> brew cleanup"
brew cleanup --prune=all

echo ""
echo "> brew autoremove"
brew autoremove

echo ""
echo "> brew doctor"
brew doctor

echo ""
echo "Done."
