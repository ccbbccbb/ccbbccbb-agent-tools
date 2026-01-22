# Check Cairo Diagnostics

Get real-time diagnostics from the Cairo LSP without a full build.

## When to Use

- Quick feedback during development
- Before committing to catch warnings
- After refactoring to verify no issues
- Faster than `sozo build` for lint checks

## Workflow Steps

### 1. Check All Files

Use `mcp__ide__getDiagnostics` without arguments to scan all open files:

**Common diagnostics:**
- Unused imports
- Type mismatches
- Style warnings (nested ifs, loop→while suggestions)
- Missing trait implementations

### 2. Check Specific File

Pass a file URI to check a single file:

```
mcp__ide__getDiagnostics with uri: file:///path/to/file.cairo
```

### 3. Interpret Results

| Severity | Action |
|----------|--------|
| Error | Must fix before build will succeed |
| Warning | Should fix, but build may still pass |

**Output includes:**
- File path
- Line and character position
- Diagnostic message

## Comparison with sozo build

| Aspect | getDiagnostics | sozo build |
|--------|----------------|------------|
| Speed | Fast (real-time) | Slower (full compile) |
| Coverage | Open files in VS Code | All project files |
| Errors | Lint + type hints | Full compilation errors |
