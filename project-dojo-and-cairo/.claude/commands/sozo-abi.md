---
description: Get ABI and details for a specific contract, model, or event
allowed-tools: sozo, echo, jq
---

Retrieve ABI for contracts, models, or events:

```bash
set -e

PROFILE="${1:-dev}"
TYPE="${2:-contract}"  # contract, model, or event
NAME="$3"

if [ -z "$NAME" ]; then
  echo "Usage: /sozo-inspect-abi [profile] [type] <name>"
  echo ""
  echo "Examples:"
  echo "  /sozo-inspect-abi dev contract actions"
  echo "  /sozo-inspect-abi dev model Player"
  echo "  /sozo-inspect-abi release event GameStarted"
  echo ""
  echo "Available in manifest_$PROFILE.json:"
  echo ""
  echo "Contracts:"
  jq -r '.contracts[]? | "  - \(.name)"' "manifest_$PROFILE.json" 2>/dev/null || echo "  (none found)"
  echo ""
  echo "Models:"
  jq -r '.models[]? | "  - \(.name)"' "manifest_$PROFILE.json" 2>/dev/null || echo "  (none found)"
  echo ""
  echo "Events:"
  jq -r '.events[]? | "  - \(.name)"' "manifest_$PROFILE.json" 2>/dev/null || echo "  (none found)"
  exit 1
fi

MANIFEST="manifest_$PROFILE.json"

if [ ! -f "$MANIFEST" ]; then
  echo "❌ Error: $MANIFEST not found. Run 'sozo migrate --profile $PROFILE' first."
  exit 1
fi

case "$TYPE" in
  contract|c)
    echo "📋 Contract: $NAME (profile: $PROFILE)"
    echo ""
    RESULT=$(jq --arg name "$NAME" '.contracts[]? | select(.name == $name)' "$MANIFEST")

    if [ -z "$RESULT" ]; then
      echo "❌ Contract '$NAME' not found in $MANIFEST"
      exit 1
    fi

    echo "Address: $(echo "$RESULT" | jq -r '.address')"
    echo "Tag: $(echo "$RESULT" | jq -r '.tag')"
    echo "Class Hash: $(echo "$RESULT" | jq -r '.class_hash')"
    echo ""
    echo "ABI Functions:"
    echo "$RESULT" | jq -r '.class.abi[] | select(.type == "interface") | .items[] | select(.type == "function") | "  - \(.name)(\(.inputs | map(.name) | join(", ")))"'
    echo ""
    echo "Full ABI:"
    echo "$RESULT" | jq '.class.abi'
    ;;

  model|m)
    echo "📊 Model: $NAME (profile: $PROFILE)"
    echo ""
    RESULT=$(jq --arg name "$NAME" '.models[]? | select(.name == $name)' "$MANIFEST")

    if [ -z "$RESULT" ]; then
      echo "❌ Model '$NAME' not found in $MANIFEST"
      exit 1
    fi

    echo "Class Hash: $(echo "$RESULT" | jq -r '.class_hash')"
    echo ""
    echo "ABI:"
    echo "$RESULT" | jq '.class.abi'
    ;;

  event|e)
    echo "📡 Event: $NAME (profile: $PROFILE)"
    echo ""
    RESULT=$(jq --arg name "$NAME" '.events[]? | select(.name == $name)' "$MANIFEST")

    if [ -z "$RESULT" ]; then
      echo "❌ Event '$NAME' not found in $MANIFEST"
      exit 1
    fi

    echo "Class Hash: $(echo "$RESULT" | jq -r '.class_hash')"
    echo ""
    echo "ABI:"
    echo "$RESULT" | jq '.class.abi'
    ;;

  *)
    echo "❌ Unknown type: $TYPE"
    echo "Valid types: contract, model, event"
    exit 1
    ;;
esac
```

Usage:
- `/sozo-abi dev contract actions` - Get actions contract ABI
- `/sozo-abi dev model Player` - Get Player model structure
- `/sozo-abi release event GameStarted` - Get GameStarted event ABI
