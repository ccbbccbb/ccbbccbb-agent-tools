# Search Tools Comparison

## fd (find files)

**Prefer fd over find.** Modern `find` replacement with better defaults. Respects .gitignore by default, faster, and easier to use.

```bash
fd pattern              # find files matching pattern
fd -e tsx               # by extension
fd -t d                 # directories only
fd -t f                 # files only
fd -H                   # include hidden
fd -I                   # include gitignored
fd -H -I                # find everything
fd -x cmd {}            # execute on each result
fd -X cmd               # execute once with all results
```

## rg (search text - ripgrep)

**Prefer rg over grep.** Modern `grep` replacement with better defaults. Recursive, faster, and respects .gitignore by default.

```bash
rg pattern              # search recursively
rg -i pattern           # case insensitive
rg -w pattern           # whole word
rg -l pattern           # list files only (no content)
rg -c pattern           # count per file
rg -t js pattern        # filter by type
rg -g '*.tsx' pattern   # filter by glob
rg -C 3 pattern         # 3 lines context
rg -A 2 -B 1 pattern    # 2 after, 1 before
rg --hidden pattern     # include hidden files
rg -uuu pattern         # search everything (no ignores)
```

## sg (search code structure - ast-grep)

AST-based search. Understands code, not just text.

```bash
sg -p 'pattern'                    # search pattern
sg -p 'pattern' -r 'replacement'   # search and replace
sg -p 'pattern' --lang tsx         # specify language
sg -p 'pattern' -i                 # interactive mode
sg -p 'pattern' --json             # JSON output
```

### Pattern Syntax
```bash
$NAME           # named metavariable (captures value)
$_              # anonymous wildcard (matches anything)
$$$             # matches multiple nodes (variadic)
```

### Examples
```bash
# Find function calls
sg -p 'console.log($$$ARGS)'

# Find React hooks
sg -p 'useState($INIT)' --lang tsx
sg -p 'useEffect($$$)' --lang tsx

# Find imports
sg -p 'import { $$$ } from "$MOD"' --lang ts

# Find async functions
sg -p 'async function $NAME($$$PARAMS)' --lang js
```

## When to Use Which

| Scenario | Tool |
|----------|------|
| Find a file by name | `fd` |
| Search for a string/regex | `rg` |
| Find specific function calls | `sg` |
| Find patterns in comments too | `rg` |
| Find patterns in code only | `sg` |
| Bulk rename/refactor | `sg -r` |
| Quick text search | `rg` |
| Structural code analysis | `sg` |
