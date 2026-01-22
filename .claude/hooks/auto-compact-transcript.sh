#!/bin/bash
INPUT=$(cat)
TRANSCRIPT=$(echo "$INPUT" | jq -r '.transcript_path')
BACKUP_DIR=~/.claude/backups/auto
mkdir -p "$BACKUP_DIR"
cp "$TRANSCRIPT" "$BACKUP_DIR/$(date +%Y%m%d_%H%M%S)_transcript.jsonl"
