# Dojo Code Search Patterns

Search patterns for finding Dojo-specific code constructs using grep/ripgrep.

## Path Flexibility

Replace `src/` with flexible patterns as needed:
- Use `. --include="*.cairo"` to search all Cairo files from current directory
- Use `**/models/*.cairo` for glob-based directory matching
- In monorepos, run from `contracts/` directory or use full paths

**For complex Cairo questions, use the cairo-coder MCP tool:**
```
mcp__cairo-coder__assist_with_cairo
```

## Dojo Model Patterns

```bash
# Find all Dojo models
grep -rn "#\[dojo::model\]" src/

# Find model with specific name
grep -rn "struct Session {" src/models/

# Find models with key fields
grep -rn "#\[key\]" src/models/

# Find model definitions with context
grep -B1 -A10 "#\[dojo::model\]" src/models/
```

## Dojo Contract/System Patterns

```bash
# Find all system contracts
grep -rn "#\[dojo::contract\]" src/systems/

# Find system modules (should be {name}_systems)
grep -rn "pub mod.*_systems" src/systems/

# Find interface traits
grep -rn "#\[starknet::interface\]" src/

# Find impl blocks
grep -rn "#\[abi(embed_v0)\]" src/
```

## Dojo Event Patterns

```bash
# Find event definitions
grep -rn "#\[dojo::event\]" src/

# Find event struct names
grep -B1 -rn "#\[dojo::event\]" src/ | grep "struct"

# Find event emissions
grep -rn "world.emit_event" src/
```

## World API Patterns

```bash
# Find model reads
grep -rn "world.read_model" src/

# Find model writes
grep -rn "world.write_model" src/

# Find model erasure
grep -rn "world.erase_model" src/

# Find UUID generation
grep -rn "world.uuid" src/
```

## Function Patterns

```bash
# Find all public functions
grep -rn "pub fn " src/

# Find functions with specific prefix
grep -rn "fn calculate_" src/
grep -rn "fn get_" src/
grep -rn "fn set_" src/

# Find test functions
grep -rn "#\[test\]" src/
```

## Type Definition Patterns

```bash
# Find enums
grep -rn "^pub enum" src/
grep -rn "enum.*{" src/

# Find structs (non-model)
grep -rn "^pub struct" src/

# Find type aliases
grep -rn "^type " src/
```

## Import Patterns

```bash
# Find all project imports
grep -rn "use game::" src/

# Find WRONG import patterns (to fix)
grep -rn "use crate::" src/

# Find Dojo imports
grep -rn "use dojo::" src/

# Find Starknet imports
grep -rn "use starknet::" src/
```

## Trait/Impl Patterns

```bash
# Find all impl blocks
grep -rn "impl.*of.*{" src/

# Find specific trait implementations
grep -rn "impl.*of IShop" src/
grep -rn "impl.*of IBattle" src/
```

## Error/Assertion Patterns

```bash
# Find all asserts
grep -rn "assert(" src/

# Find assert with specific message
grep -rn "assert.*'Session not found'" src/

# Find panic calls
grep -rn "panic(" src/
```

## Ripgrep (rg) Advanced Patterns

Ripgrep is faster and supports more regex features:

```bash
# Find functions with multiple parameters
rg "fn \w+\([^)]+,[^)]+\)" src/

# Find structs with specific field
rg -A 10 "struct Session" src/ | grep -E "(session_id|player)"

# Find TODO comments
rg "TODO|FIXME|XXX" src/

# Count occurrences
rg -c "world.write_model" src/
```

## Complex Searches

### Find Functions That Modify Models

```bash
# Find files that both read and write models
grep -l "world.read_model" src/systems/*.cairo | \
  xargs grep -l "world.write_model"
```

### Find Undocumented Functions

```bash
# Functions without NatSpec comments (no /// above fn)
grep -B1 "pub fn " src/ | grep -v "///" | grep "pub fn"
```

### Find Potential Security Issues

```bash
# Functions with player/user parameters (need ownership checks)
grep -rn "player.*ContractAddress" src/systems/

# Unchecked .into() conversions
grep -rn "\.into()" src/ | grep -v "try_into"
```

## Tips

| Flag | Purpose |
|------|---------|
| `-n` | Show line numbers |
| `-r` | Recursive search |
| `-l` | Files-only output |
| `-A N` | N lines after match |
| `-B N` | N lines before match |
| `-C N` | N lines of context |
| `-c` | Count matches |
| `-i` | Case insensitive |

**Escape brackets** in patterns: `\[`, `\]`
