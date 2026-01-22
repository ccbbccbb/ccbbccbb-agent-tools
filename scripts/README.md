# Scripts

## sync-claude.sh

Syncs `.claude/` from this repo to `~/.claude/` with backup and confirmation.

### Usage

```bash
./scripts/sync-claude.sh
```

### What it syncs

| Item | Description |
|------|-------------|
| `commands/` | Slash commands |
| `hooks/` | Automation scripts |
| `sfx/` | Audio notification files |
| `skills/` | Skill definitions |
| `CLAUDE.md` | Global instructions |
| `settings.json` | Permissions, hooks, sandbox config |

### How it works

**Part 1: Analyze & Backup**

1. Compares repo `.claude/` with `~/.claude/`
2. Shows exactly what will change:
   - `~ Modified` - files that differ, will be overwritten
   - `+ New` - files only in repo, will be added
   - `- Removed` - files only in target, will be deleted
3. Prompts `(y/N)` to create backup
4. Backs up only files that will be modified or deleted to `backup/claude-YYYY-MM-DD-HH-MM/`

**Part 2: Apply Changes**

1. Shows summary of all changes again
2. Prompts for `CONFIRM` to proceed (anything else cancels)
3. Copies repo files to target
4. Deletes files that no longer exist in repo
5. Shows revert command if needed

### Reverting

If something goes wrong, restore from backup:

```bash
cp -r backup/claude-YYYY-MM-DD-HH-MM/* ~/.claude/
```

### Notes

- Backups are stored in `backup/` (gitignored)
- `.DS_Store` files are ignored during comparison
- Script exits safely at any prompt without making changes
