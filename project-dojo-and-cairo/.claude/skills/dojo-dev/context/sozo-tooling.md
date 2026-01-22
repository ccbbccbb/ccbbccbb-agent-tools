# Sozo Tooling Reference

**sozo** is the Dojo command-line interface for building, testing, and deploying onchain worlds.

## Core Commands

### Build

```bash
# Compile all Cairo contracts
sozo build

# Clean build (remove artifacts first)
sozo clean && sozo build
```

**Build Output:**
- `target/dev/` - Compiled artifacts
- Generates ABIs, class hashes, manifest files

### Test

```bash
# Run all tests
sozo test

# Run with verbose output
sozo test -- --verbose

# Run specific test by name
sozo test test_function_name

# Run tests matching pattern
sozo test battle
```

**Test Output:**
- ✅ Passed: `test test_name ... ok`
- ❌ Failed: `test test_name ... FAILED` with assertion message

### Migrate (Deploy)

```bash
# Deploy to local Katana
sozo migrate

# Deploy with specific profile
sozo migrate --profile dev
```

**Migration Output:**
- World address (save to `.world_address`)
- Deployed contract addresses
- Registered models

### Inspect

```bash
# View world overview
sozo inspect

# View specific resource
sozo inspect models
sozo inspect systems
sozo inspect permissions

# Get model schema
sozo model schema Session

# Get model instance
sozo model get Session 1
```

### Execute

```bash
# Call a system function (space-separated args)
sozo execute <contract_tag> <function> <arg1> <arg2> ...

# Example: Initialize a game
sozo execute game-draft initialize 0x123

# Example: Multiple arguments
sozo execute game-initialization initialize_game_with_seed 1 12345
```

## Configuration Files

### Scarb.toml

```toml
[package]
name = "game"
version = "0.1.0"
edition = "2024_07"

[dependencies]
dojo = { git = "https://github.com/dojoengine/dojo", tag = "v1.0.11" }

[tool.fmt]
max-line-length = 120
```

### dojo_<profile>.toml

```toml
[world]
name = "game"
seed = "game"
namespace = { default = "game" }

[env]
rpc_url = "http://localhost:5050"
account_address = "0x..."
private_key = "0x..."
```

## Dojo Project Structure

```
project/
├── src/
│   ├── lib.cairo        # Main entry, declares modules
│   ├── models/          # #[dojo::model] structs
│   ├── systems/         # #[dojo::contract] logic
│   ├── utils/           # Pure helper functions
│   └── data/            # Reference data, templates
├── tests/               # Test files
├── Scarb.toml          # Package config
└── dojo_dev.toml       # Dojo dev profile
```

## Key Dojo Attributes

### Models (State)
```cairo
#[derive(Drop, Serde)]
#[dojo::model]
pub struct Session {
    #[key]           // Primary key field
    pub game_id: u32,
    pub status: SessionStatus,
}
```

### Systems (Logic)
```cairo
#[dojo::contract]
pub mod draft_systems {
    use dojo::world::WorldStorage;
    use dojo::model::ModelStorage;

    #[abi(embed_v0)]
    impl DraftImpl of super::IDraft<ContractState> {
        fn initialize(ref self: ContractState) {
            let mut world = self.world(@"game");
            // System logic
        }
    }
}
```

### Events
```cairo
#[derive(Drop, Serde)]
#[dojo::event]
pub struct BattleStarted {
    #[key]
    pub session_id: u64,
    pub player: ContractAddress,
}
```

## World API

```cairo
// Read model
let session: Session = world.read_model(game_id);

// Write model
world.write_model(@session);

// Emit event
world.emit_event(@BattleStarted { session_id, player });

// Erase model
world.erase_model(@session);

// Generate unique ID
let id = world.uuid();
```

## Debugging Tips

1. **Build fails**: Check imports use `game::` not `crate::`
2. **Test fails**: Use `sozo test -- --verbose` for details
3. **Migration fails**: Ensure Katana is running on port 5050
4. **Model not found**: Verify `#[dojo::model]` attribute
5. **Clean rebuild**: `sozo clean && sozo build`

## Common Error Patterns

| Error | Cause | Fix |
|-------|-------|-----|
| "Type mismatch" | Wrong integer type | Use `.into()` or `.try_into().unwrap()` |
| "Model not found" | Not registered | Run `sozo migrate` |
| "Namespace not found" | Config mismatch | Check `dojo_dev.toml` namespace |
| "Value moved" | Ownership issue | Use `@` for snapshots or clone |
