---
description: Read all changed files in current git branch to understand recent work
allowed-tools: Bash, Read, Glob
---

# Catch Up on Changes

Read and summarize all files changed in the current branch compared to main.

## Workflow

1. Get the current branch name
2. Find all changed files compared to main:
   ```bash
   git diff --name-only main...HEAD
   ```
3. For each changed file:
   - Read the file content
   - Note key changes (new functions, modified logic, etc.)
4. Summarize findings:
   - **New files** - What was added and why
   - **Modified files** - Key changes in each
   - **Deleted files** - What was removed
   - **Overall scope** - Brief description of the work

## Usage

Run this command when:
- Resuming work after `/clear`
- Starting a new session on an existing branch
- Needing context on what's been done
- Reviewing changes before creating a PR

## Output Format

Provide a structured summary:

```
## Branch: feature/my-branch

### New Files (X)
- src/new_file.cairo - Description of purpose

### Modified Files (Y)
- src/existing.cairo - Changed X, added Y, removed Z

### Deleted Files (Z)
- src/old_file.cairo - Reason for removal

### Summary
Brief 2-3 sentence summary of the overall changes and their purpose.
```

## Notes

- Skip binary files and build artifacts
- Focus on .cairo, .toml, .md files
- Highlight any TODO comments or incomplete work
- Note any breaking changes or migration needs
