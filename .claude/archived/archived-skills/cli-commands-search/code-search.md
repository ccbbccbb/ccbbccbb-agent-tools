# Code Search Workflow

## Finding Files

```bash
# Find by name
fd component

# Find by extension
fd -e tsx -e ts

# Find in specific directory
fd pattern src/

# Find and list
fd -e json
```

## Searching Content

### Quick text search (rg)
```bash
# Basic search
rg "TODO"

# Case insensitive
rg -i "error"

# In specific file types
rg -t ts "interface"

# Show context
rg -C 3 "function"

# List files only
rg -l "useState"
```

### Structural search (sg)
```bash
# Find function calls
sg -p 'console.log($$$)'

# Find specific patterns
sg -p 'fetch($URL)'

# Find React patterns
sg -p 'useState($_)'
sg -p '<Component $$$PROPS />'
```

## Combined Workflow

### 1. Find relevant files
```bash
fd -e tsx src/components
```

### 2. Search for patterns
```bash
# Text search first (fast)
rg "handleClick" -l

# Then structural if needed
sg -p 'onClick={$HANDLER}'
```

### 3. View results
Use Claude Code's built-in Read tool to view file contents.

## Common Patterns

### Find all TODOs
```bash
rg "TODO|FIXME|HACK" -t ts
```

### Find unused exports
```bash
# Find exports
rg "^export " -l

# Check if imported anywhere
rg "import.*ComponentName"
```

### Find function definitions
```bash
# Text-based
rg "function \w+\(" -t js

# Structure-based (more accurate)
sg -p 'function $NAME($$$)' --lang js
```
