# Format Cairo Code with scarb fmt

Check and apply formatting to Cairo files using `scarb fmt`.

**Note:** This is the ONLY use case for `scarb` in this project. All other operations use `sozo`.

## Workflow Steps

### 1. Check Formatting

```bash
scarb fmt --check
```

**Output:**
- Lists files that need formatting
- Exit code 0 = all formatted
- Exit code 1 = files need formatting

### 2. Apply Formatting

```bash
scarb fmt
```

**Result:**
- Formats all `.cairo` files in src/
- Respects project config (max-line-length = 120)

### 3. Report Changes

After formatting, use git to see what changed:

```bash
git diff --name-only
```

## Configuration

Formatting settings in `Scarb.toml`:

```toml
[tool.fmt]
max-line-length = 120
```

## When to Format

- Before committing code
- After generating new files
- When imports look messy
- Before submitting PRs

## Common Formatting Changes

| Before | After |
|--------|-------|
| Long import lines | Split across multiple lines |
| Inconsistent spacing | Normalized whitespace |
| Trailing commas missing | Added where appropriate |
| Inconsistent indentation | Standardized to 4 spaces |
