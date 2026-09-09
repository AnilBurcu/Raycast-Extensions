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

if ! command -v jq &> /dev/null; then
    echo "jq is required (built into macOS 15+, or: brew install jq)"
    exit 1
fi

WORDS=("aplomb" "brusque" "cajole" "debacle" "ennui" "facetious" "gambit" "hubris" "impetus" "jargon" "kudos" "lampoon" "morose" "nominal" "obtuse" "pallid" "quorum" "rebuke" "snide" "terse" "uncanny" "vendetta" "wanton" "yearning" "zeal" "blunder" "crux" "droll" "fickle" "glib" "hapless" "inept" "jarring" "knack" "lopsided" "murky" "nifty" "offhand" "plucky" "quaint" "rickety" "savvy" "thrifty" "upshot" "vexed" "wily" "botch" "dingy" "flimsy" "gripe")

DAY_OF_YEAR=$(date +%j)
INDEX=$((10#$DAY_OF_YEAR % ${#WORDS[@]}))
WORD="${WORDS[$INDEX]}"

RESPONSE=$(curl -sf --max-time 15 "https://api.dictionaryapi.dev/api/v2/entries/en/$WORD")

if [ -z "$RESPONSE" ]; then
    echo "Dictionary API unreachable (api.dictionaryapi.dev) -- word was: $WORD"
    exit 1
fi

if ! echo "$RESPONSE" | jq -e 'type == "array" and length > 0' >/dev/null 2>&1; then
    echo "No definition found for: $WORD"
    exit 1
fi

PHONETIC=$(echo "$RESPONSE" | jq -r '.[0] | ([.phonetic // empty] + [.phonetics[]?.text // empty]) | map(select(. != "")) | first // ""')
PART=$(echo "$RESPONSE" | jq -r '.[0].meanings[0].partOfSpeech // ""')
DEFINITION=$(echo "$RESPONSE" | jq -r '.[0].meanings[0].definitions[0].definition // ""')
EXAMPLE=$(echo "$RESPONSE" | jq -r '[.[0].meanings[].definitions[].example // empty] | first // ""')

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
