# Sozo Inspect Queries Reference

Query deployed Dojo world state using `sozo inspect` and related commands.

## Basic Inspection Commands

### View World Overview

```bash
# Full world inspection
sozo inspect
```

**Output includes:**
- World address
- Registered models
- Deployed systems
- Permissions configuration

### Inspect Specific Resources

```bash
# List all models
sozo inspect models

# List all systems
sozo inspect systems

# View permissions
sozo inspect permissions
```

## Model Queries

### Get Model Schema

```bash
sozo model schema Session
sozo model schema HybridInstance
sozo model schema Battle
```

### Get Model Instance

```bash
# Single key model
sozo model get Session <game_id>
sozo model get HybridInstance <hybrid_id>

# Composite key model (comma-separated)
sozo model get Battle <game_id>,<battle_index>
```

### List Model Instances

```bash
sozo model list Session
```

## System Queries

### List All Systems

```bash
sozo inspect systems
```

### Get System Details

```bash
sozo inspect system draft
sozo inspect system battle
```

## Execute System Functions

### Call a System Function

```bash
# Space-separated args (NOT --calldata or -c)
sozo execute <contract_tag> <function> <arg1> <arg2> ...

# Example: Initialize a game
sozo execute rivals-draft initialize 0x123

# Example: Multiple arguments
sozo execute rivals-initialization initialize_game_with_seed 1 12345

# With specific account
sozo execute --account-address <addr> \
  rivals-battle execute_move <game_id> <move_id>
```

## Common Inspection Patterns

### Check Game State

```bash
# 1. Get session status
sozo model get Session 1

# 2. Get player's Hybrids
sozo model get HybridInstance 0
sozo model get HybridInstance 1
sozo model get HybridInstance 2

# 3. Check current battle
sozo model get Battle 1,0
```

### Verify Migration

```bash
# After sozo migrate, verify:

# 1. World address updated
cat .world_address

# 2. All models registered
sozo inspect | grep -A 20 "Models"

# 3. All systems deployed
sozo inspect | grep -A 20 "Systems"
```

### Debug Contract Issues

```bash
# Check permissions
sozo inspect permissions

# Verify contract addresses
sozo inspect systems | grep address

# Check model registration
sozo inspect models | grep <ModelName>
```

## GraphQL Queries (via Torii)

Once Torii is running on port 8080:

### Query All Sessions

```graphql
query {
  sessionModels {
    edges {
      node {
        game_id
        player_id
        status
      }
    }
  }
}
```

### Query Specific Session

```graphql
query {
  sessionModels(where: { game_id: 1 }) {
    edges {
      node {
        game_id
        player_id
        status
        hybrid_id_0
        hybrid_id_1
      }
    }
  }
}
```

### Query with Filtering

```graphql
query {
  hybridInstanceModels(where: { current_hp_gt: 0 }) {
    edges {
      node {
        hybrid_id
        species_id
        current_hp
        max_hp
      }
    }
  }
}
```

## Using curl for GraphQL

```bash
# Query via HTTP
curl -X POST http://localhost:8080/graphql \
  -H "Content-Type: application/json" \
  -d '{
    "query": "{ sessionModels { edges { node { game_id player_id } } } }"
  }'
```

## Debugging Workflow

1. **Check world deployment:**
   ```bash
   sozo inspect
   ```

2. **Verify model exists:**
   ```bash
   sozo model schema Session
   ```

3. **Query model data:**
   ```bash
   sozo model get Session 1
   ```

4. **Check GraphQL (if Torii running):**
   ```bash
   curl http://localhost:8080/graphql
   ```

5. **Execute test transaction:**
   ```bash
   sozo execute <system> <function> <arg1> <arg2> ...
   ```

## Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| "Model not found" | Not deployed | Run `sozo migrate` |
| "Empty result" | Wrong keys | Verify key values |
| "Permission denied" | No write access | Check `sozo inspect permissions` |
| "Namespace not found" | Config mismatch | Check `dojo_dev.toml` namespace |
