# Dojo Testing Patterns

## Running Tests with sozo

```bash
# Run all tests
sozo test

# Verbose output (see test names and results)
sozo test -- --verbose

# Run specific test by name
sozo test test_calculate_damage

# Run tests matching pattern
sozo test battle
```

## Test File Structure

```cairo
#[cfg(test)]
mod tests {
    use super::{ContractAddress, IWorldDispatcher, IWorldDispatcherTrait};
    use dojo::model::{ModelStorage, ModelValueStorage};
    use dojo::world::WorldStorageTrait;
    use dojo_cairo_test::{spawn_test_world, NamespaceDef, TestResource, ContractDefTrait};

    fn setup() -> IWorldDispatcher {
        // Test world setup
    }

    #[test]
    fn test_feature_name() {
        let world = setup();
        // Test implementation
    }
}
```

## Common Test Patterns

### 1. Basic Function Test

```cairo
#[test]
fn test_calculate_damage() {
    let attack = 100;
    let defense = 50;
    let move_power = 80;

    let damage = calculate_damage(attack, defense, move_power);

    assert(damage > 0, 'Damage should be positive');
    assert(damage == expected_value, 'Incorrect damage');
}
```

### 2. Dojo World Setup

```cairo
fn setup() -> IWorldDispatcher {
    let namespace_def = NamespaceDef {
        namespace: "rivals",
        resources: [
            TestResource::Model(m_Session::TEST_CLASS_HASH),
            TestResource::Model(m_HybridInstance::TEST_CLASS_HASH),
            TestResource::Contract(contract_def("draft", draft::TEST_CLASS_HASH)),
        ].span()
    };

    spawn_test_world([namespace_def].span())
}
```

### 3. Model Read/Write Test

```cairo
#[test]
fn test_model_storage() {
    let world = setup();
    let player_id = starknet::contract_address_const::<0x123>();

    // Write model
    let mut session = Session {
        game_id: 1,
        player_id,
        status: SessionStatus::Active,
    };
    world.write_model(@session);

    // Read model
    let loaded: Session = world.read_model(1);
    assert(loaded.player_id == player_id, 'Player ID mismatch');
}
```

### 4. Testing Expected Panics

```cairo
#[test]
#[should_panic(expected: ('Game not found',))]
fn test_invalid_game_id() {
    let world = setup();
    // Call function that should panic
    get_game(world, 999);
}
```

### 5. Testing Events

```cairo
#[test]
fn test_event_emission() {
    let world = setup();

    // Perform action that emits event
    start_battle(world, game_id, player_id);

    // Verify event was emitted
    // (Check logs or use event testing utilities)
}
```

### 6. Testing Randomness

```cairo
#[test]
fn test_random_selection() {
    let world = setup();
    let seed = 12345;

    let selection = random_select(world, seed, 3, 18);

    assert(selection.len() == 3, 'Wrong count');
    assert(selection[0] != selection[1], 'Not unique');
}
```

## Test Organization

### Group Related Tests

```cairo
mod draft_tests {
    #[test]
    fn test_initialize_draft() { /* ... */ }

    #[test]
    fn test_select_hybrid() { /* ... */ }

    #[test]
    fn test_complete_draft() { /* ... */ }
}

mod battle_tests {
    #[test]
    fn test_start_battle() { /* ... */ }

    #[test]
    fn test_execute_move() { /* ... */ }
}
```

## Test Coverage Guidelines

- ✅ Test happy path (normal operation)
- ✅ Test edge cases (boundaries, limits)
- ✅ Test error cases (invalid inputs)
- ✅ Test state transitions
- ✅ Test model reads/writes
- ✅ Test access control
- ✅ Test mathematical calculations

## Test Naming Convention

Use descriptive names explaining what is being tested:

| Good Name | Explains |
|-----------|----------|
| `test_draft_returns_three_unique_hybrids` | Expected behavior |
| `test_battle_damage_includes_hab_bonus` | Specific calculation |
| `test_invalid_game_id_panics` | Error case |
| `test_session_status_updates_after_battle` | State transition |

## Debugging Failing Tests

1. **Run verbose**: `sozo test -- --verbose`
2. **Add `println!`**: Debug output (removed in production)
3. **Check assertion message**: Identifies which check failed
4. **Read test code**: Verify expected values
5. **Check model setup**: Ensure test world has required models

## Serialization Notes

When building calldata for tests:

### Option<T> Serialization
```cairo
// Some(value) = append 0, then the value
calldata.append(0);           // Some variant
calldata.append(actual_value);

// None = append 1
calldata.append(1);           // None variant
```

### ByteArray Serialization
```cairo
let mut calldata: Array<felt252> = array![];
let my_string: ByteArray = "test string";
my_string.serialize(ref calldata);
```

### Deploy with Calldata
```cairo
let calldata = array![arg1, arg2];
deploy_contract(class_hash, calldata.span());
```

## Key Test Helpers

| Helper | Purpose |
|--------|---------|
| `dojo_cairo_test::spawn_test_world` | Provision a Dojo world for testing |
| `dojo_cairo_test::deploy_contract` | Deploy contract with class hash and calldata |
| `starknet::testing::set_caller_address` | Set caller for permission tests |
| `starknet::testing::set_block_timestamp` | Control time-dependent logic |
