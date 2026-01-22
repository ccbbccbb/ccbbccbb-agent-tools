# Dojo Import & Module Conventions

**Note:** Path examples use `src/` but adapt to your project structure (e.g., `contracts/src/` in monorepos).

## Crate Name

Your project's crate name is defined in Scarb.toml (e.g., `game`).

## Import Prefix Rules

```cairo
// ✅ CORRECT - Project imports
use game::models::session::{Session, SessionState};
use game::models::battle::{Battle, BattleStatus};
use game::data::types::ElementType;
use game::utils::calculation::calculate_damage;

// ✅ CORRECT - Dojo framework imports
use dojo::model::ModelStorage;
use dojo::event::EventStorage;
use dojo::world::{WorldStorage, WorldStorageTrait};

// ✅ CORRECT - Starknet imports
use starknet::{ContractAddress, get_caller_address};

// ❌ WRONG - Don't use these prefixes
use crate::models::session::Session;
use game_contracts::models::session::Session;
```

## Module Naming Convention

### The Problem

When a file is named `shop.cairo` and contains `pub mod shop {}`, Cairo creates a doubled path:

```
game::systems::shop::shop::SomeType
                 ^^^^  ^^^^
                 file  inner module (same name = redundant)
```

This causes confusing warnings with paths like:
- `game::systems::shop::shop::ItemPurchased`
- `game::systems::battle::battle::get_hybrid_template`

### The Solution

Rename inner modules to `{name}_systems` pattern:

```cairo
// File: src/systems/shop.cairo

// ❌ Before - doubled path
#[dojo::contract]
pub mod shop {              // Creates game::systems::shop::shop::X
    // ...
}

// ✅ After - clear path distinction
#[dojo::contract]
pub mod shop_systems {      // Creates game::systems::shop::shop_systems::X
    // ...
}
```

### System Module Mapping

| File | Inner Module Name |
|------|-------------------|
| `admin.cairo` | `admin_systems` |
| `battle.cairo` | `battle_systems` |
| `draft.cairo` | `draft_systems` |
| `healing.cairo` | `healing_systems` |
| `initialization.cairo` | `initialization_systems` |
| `party_inventory.cairo` | `party_inventory_systems` |
| `shop.cairo` | `shop_systems` |

### Why Only Systems?

- Models don't have inner `mod` wrappers
- Utils don't have inner `mod` wrappers
- Only `#[dojo::contract]` creates the nested module structure

## Dojo Contract Import Pattern

Separate imports into outer and inner levels:

```cairo
//! # Battle System

// OUTER IMPORTS: Types for interface signatures and events ONLY
use game::models::battle::{BattleStatus, StatModifiers};

#[derive(Drop, Serde)]
pub enum BattleAction {
    UseMove: u8,
    SwitchHybrid: u8,
}

#[starknet::interface]
pub trait IBattle<T> {
    fn end_battle(ref self: T, session_id: u64, battle_result: BattleStatus);
}

#[derive(Drop, Serde)]
#[dojo::event]
pub struct BattleStarted {
    #[key]
    pub session_id: u64,
}

#[dojo::contract]
pub mod battle_systems {
    // Import from outer scope
    use super::{IBattle, BattleAction, BattleStarted};

    // INNER IMPORTS: Everything else
    use dojo::world::{WorldStorage, WorldStorageTrait};
    use dojo::model::ModelStorage;
    use game::models::{Session, Battle, HybridInstance};
    use game::data::{get_hybrid_template, get_move_template};
    use game::utils::{calculate_damage, lcg_next};

    #[abi(embed_v0)]
    impl BattleImpl of IBattle<ContractState> {
        // Implementation uses inner imports
    }
}
```

### Key Rules

1. **Outer imports**: Only types used in:
   - Interface trait method signatures
   - Event struct fields
   - Enum definitions

2. **Inner imports**: Everything for implementation:
   - Dojo world/model imports
   - Data access functions
   - Utility functions
   - Model types

3. **Use `super::`**: Import interface, events, enums from outer scope

4. **No duplication**: Never import same thing at both levels

## Verification

After fixing imports, verify with:

```bash
sozo build
```

Build should succeed with only warnings (unused imports in boilerplate).
