---
name: cli-tools
description: Modern CLI tools for searching code (rg, sg, fd), directory listing (tree), git operations (delta, gh), and JSON parsing (jq). Use when searching codebases, refactoring code, or running shell commands. Prefer fd over find and rg over grep.
---

# CLI Tools

## When to Use Which Search Tool

| Task | Tool | Example |
|------|------|---------|
| Find files by name | `fd` | `fd component -e tsx` |
| Search text/regex in files | `rg` | `rg "TODO" -t js` |
| Search code structure (AST) | `sg` | `sg -p 'console.log($A)'` |
| Refactor code patterns | `sg` | `sg -p 'var $X' -r 'const $X'` |

**Key difference: rg vs sg**
- `rg` finds text anywhere (comments, strings, code)
- `sg` finds actual code patterns only (understands AST)

```bash
# rg finds ALL occurrences (3 matches)
rg 'console.log'

# sg finds only actual function calls (1 match)
sg -p 'console.log($$$ARGS)'
```

## Quick Reference

### Searching
```bash
fd pattern                    # find files
rg pattern                    # search text in files
sg -p 'code($PATTERN)'        # search code structure
```

### Viewing
```bash
tree -L 2                     # directory tree
# Use Claude Code's built-in Read tool for file contents
```

### Git
```bash
gh pr list                    # GitHub PRs
# delta: auto-configured as git diff pager
```

### Processing
```bash
jq '.field'                   # parse JSON
```

## Detailed Reference

For complete flags and examples:
- Search tools comparison → [context/search-tools.md](context/search-tools.md)
- All tool reference → [context/tool-reference.md](context/tool-reference.md)

## Workflows

- Searching codebases → [workflows/code-search.md](workflows/code-search.md)
- Refactoring with ast-grep → [workflows/refactor-code.md](workflows/refactor-code.md)
