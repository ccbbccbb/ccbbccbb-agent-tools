---
description: Build and deploy to local Katana
allowed-tools: sozo
---

# Sozo Migrate - Build and Deploy to Local Katana

Build contracts and deploy to local Katana:

```bash
sozo build && sozo migrate
```

This command:
1. Compiles all Cairo contracts with `sozo build`
2. Deploys/migrates changes to local Katana with `sozo migrate`
3. Updates the world state with any model or system changes
4. Generates manifest files for deployed resources

**Prerequisites:**
- Katana must be running on port 5050
- Run `katana --dev --dev.no-fee` in a separate terminal first
