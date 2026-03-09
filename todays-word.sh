#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Today's Word
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📖

# Documentation:
# @raycast.description Displays a daily English word with its definition, pronunciation, and usage example.
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

# Curated word list
WORDS=("serendipity" "ephemeral" "ubiquitous" "eloquent" "resilience" "pragmatic" "ambiguous" "meticulous" "candid" "diligent" "enigma" "lucid" "paradigm" "benevolent" "tenacious" "profound" "vivacious" "audacious" "cogent" "fervent" "mundane" "pristine" "quintessential" "sagacious" "voracious" "zealous" "astute" "brevity" "capricious" "deft" "euphoria" "fortuitous" "gregarious" "harbinger" "idyllic" "juxtapose" "keen" "lethargic" "maverick" "nonchalant" "ominous" "penchant" "quixotic" "rampant" "stoic" "taciturn" "urbane" "verbose" "whimsical" "xenial")

# Pick a word based on the current date (changes daily)
DAY_OF_YEAR=$(date +%j)
INDEX=$((10#$DAY_OF_YEAR % ${#WORDS[@]}))
WORD="${WORDS[$INDEX]}"
UPPER_WORD=$(echo "$WORD" | tr '[:lower:]' '[:upper:]')

# Fetch definition from Free Dictionary API
RESPONSE=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$WORD")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"title":"No Definitions Found"'; then
    echo "❌ Could not fetch definition"
    exit 1
fi

PHONETIC=$(echo "$RESPONSE" | grep -o '"phonetic":"[^"]*' | head -1 | cut -d'"' -f4)
PART=$(echo "$RESPONSE" | grep -o '"partOfSpeech":"[^"]*' | head -1 | cut -d'"' -f4)
DEFINITION=$(echo "$RESPONSE" | grep -o '"definition":"[^"]*' | head -1 | cut -d'"' -f4)
EXAMPLE=$(echo "$RESPONSE" | grep -o '"example":"[^"]*' | head -1 | cut -d'"' -f4)

echo "╔══════════════════════════════════════════╗"
echo "║            📖 TODAY'S WORD               ║"
echo "╠══════════════════════════════════════════╣"
echo "║"
echo "║  $UPPER_WORD"
if [ -n "$PHONETIC" ]; then
    echo "║  $PHONETIC  ·  $PART"
elif [ -n "$PART" ]; then
    echo "║  $PART"
fi
echo "║"
echo "╠══════════════════════════════════════════╣"
echo "║"
if [ -n "$DEFINITION" ]; then
    echo "║  Definition:"
    echo "║  $DEFINITION" | fold -s -w 42 | while IFS= read -r line; do echo "║  $line"; done
fi
echo "║"
if [ -n "$EXAMPLE" ]; then
    echo "║  Example:"
    echo "║  \"$EXAMPLE\"" | fold -s -w 42 | while IFS= read -r line; do echo "║  $line"; done
    echo "║"
fi
echo "╚══════════════════════════════════════════╝"
