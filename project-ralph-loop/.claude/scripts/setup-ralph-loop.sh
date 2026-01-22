#!/bin/bash
# Ralph Wiggum Loop Setup Script
# Creates the state file that activates the stop hook
#
# For detailed documentation on how Ralph Loop works, see:
# .claude/scripts/README.md

set -euo pipefail

# Parse arguments
PROMPT=""
MAX_ITERATIONS=0
COMPLETION_PROMISE="null"

while [[ $# -gt 0 ]]; do
  case $1 in
    --max-iterations)
      MAX_ITERATIONS="$2"
      shift 2
      ;;
    --completion-promise)
      COMPLETION_PROMISE="$2"
      shift 2
      ;;
    *)
      # Everything else is part of the prompt
      if [ -z "$PROMPT" ]; then
        PROMPT="$1"
      else
        PROMPT="$PROMPT $1"
      fi
      shift
      ;;
  esac
done

# Validate inputs
if [ -z "$PROMPT" ]; then
  echo "Error: No prompt provided" >&2
  echo "Usage: /ralph-loop \"Your prompt\" [--max-iterations N] [--completion-promise TEXT]" >&2
  exit 1
fi

if ! [[ "$MAX_ITERATIONS" =~ ^[0-9]+$ ]]; then
  echo "Error: --max-iterations must be a number" >&2
  exit 1
fi

# Create .claude directory if it doesn't exist
mkdir -p .claude

# Get current timestamp in ISO 8601 format
STARTED_AT=$(date -u +"%Y-%m-%dT%H:%M:%SZ")

# Create state file with frontmatter
cat > .claude/ralph-loop.local.md <<EOF
---
active: true
iteration: 1
max_iterations: $MAX_ITERATIONS
completion_promise: "$COMPLETION_PROMISE"
started_at: "$STARTED_AT"
---

$PROMPT
EOF

echo "✅ Ralph loop initialized"
echo "   Started at: $STARTED_AT"
echo "   Max iterations: $MAX_ITERATIONS (0 = unlimited)"
if [ "$COMPLETION_PROMISE" != "null" ]; then
  echo "   Completion promise: $COMPLETION_PROMISE"
fi
echo ""
echo "The loop will start on your next message."
