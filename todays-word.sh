#!/bin/bash

# Required parameters:
# @raycast.schemaVersion 1
# @raycast.title Today's Word
# @raycast.mode fullOutput
# @raycast.packageName Learning

# Optional parameters:
# @raycast.icon 📖

# Documentation:
# @raycast.description Word of the day
# @raycast.author Perikles
# @raycast.authorURL https://github.com/AnilBurcu

WORDS=("aplomb" "brusque" "cajole" "debacle" "ennui" "facetious" "gambit" "hubris" "impetus" "jargon" "kudos" "lampoon" "morose" "nominal" "obtuse" "pallid" "quorum" "rebuke" "snide" "terse" "uncanny" "vendetta" "wanton" "yearning" "zeal" "blunder" "crux" "droll" "fickle" "glib" "hapless" "inept" "jarring" "knack" "lopsided" "murky" "nifty" "offhand" "plucky" "quaint" "rickety" "savvy" "thrifty" "upshot" "vexed" "wily" "botch" "dingy" "flimsy" "gripe")

DAY_OF_YEAR=$(date +%j)
INDEX=$((10#$DAY_OF_YEAR % ${#WORDS[@]}))
WORD="${WORDS[$INDEX]}"

RESPONSE=$(curl -s "https://api.dictionaryapi.dev/api/v2/entries/en/$WORD")

if [ -z "$RESPONSE" ] || echo "$RESPONSE" | grep -q '"title":"No Definitions Found"'; then
    echo "No definition found for: $WORD"
    exit 1
fi

PHONETIC=$(echo "$RESPONSE" | grep -o '"phonetic":"[^"]*' | head -1 | cut -d'"' -f4)
PART=$(echo "$RESPONSE" | grep -o '"partOfSpeech":"[^"]*' | head -1 | cut -d'"' -f4)
DEFINITION=$(echo "$RESPONSE" | grep -o '"definition":"[^"]*' | head -1 | cut -d'"' -f4)
EXAMPLE=$(echo "$RESPONSE" | grep -o '"example":"[^"]*' | head -1 | cut -d'"' -f4)

echo "Word of the Day"
echo ""
echo "  $WORD"
if [ -n "$PHONETIC" ] && [ -n "$PART" ]; then
    echo "  $PHONETIC ($PART)"
elif [ -n "$PART" ]; then
    echo "  ($PART)"
fi
echo ""
if [ -n "$DEFINITION" ]; then
    echo "  $DEFINITION" | fold -s -w 55
fi
if [ -n "$EXAMPLE" ]; then
    echo ""
    echo "  e.g. \"$EXAMPLE\"" | fold -s -w 55
fi
