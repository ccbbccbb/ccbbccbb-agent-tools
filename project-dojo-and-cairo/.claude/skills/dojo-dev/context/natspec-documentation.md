# NatSpec Documentation Style Guide

## Cairo NatSpec Tags

Use triple slashes (`///`) for documentation comments:

### Available Tags

| Tag | Purpose |
|-----|---------|
| `/// @title` | Title or heading for functions, modules, or code sections |
| `/// @notice` | Brief user-facing description (1-2 sentences) |
| `/// @dev` | Developer notes on implementation details, algorithms, formulas |
| `/// @param` | Parameter documentation (what each parameter represents) |
| `/// @return` | Return value documentation (what the function returns) |

## Documentation Template

```cairo
/// @title Calculate Max HP
/// @notice Calculates maximum HP for a Hybrid based on base stats, DNAs, and RNAs
/// @dev Uses formula: floor((2 * base + DNA + RNA) / 2) + 10. Level is constant at 50.
/// @param base_hp The base HP stat from the Hybrid template
/// @param dna_hp DNA value for HP (0-11)
/// @param rna_hp RNA value for HP (0-64)
/// @return The calculated maximum HP as u16
fn calculate_max_hp(base_hp: u8, dna_hp: u8, rna_hp: u8) -> u16 {
    let level: u16 = 50;
    ((2 * base_hp.into() + dna_hp.into() + rna_hp.into()) * level / 100 + 10).try_into().unwrap()
}
```

## Best Practices

### DO:
- ✅ Use `@title` for important functions and modules
- ✅ Use `@notice` for ALL public functions
- ✅ Use `@dev` when implementation details matter
- ✅ Document ALL parameters with `@param`
- ✅ Document return values with `@return`
- ✅ Keep `@notice` user-friendly and concise
- ✅ Put technical details in `@dev`
- ✅ Wrap long lines for readability

### DON'T:
- ❌ Use double slashes (`//`) for documentation
- ❌ Skip parameter documentation
- ❌ Mix user-facing and technical details in `@notice`
- ❌ Document obvious parameters without adding value
- ❌ Write novels in comments

## Dojo-Specific Documentation

For Dojo contracts, document:
- Which models are read from
- Which models are written to
- Key structures used
- State transitions
- Events emitted

```cairo
/// @title Initialize Draft System
/// @notice Sets up the draft system with random Hybrid selection
/// @dev Reads from: DraftOption model. Writes to: Session model.
/// @dev Uses Cartridge VRF for randomness generation
/// @param world The Dojo world interface
/// @param player_id The player's address
/// @return draft_options Array of 3 random Hybrid IDs
fn initialize_draft(world: IWorldDispatcher, player_id: ContractAddress) -> Array<u8> {
    // implementation
}
```

## Function Categories

### Public Interface Functions
MUST have: `@title`, `@notice`, `@param`, `@return`
SHOULD have: `@dev` for non-obvious behavior

### Internal Helper Functions
MUST have: `@notice`, `@param`, `@return`
MAY skip `@title`

### Simple Getters/Setters
MUST have: `@notice`
MAY skip `@dev` if trivial

## Example: Complete System Function

```cairo
/// @title Execute Battle Action
/// @notice Processes a player's action during a battle turn
/// @dev Reads: Battle, HybridInstance models. Writes: Battle model.
/// @dev Validates action legality, calculates damage, updates HP, checks for faint.
/// @dev Emits BattleActionExecuted event with results.
/// @param world The Dojo world interface
/// @param game_id The unique game identifier
/// @param action The action to execute (attack/switch/item)
/// @param target Optional target for the action
/// @return ActionResult containing damage dealt, effects applied, and battle state
#[abi(embed_v0)]
fn execute_action(
    world: IWorldDispatcher,
    game_id: u32,
    action: BattleAction,
    target: Option<u8>
) -> ActionResult {
    // implementation
}
```
