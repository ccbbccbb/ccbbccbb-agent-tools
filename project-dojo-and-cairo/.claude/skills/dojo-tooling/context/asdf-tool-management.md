# asdf Tool Management for Dojo

All Dojo tooling must be managed via `asdf` - never use binary installs.

## Critical Rule

**NEVER install Dojo tools via binary downloads.** All tools must be managed through asdf:
- sozo
- katana
- torii
- scarb
- starknet-foundry

The `.tool-versions` file in the project root is the source of truth for all versions.

## Setup

```bash
# Install all project dependencies
asdf install

# Verify versions match .tool-versions
asdf current
```

## Troubleshooting

### Tools Not Found

1. Verify asdf is installed: `asdf --version`
2. Check PATH includes asdf shims
3. Verify plugins are added: `asdf plugin list`
4. Run `asdf install` in project root

### Version Mismatches

1. Check `.tool-versions` for expected versions
2. Run `asdf install` to sync
3. Restart terminal if shims not updating

### Persistent Errors

- Consult: https://github.com/dojoengine
- Discord: https://discord.gg/dojoengine
