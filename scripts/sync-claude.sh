#!/bin/bash
set -e

# Get repo root (parent of scripts/)
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
REPO_ROOT="$(dirname "$SCRIPT_DIR")"

REPO_CLAUDE="$REPO_ROOT/.claude"
BACKUP_DIR="$REPO_ROOT/backup"
TIMESTAMP=$(date +%Y-%m-%d-%H-%M)

TARGET_CLAUDE="$HOME/.claude"

# Items to sync
SYNC_ITEMS=("commands" "hooks" "sfx" "skills" "CLAUDE.md" "settings.json")

# Collect changes
CHANGED=()
NEW_FILES=()
REMOVED=()

find_changes() {
  for item in "${SYNC_ITEMS[@]}"; do
    repo_path="$REPO_CLAUDE/$item"
    target_path="$TARGET_CLAUDE/$item"

    if [[ ! -e "$repo_path" ]]; then
      # Item removed from repo but exists in target
      if [[ -e "$target_path" ]]; then
        REMOVED+=("$item")
      fi
      continue
    fi

    if [[ -d "$repo_path" ]]; then
      # Directory: use diff -rq, exclude .DS_Store
      diff_output=$(diff -rq --exclude='.DS_Store' "$repo_path" "$target_path" 2>/dev/null || true)
      if [[ -n "$diff_output" ]]; then
        while IFS= read -r line; do
          if [[ "$line" == "Files"* ]]; then
            file=$(echo "$line" | sed 's/Files \(.*\) and .*/\1/')
            rel_path="${file#$REPO_CLAUDE/}"
            CHANGED+=("$rel_path")
          elif [[ "$line" == "Only in $REPO_CLAUDE"* ]]; then
            subpath=$(echo "$line" | sed "s|Only in $REPO_CLAUDE||" | sed 's|: |/|' | sed 's|^/||')
            NEW_FILES+=("$subpath")
          elif [[ "$line" == "Only in $TARGET_CLAUDE"* ]]; then
            subpath=$(echo "$line" | sed "s|Only in $TARGET_CLAUDE||" | sed 's|: |/|' | sed 's|^/||')
            REMOVED+=("$subpath")
          fi
        done <<< "$diff_output"
      fi
    else
      # File: direct diff
      if [[ ! -e "$target_path" ]]; then
        NEW_FILES+=("$item")
      elif ! diff -q "$repo_path" "$target_path" >/dev/null 2>&1; then
        CHANGED+=("$item")
      fi
    fi
  done
}

# ============================================================================
# PART 1: Analyze & Backup
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  PART 1: Analyze & Backup                                      ║"
echo "║                                                                ║"
echo "║  This part will:                                               ║"
echo "║    1. Compare repo .claude/ with target .claude/               ║"
echo "║    2. Show you exactly what will change                        ║"
echo "║    3. Create a full backup of target before any changes        ║"
echo "║                                                                ║"
echo "║  NO files will be modified until Part 2.                       ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "Source (repo):  $REPO_CLAUDE"
echo "Target (home):  $TARGET_CLAUDE"
echo ""
echo "Analyzing differences..."
echo ""

find_changes

