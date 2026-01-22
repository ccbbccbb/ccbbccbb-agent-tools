---
description: Generate NatSpec documentation comments for Cairo functions
argument-hint: <file_path_or_pattern>
context: fork
agent: general-purpose
allowed-tools: Read, Edit, Grep, Glob, mcp__cairo-coder__assist_with_cairo
---

# Generate Cairo Comments

Add NatSpec-style documentation to Cairo functions in the specified file(s).

**Target:** $ARGUMENTS (or prompt for file path if empty)

## NatSpec Tags Reference

Use triple slashes (`///`) for documentation:

| Tag | Usage |
|-----|-------|
| `/// @title` | Title/heading for functions, modules, or sections |
| `/// @notice` | Brief user-facing description (1-2 sentences) |
| `/// @dev` | Developer notes: implementation details, algorithms, formulas |
| `/// @param` | Parameter documentation (what each represents) |
| `/// @return` | Return value documentation |

## Workflow

1. Read the target file(s)
2. Identify functions missing documentation (no `///` comments above `fn`)
3. For each undocumented function:
   - Add `/// @title` for public/important functions
   - Add `/// @notice` with brief user-friendly description
   - Add `/// @dev` for non-obvious implementation details
   - Document ALL parameters with `/// @param`
   - Document return values with `/// @return`
4. For Dojo-specific functions, also document:
   - Which models are read/written (`@dev Reads: X. Writes: Y.`)
   - State transitions
   - Events emitted

## Documentation Levels

### Public Interface Functions (`#[abi(embed_v0)]`, trait impls)
MUST have: `@title`, `@notice`, `@param`, `@return`
SHOULD have: `@dev` for non-obvious behavior

### Internal Helper Functions (`fn` without pub or in impl blocks)
MUST have: `@notice`, `@param`, `@return`
MAY skip `@title`

### Simple Getters/Setters
MUST have: `@notice`
MAY skip `@dev` if trivial

## Example Output

```cairo
/// @title Calculate Max HP
/// @notice Calculates maximum HP for a Hybrid based on base stats, DNAs, and RNAs
/// @dev Uses formula: floor((2 * base + DNA + RNA) / 2) + 10. Level constant at 50.
/// @param base_hp The base HP stat from the Hybrid template
/// @param dna_hp DNA value for HP (0-11)
/// @param rna_hp RNA value for HP (0-64)
/// @return The calculated maximum HP as u16
fn calculate_max_hp(base_hp: u8, dna_hp: u8, rna_hp: u8) -> u16 {
    // implementation
}
```

## Rules

- Use triple slashes (`///`), NOT double slashes (`//`)
- Keep `@notice` user-friendly and concise
- Put technical details in `@dev`
- Wrap long lines for readability (aim for ~80-100 chars)
- Don't document obvious parameters without adding value
- Don't write novels - be concise but complete

## Dojo-Specific Example

```cairo
/// @title Execute Battle Turn
/// @notice Processes a player's action during battle
/// @dev Reads: Battle, HybridInstance models. Writes: Battle model.
/// @dev Validates action legality, calculates damage, updates HP, checks faint.
/// @dev Emits TurnExecuted event with results.
/// @param session_id The unique session identifier
/// @param action The battle action (UseMove or SwitchHybrid)
/// @return Updated battle state
fn execute_turn(ref self: ContractState, session_id: u64, action: BattleAction) -> Battle {
    // implementation
}
```

## Output Format

After adding comments, report:
- Number of functions documented
- Any functions skipped (already documented)
- Any complex functions that need manual review
