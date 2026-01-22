# Watch Mode Development

Use `sozo dev` for rapid iteration with auto-rebuild on file changes.

## Start Watch Mode

```bash
# Basic watch mode
sozo dev

# With TypeScript bindings generation
sozo dev --typescript
```

## When to Use

- Active development with frequent code changes
- Iterating on contract logic
- Rapid testing without manual rebuilds

## Requirements

- Katana running (for migrations)
- Valid `dojo_dev.toml` configuration

## Stop

Press `Ctrl+C` to stop watching.