# Count totals
total=$((${#CHANGED[@]} + ${#NEW_FILES[@]} + ${#REMOVED[@]}))

# Check if any changes
if [[ $total -eq 0 ]]; then
  echo "No changes detected. Target is already in sync with repo."
  exit 0
fi

echo "═══════════════════════════════════════════════════════════════════"
echo "CHANGES DETECTED: $total file(s)"
echo "═══════════════════════════════════════════════════════════════════"
echo ""

# Display changes with explanations
if [[ ${#CHANGED[@]} -gt 0 ]]; then
  echo "MODIFIED (${#CHANGED[@]} files) - will be overwritten in target:"
  for f in "${CHANGED[@]}"; do echo "  ~ $f"; done
  echo ""
fi

if [[ ${#NEW_FILES[@]} -gt 0 ]]; then
  echo "NEW (${#NEW_FILES[@]} files) - exist in repo, will be added to target:"
  for f in "${NEW_FILES[@]}"; do echo "  + $f"; done
  echo ""
fi

if [[ ${#REMOVED[@]} -gt 0 ]]; then
  echo "REMOVED (${#REMOVED[@]} files) - deleted from repo, will be deleted from target:"
  for f in "${REMOVED[@]}"; do echo "  - $f"; done
  echo ""
fi

echo "═══════════════════════════════════════════════════════════════════"
echo ""

# Prompt for backup
read -p "Create backup and continue? (y/N) " confirm
if [[ "$confirm" != "y" && "$confirm" != "Y" ]]; then
  echo "Aborted."
  exit 0
fi

# Create backup (only changed and removed files)
BACKUP_PATH="$BACKUP_DIR/claude-$TIMESTAMP"
mkdir -p "$BACKUP_PATH"

echo ""
echo "Backing up files that will be modified or deleted..."

# Backup modified files
for item in "${CHANGED[@]}"; do
  target_path="$TARGET_CLAUDE/$item"
  if [[ -e "$target_path" ]]; then
    # Create parent directory structure in backup
    backup_dest="$BACKUP_PATH/$item"
    mkdir -p "$(dirname "$backup_dest")"
    cp "$target_path" "$backup_dest"
    echo "  ~ $item"
  fi
done

# Backup removed files
for item in "${REMOVED[@]}"; do
  target_path="$TARGET_CLAUDE/$item"
  if [[ -e "$target_path" ]]; then
    backup_dest="$BACKUP_PATH/$item"
    mkdir -p "$(dirname "$backup_dest")"
    if [[ -d "$target_path" ]]; then
      cp -r "$target_path" "$backup_dest"
    else
      cp "$target_path" "$backup_dest"
    fi
    echo "  - $item"
  fi
done

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "PART 1 COMPLETE - Backup saved"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Backup location: $BACKUP_PATH"
echo ""
echo "You can review the backup now if needed."
echo ""

# ============================================================================
# PART 2: Apply Changes
# ============================================================================

echo "╔════════════════════════════════════════════════════════════════╗"
echo "║  PART 2: Apply Changes                                         ║"
echo "╚════════════════════════════════════════════════════════════════╝"
echo ""
echo "The following changes will be applied to: $TARGET_CLAUDE"
echo ""

if [[ ${#CHANGED[@]} -gt 0 ]]; then
  echo "OVERWRITE (${#CHANGED[@]} files):"
  for f in "${CHANGED[@]}"; do echo "  ~ $f"; done
  echo ""
fi

if [[ ${#NEW_FILES[@]} -gt 0 ]]; then
  echo "ADD (${#NEW_FILES[@]} files):"
  for f in "${NEW_FILES[@]}"; do echo "  + $f"; done
  echo ""
fi

if [[ ${#REMOVED[@]} -gt 0 ]]; then
  echo "DELETE (${#REMOVED[@]} files):"
  for f in "${REMOVED[@]}"; do echo "  - $f"; done
  echo ""
fi

echo "═══════════════════════════════════════════════════════════════════"
echo "Type CONFIRM to proceed, or anything else to cancel."
echo "═══════════════════════════════════════════════════════════════════"
echo ""

read -p "> " user_input
if [[ "$user_input" != "CONFIRM" ]]; then
  echo ""
  echo "Cancelled. No changes were made to target."
  echo "Backup remains at: $BACKUP_PATH"
  exit 0
fi

echo ""
echo "Applying changes..."
echo ""

# Copy all items from repo to target
for item in "${SYNC_ITEMS[@]}"; do
  repo_path="$REPO_CLAUDE/$item"
  target_path="$TARGET_CLAUDE/$item"

  if [[ -e "$repo_path" ]]; then
    if [[ -d "$repo_path" ]]; then
      rm -rf "$target_path"
      cp -r "$repo_path" "$target_path"
    else
      cp "$repo_path" "$target_path"
    fi
    echo "  Synced: $item"
  fi
done

# Remove files that no longer exist in repo
for item in "${REMOVED[@]}"; do
  target_path="$TARGET_CLAUDE/$item"
  if [[ -e "$target_path" ]]; then
    rm -rf "$target_path"
    echo "  Removed: $item"
  fi
done

echo ""
echo "═══════════════════════════════════════════════════════════════════"
echo "SYNC COMPLETE"
echo "═══════════════════════════════════════════════════════════════════"
echo ""
echo "Changes applied to: $TARGET_CLAUDE"
echo ""
echo "To revert, restore from backup:"
echo "  cp -r $BACKUP_PATH/* $TARGET_CLAUDE/"
echo ""
