#!/bin/bash
# .claude/hooks/save-plan-to-repo.sh
# Copies plan files with YAML frontmatter and smart filenames

INPUT=$(cat)
LOCAL_PLANS_DIR="$(pwd)/.claude/plans"
mkdir -p "$LOCAL_PLANS_DIR"

# Extract data from hook payload
PLAN_PATH=$(echo "$INPUT" | jq -r '.tool_response.filePath // empty')
TRANSCRIPT_PATH=$(echo "$INPUT" | jq -r '.transcript_path // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

[[ -z "$PLAN_PATH" || ! -f "$PLAN_PATH" ]] && exit 0

# Extract project folder name (last component of path)
PROJECT_NAME=$(basename "$CWD")

# Generate smart filename from H1
FIRST_LINE=$(head -1 "$PLAN_PATH" | sed 's/^#[[:space:]]*//')
SMART_NAME=$(echo "$FIRST_LINE" | \
    tr '[:lower:]' '[:upper:]' | \
    sed 's/[^A-Z0-9 ]//g' | \
    tr ' ' '-' | \
    sed 's/-\{2,\}/-/g' | \
    sed 's/^-//;s/-$//')

# Fallback if smart name is empty
[[ -z "$SMART_NAME" ]] && SMART_NAME="PLAN-$(date +%Y%m%d%H%M%S)"

FINAL_NAME="${SMART_NAME}.md"

# Extract most recent prompt from transcript (last actual human message, not tool results)
INITIAL_PROMPT="N/A"
if [[ -n "$TRANSCRIPT_PATH" && -f "$TRANSCRIPT_PATH" ]]; then
    INITIAL_PROMPT=$(jq -rs '
        [.[] | select(.type == "user") | select(.message.content | type == "string")] |
        .[-1].message.content // "N/A" |
        gsub("\n"; " ") |
        gsub("  +"; " ") |
        .[0:500]
    ' "$TRANSCRIPT_PATH" 2>/dev/null || echo "N/A")
fi

# Escape quotes in prompt for YAML
INITIAL_PROMPT=$(echo "$INITIAL_PROMPT" | sed 's/"/\\"/g')

# Create file with frontmatter
{
    echo "---"
    echo "plan: $SMART_NAME"
    echo "project: $PROJECT_NAME"
    echo "created: $(date '+%Y-%m-%d %H:%M:%S')"
    echo "prompt: \"$INITIAL_PROMPT\""
    echo "---"
    echo ""
    cat "$PLAN_PATH"
} > "$LOCAL_PLANS_DIR/$FINAL_NAME"

exit 0
