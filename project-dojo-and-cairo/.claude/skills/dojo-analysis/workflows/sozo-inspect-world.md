# Inspect Deployed World with sozo

Query the deployed Dojo world for debugging and analysis.

## Workflow Steps

### 1. Get World Overview

```bash
sozo inspect
```

This shows:
- World address
- Registered models
- Deployed systems
- Permissions configuration

### 2. List Specific Resources

```bash
# List all registered models
sozo inspect models

# List all deployed systems
sozo inspect systems

# View permissions
sozo inspect permissions
```

### 3. Query Model Data

**Get model schema:**
```bash
sozo model schema Session
sozo model schema HybridInstance
```

**Get specific model instance:**
```bash
# Single key
sozo model get Session 1

# Composite key
sozo model get Battle 1,0
```

### 4. Report Findings

- List contract addresses
- Report model registration status
- Note any permission issues
- Suggest fixes for common problems

## Common Inspection Tasks

### Verify Migration Success

```bash
# Check world address
cat .world_address

# Verify models registered
sozo inspect | grep -A 20 "Models"

# Verify systems deployed
sozo inspect | grep -A 20 "Systems"
```

### Debug "Model Not Found"

```bash
# Check if model is registered
sozo inspect models | grep Session

# If missing, run migration
sozo migrate
```

### Check Game State

```bash
# Get session
sozo model get Session 1

# Get player Hybrids
sozo model get HybridInstance 0
sozo model get HybridInstance 1
```

## Prerequisites

- Katana running on port 5050
- World deployed via `sozo migrate`
- `.world_address` file exists

## Common Issues

| Issue | Solution |
|-------|----------|
| "Model not found" | Run `sozo migrate` |
| "Empty result" | Check key values |
| "Permission denied" | Check `sozo inspect permissions` |

## See Also

- context/sozo-inspect-queries.md - Full query reference
