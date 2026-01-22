# Dojo Code Search Workflow

Search for patterns in Dojo/Cairo code using grep/ripgrep.

## Path Flexibility

Use `--include="*.cairo"` for flexible matching across project structures:
- Works in monorepo (`contracts/src/`)
- Works in standalone (`src/`)

## Workflow Steps

### 1. Identify Search Target

Determine what the user is looking for:
- Models (`#[dojo::model]`)
- Systems (`#[dojo::contract]`)
- Events (`#[dojo::event]`)
- Functions (`fn name`)
- Types (enums, structs)
- Specific code patterns

### 2. Execute Appropriate Search

**For Dojo models:**
```bash
grep -rn "#\[dojo::model\]" . --include="*.cairo"
```

**For Dojo systems:**
```bash
grep -rn "#\[dojo::contract\]" . --include="*.cairo"
```

**For Dojo events:**
```bash
grep -rn "#\[dojo::event\]" . --include="*.cairo"
```

**For functions:**
```bash
grep -rn "fn function_name" . --include="*.cairo"
```

**For model operations:**
```bash
grep -rn "world.read_model\|world.write_model" . --include="*.cairo"
```

### 3. Add Context If Needed

```bash
# Show lines before and after
grep -C 3 "PATTERN" . --include="*.cairo"

# Show more context for understanding
grep -B2 -A10 "#\[dojo::model\]" . --include="*.cairo"
```

### 4. Report Results

- List matching files and line numbers
- Show relevant code snippets
- Suggest related searches if appropriate

## Quick Reference

| Target | Command |
|--------|---------|
| Models | `grep -rn "#\[dojo::model\]" . --include="*.cairo"` |
| Systems | `grep -rn "#\[dojo::contract\]" . --include="*.cairo"` |
| Events | `grep -rn "#\[dojo::event\]" . --include="*.cairo"` |
| Functions | `grep -rn "pub fn " . --include="*.cairo"` |
| Model reads | `grep -rn "world.read_model" . --include="*.cairo"` |
| Model writes | `grep -rn "world.write_model" . --include="*.cairo"` |
| Traits/Impls | `grep -rn "impl.*of.*{" . --include="*.cairo"` |

## Search by Directory Pattern

```bash
# Only models (flexible path)
grep -rn "PATTERN" **/models/*.cairo

# Only systems
grep -rn "PATTERN" **/systems/*.cairo

# Only utils
grep -rn "PATTERN" **/utils/*.cairo
```

## Advanced Patterns

### Files Only
```bash
grep -l "PATTERN" . --include="*.cairo"
```

### Count Matches
```bash
grep -c "PATTERN" **/*.cairo
```

## See Also

- context/dojo-search-patterns.md - Full pattern reference
- context/grep-search-examples.md - Real examples
