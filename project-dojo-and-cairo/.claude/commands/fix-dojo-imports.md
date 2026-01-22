---
description: Fix Dojo import conventions and module naming patterns
allowed-tools: Bash, Grep, Edit, Read, Glob, ast-grep, mcp__cairo-coder__assist_with_cairo
---

# Fix Imports & Module Conventions

Fix common Dojo imports and module naming issues in the codebase.

**Target:** $ARGUMENTS (or scan entire src/ if empty)

## Issues This Command Fixes

### 1. Import Prefix Convention

```cairo
// ❌ WRONG
use crate::models::session::Session;
use game_contracts::models::session::Session;

// ✅ CORRECT
use game::models::session::Session;
```

### 2. Doubled Module Paths (Fix 12 from BUILD-FIXES.md)

When a file is named `shop.cairo` and contains `pub mod shop {}`, Cairo creates a redundant doubled path:

```
game::systems::shop::shop::SomeType
                 ^^^^  ^^^^
                 file  inner module (REDUNDANT)
```

**Solution:** Rename inner modules to `{name}_systems` pattern:

```cairo
// ❌ WRONG - File: src/systems/shop.cairo
#[dojo::contract]
pub mod shop { ... }  // Creates: game::systems::shop::shop::X

// ✅ CORRECT
#[dojo::contract]
pub mod shop_systems { ... }  // Creates: game::systems::shop::shop_systems::X
```

## Workflow

### Step 1: Find `crate::` imports
```bash
grep -rn "use crate::" src/
```

Replace all with `use game::`:
```bash
# Preview changes
grep -rn "use crate::" src/ | head -20

# Apply fixes using Edit tool for each file
```

### Step 2: Find `game_contracts::` imports
```bash
grep -rn "use game_contracts::" src/
```

Replace with `use game::`.

### Step 3: Check for doubled module paths in systems

For each system file, verify the inner module uses `{name}_systems`:

| File | Expected Inner Module |
|------|----------------------|
| `admin.cairo` | `pub mod admin_systems` |
| `battle.cairo` | `pub mod battle_systems` |
| `draft.cairo` | `pub mod draft_systems` |
| `healing.cairo` | `pub mod healing_systems` |
| `initialization.cairo` | `pub mod initialization_systems` |
| `party_inventory.cairo` | `pub mod party_inventory_systems` |
| `shop.cairo` | `pub mod shop_systems` |

### Step 4: Verify build
```bash
sozo build
```

## Import Convention Reference

```cairo
// ✅ Project imports use game::
use game::models::session::{Session, SessionState};
use game::models::battle::{Battle, BattleStatus};
use game::data::types::ElementType;
use game::utils::calculation::calculate_damage;

// ✅ Dojo framework imports use dojo::
use dojo::model::ModelStorage;
use dojo::event::EventStorage;
use dojo::world::{WorldStorage, WorldStorageTrait};

// ✅ Starknet imports
use starknet::{ContractAddress, get_caller_address};
```

## Dojo Contract Import Pattern

The correct pattern separates imports into two levels:

```cairo
//! # Battle System

// OUTER IMPORTS: Only types needed for interface signatures and events
use game::models::battle::{BattleStatus, StatModifiers};

#[starknet::interface]
pub trait IBattle<T> {
    fn end_battle(ref self: T, session_id: u64, battle_result: BattleStatus);
}

#[dojo::contract]
pub mod battle_systems {  // Note: {name}_systems pattern
    // Import interface from outer scope
    use super::{IBattle, BattleAction};

    // INNER IMPORTS: Full implementation imports
    use dojo::world::{WorldStorage, WorldStorageTrait};
    use dojo::model::ModelStorage;
    use game::models::{Session, Battle, HybridInstance};

    #[abi(embed_v0)]
    impl BattleImpl of IBattle<ContractState> {
        // Implementation
    }
}
```

## Output

Report:
- Number of `crate::` imports fixed
- Number of `game_contracts::` imports fixed
- Number of module naming issues fixed
- Build verification result
