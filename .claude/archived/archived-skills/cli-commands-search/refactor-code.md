# Refactoring with ast-grep

## Basic Refactoring

### Preview changes
```bash
sg -p 'OLD_PATTERN' -r 'NEW_PATTERN'
```

### Apply changes
```bash
sg -p 'OLD_PATTERN' -r 'NEW_PATTERN' -U
```

## Common Refactors

### var to const
```bash
sg -p 'var $X = $Y' -r 'const $X = $Y' --lang js
```

### console.log removal
```bash
sg -p 'console.log($$$)' -r '' --lang js
```

### Rename function calls
```bash
sg -p 'oldFunc($$$ARGS)' -r 'newFunc($$$ARGS)'
```

### Update imports
```bash
sg -p 'import { $$$IMPORTS } from "old-lib"' \
   -r 'import { $$$IMPORTS } from "new-lib"'
```

## React Refactors

### Class to function component
```bash
# Find class components
sg -p 'class $NAME extends React.Component'

# Manual refactor guided by results
```

### Update hook patterns
```bash
# Find useState without type
sg -p 'useState($INIT)'

# Find useEffect without deps
sg -p 'useEffect($FN)'
```

### Prop spreading
```bash
sg -p '<$COMP {...$PROPS} />'
```

## Workflow

### 1. Find patterns to refactor
```bash
sg -p 'pattern' --json | jq '.[] | .file' | sort -u
```

### 2. Preview changes
```bash
sg -p 'old' -r 'new'
```

### 3. Apply to specific files
```bash
sg -p 'old' -r 'new' src/specific-file.ts
```

### 4. Apply everywhere
```bash
sg -p 'old' -r 'new' -U
```

### 5. Verify
```bash
# Check no patterns remain
sg -p 'old'

# Run tests/linter
```

## Tips

- Always preview before `-U` (update)
- Use `--lang` to avoid false matches
- Use `$$$` for variadic captures
- Combine with `fd` to limit scope:
  ```bash
  fd -e tsx -x sg -p 'pattern' {}
  ```
