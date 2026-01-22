# Grep Search Examples for Dojo Projects

Real-world search examples using grep/ripgrep for Dojo code analysis.

## Path Flexibility

Examples use `src/` but adapt to your project structure:
- Monorepo: Run from `contracts/` or use `contracts/src/`
- Use `. --include="*.cairo"` for flexible matching
- Use `**/models/*.cairo` for glob-based paths

## Finding Dojo Components

### Find All Models

```bash
grep -rn "#\[dojo::model\]" src/models/
```

Output:
```
src/models/session.cairo:5:#[dojo::model]
src/models/battle.cairo:8:#[dojo::model]
src/models/hybrid_instance.cairo:4:#[dojo::model]
```

### Find All Test Functions

```bash
grep -rn "#\[test\]" src/
```

### Find Functions That Panic

```bash
grep -rn "panic(" src/

# Or assert statements
grep -rn "assert(" src/
```

## Model Operations

### Find Where Model is Written

```bash
# Find where Session is created/modified
grep -rn "Session {" src/ | grep -v "struct Session"
```

### Find Model Reads for Specific Type

```bash
# Find Session reads
grep -rn "read_model.*Session\|: Session.*read_model" src/
```

## System Operations

### Find Battle System Calls

```bash
grep -rn "execute_turn\|start_battle\|end_battle" src/systems/
```

### Find Event Emissions

```bash
grep -rn "emit_event(@" src/
```

## Error Messages

### Find All Assert Messages

```bash
grep -rn "assert.*'" src/ | grep -oP "'\K[^']+"
```

### Find Specific Error

```bash
grep -rn "'Session not found'" src/
```

## Type Usage

### ContractAddress Usage

```bash
grep -rn "ContractAddress" src/
```

### Option Usage

```bash
grep -rn "Option::" src/
```

## Event Definitions and Usage

### Event Definitions with Context

```bash
grep -B2 -A5 "#\[dojo::event\]" src/
```

### Event Emissions

```bash
grep -rn "emit_event(@" src/
```

## Complex Search Patterns

### Find Functions Modifying Specific Model

```bash
# Find functions that read and write Session
grep -l "read_model.*Session\|Session.*read_model" src/systems/*.cairo | \
  xargs grep -n "write_model"
```

### Find Potential Integer Overflows

```bash
# Find arithmetic operations (manual review needed)
grep -rn " + \| - \| \* \| / " src/ | grep -v "//"
```

### Find Functions With World Parameter

```bash
grep -rn "fn.*world.*WorldStorage" src/
```

### Find Unvalidated Input

```bash
# Functions with player_id parameter
grep -rn "player_id: ContractAddress" src/systems/
```

## Refactoring Searches

### Find All Occurrences for Rename

```bash
# Find all HybridInstance references
grep -rn "HybridInstance" src/

# Count occurrences by file
grep -c "HybridInstance" src/**/*.cairo | grep -v ":0"
```

### Find Import Patterns to Fix

```bash
# Wrong: crate::
grep -rn "use crate::" src/

# Wrong: game_contracts::
grep -rn "use game_contracts::" src/

# Correct: game::
grep -rn "use game::" src/
```

### Find Module Naming Issues

```bash
# Find system modules NOT using _systems suffix
grep -rn "pub mod " src/systems/ | grep -v "_systems"
```

## File Discovery

### Find Cairo Files by Pattern

```bash
# Find all Cairo files
find src -name "*.cairo"

# Find test files
find src -name "*_test.cairo"

# Find system files
ls src/systems/*.cairo
```

## Search with Context

### Show Lines Before and After

```bash
# Show 3 lines before and after
grep -C 3 "#\[dojo::model\]" src/models/session.cairo
```

## Search and Count

### Count Models

```bash
grep -c "#\[dojo::model\]" src/models/*.cairo | awk -F: '{sum+=$2} END {print sum}'
```

### Count Asserts by File

```bash
grep -c "assert(" src/systems/*.cairo
```

## Search Specific Directories

```bash
# Only models
grep -rn "PATTERN" src/models/

# Only systems
grep -rn "PATTERN" src/systems/

# Only utils
grep -rn "PATTERN" src/utils/
```

## Pattern Matching Tips

1. **Escape special chars**: `\[`, `\]`, `\(`, `\)`
2. **Word boundaries**: `\bword\b`
3. **Case insensitive**: `-i` flag
4. **Extended regex**: `-E` flag
5. **Perl regex**: `-P` flag (grep only)
