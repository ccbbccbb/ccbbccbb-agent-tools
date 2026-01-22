#!/usr/bin/env -S uv run --script
# /// script
# requires-python = ">=3.11"
# [tool.uv]
# exclude-newer = "2026-01-05T00:00:00Z"
# ///
"""
PreToolUse hook for CLI tool substitution.
Replaces legacy tools with modern equivalents when syntax is 100% compatible.

Usage: Automatically invoked by Claude Code via PreToolUse hook.
Reads JSON from stdin, outputs JSON to stdout.
"""
import json
import sys
import re

# Substitution rules: (pattern, replacement_template, reason)
SUBSTITUTIONS = [
    # grep → rg (common flags with 100% parity)
    (r'^grep\s+"([^"]+)"\s+([^\s|]+)$', r'rg "\1" \2', 'grep → rg'),
    (r'^grep\s+-i\s+"([^"]+)"\s+([^\s|]+)$', r'rg -i "\1" \2', 'grep -i → rg -i'),
    (r'^grep\s+-r\s+"([^"]+)"\s+\.$', r'rg "\1"', 'grep -r → rg'),
]

def main():
    data = json.load(sys.stdin)

    if data.get("tool_name") != "Bash":
        sys.exit(0)

    cmd = data.get("tool_input", {}).get("command", "")

    # Try each substitution rule
    for pattern, replacement, reason in SUBSTITUTIONS:
        if re.match(pattern, cmd):
            modified = re.sub(pattern, replacement, cmd)
            print(json.dumps({
                "hookSpecificOutput": {
                    "hookEventName": "PreToolUse",
                    "permissionDecision": "allow",
                    "permissionDecisionReason": reason,
                    "updatedInput": {"command": modified}
                }
            }))
            break

    sys.exit(0)

if __name__ == "__main__":
    main()
