---
description: Stop active Ralph Wiggum loop
allowed-tools: Bash
hide-from-slash-command-tool: true
---

# Ralph Loop Stop
<!-- For detailed documentation on how Ralph Loop works, see: .claude/scripts/README.md -->

```
if [[ -f .claude/ralph-loop.local.md ]]; then
  ITERATION=$(grep '^iteration:' .claude/ralph-loop.local.md | sed 's/iteration: *//')
  STARTED_AT=$(grep '^started_at:' .claude/ralph-loop.local.md | sed 's/started_at: *//' | sed 's/^"\(.*\)"$/\1/')

  # Calculate duration if started_at exists
  DURATION="unknown"
  if [[ -n "$STARTED_AT" ]]; then
    END_TIME=$(date -u +"%Y-%m-%dT%H:%M:%SZ")
    if date --version >/dev/null 2>&1; then
      # GNU date (Linux)
      START_EPOCH=$(date -d "$STARTED_AT" +%s 2>/dev/null || echo "0")
      END_EPOCH=$(date -d "$END_TIME" +%s 2>/dev/null || echo "0")
    else
      # BSD date (macOS)
      START_EPOCH=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$STARTED_AT" +%s 2>/dev/null || echo "0")
      END_EPOCH=$(date -j -f "%Y-%m-%dT%H:%M:%SZ" "$END_TIME" +%s 2>/dev/null || echo "0")
    fi
    if [[ "$START_EPOCH" != "0" ]] && [[ "$END_EPOCH" != "0" ]]; then
      DIFF=$((END_EPOCH - START_EPOCH))
      HOURS=$((DIFF / 3600))
      MINUTES=$(((DIFF % 3600) / 60))
      SECONDS=$((DIFF % 60))
      if [[ $HOURS -gt 0 ]]; then
        DURATION="${HOURS}h ${MINUTES}m ${SECONDS}s"
      elif [[ $MINUTES -gt 0 ]]; then
        DURATION="${MINUTES}m ${SECONDS}s"
      else
        DURATION="${SECONDS}s"
      fi
    fi
  fi

  echo "FOUND_LOOP=true"
  echo "ITERATION=$ITERATION"
  echo "STARTED_AT=$STARTED_AT"
  echo "DURATION=$DURATION"
else
  echo "FOUND_LOOP=false"
fi
```

Check the output above:

1. **If FOUND_LOOP=false**:
   - Say "No active Ralph loop found."
2. **If FOUND_LOOP=true**:
   - Use Bash: `rm .claude/ralph-loop.local.md`
   - Report: "Stopped Ralph loop at iteration N after running for DURATION" using the values from above.
