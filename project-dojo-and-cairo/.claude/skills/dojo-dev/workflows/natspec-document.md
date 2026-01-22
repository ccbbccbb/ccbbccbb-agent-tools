# Generate NatSpec Documentation for Cairo Functions

Add NatSpec-style documentation comments to Cairo functions that are missing them.

## Workflow Steps

### 1. Find Undocumented Functions

```bash
# Find public functions without documentation
grep -B1 "pub fn " src/ | grep -v "///" | grep "pub fn"
```

### 2. Add Documentation

For each function without documentation, add:

1. `/// @title` - Title when providing heading for functions/modules
2. `/// @notice` - Brief user-facing description (1-2 sentences)
3. `/// @dev` - Developer notes on implementation details
4. `/// @param` - Document each parameter
5. `/// @return` - Document return values

### 3. Dojo-Specific Documentation

For Dojo contracts, also document:
- Which models are read from
- Which models are written to
- Key structures used
- State transitions
- Events emitted

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
    // implementation
}
```

## Style Rules

- Use triple slashes (`///`) not double slashes (`//`)
- Wrap long lines for readability
- Keep `@notice` concise and user-friendly
- Put technical details in `@dev`
- Document ALL parameters and return values

## See Also

- context/natspec-documentation.md - Full style guide
