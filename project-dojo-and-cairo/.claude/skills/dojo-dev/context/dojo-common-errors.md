# Dojo Common Errors and Fixes

## Type Errors

### "Type mismatch"

```
error: Expected type A, found type B
```

**Common Causes:**
- Mixing `u8` with `u16` or other integer types
- Missing `.into()` conversion
- Wrong generic type parameter

**Solutions:**
```cairo
// Use .into() for compatible types
let value_u16: u16 = value_u8.into();

// Explicit type annotation
let result: u32 = calculation();

// Use try_into() with unwrap for potentially lossy conversions
let value_u8: u8 = value_u16.try_into().unwrap();
```

### "Cannot move out of borrowed content"

**Solution:**
```cairo
// Use @ for snapshot (immutable borrow)
world.write_model(@model);

// Or clone if you need ownership
let model_copy = model.clone();
```

## Dojo-Specific Errors

### "Model not found"

```
error: Model X is not registered in the world
```

**Causes:**
- Model not included in migration
- Wrong namespace
- Model not properly annotated with `#[dojo::model]`

**Solutions:**
```bash
# Rebuild and migrate
sozo build
sozo migrate

# Verify model has proper attribute
# Check: #[dojo::model] is present
```

### "System not found"

**Solutions:**
```cairo
// Ensure system has #[dojo::contract]
#[dojo::contract]
mod my_system {
    // ...
}

// Check system is declared in lib.cairo
mod my_system;
```

### "Namespace not found"

**Solutions:**
```bash
# Check dojo_dev.toml namespace configuration
# Ensure namespace matches between config and code

# Rebuild and migrate
sozo build
sozo migrate
```

## Ownership and Borrowing

### "Value moved"

```
error: Value was moved and can no longer be used
```

**Solutions:**
```cairo
// Use reference instead of move
fn process(ref model: Model) { }

// Or clone the value
let model_copy = model.clone();
process(model_copy);
// model still available

// For arrays, use span
let my_array = array![1, 2, 3];
process_array(my_array.span());
```

### "Cannot borrow as mutable"

**Solutions:**
```cairo
// Make variable mutable
let mut session = world.read_model(game_id);

// Use ref for mutable reference
fn update(ref model: Model) {
    model.field = new_value;
}
```

## Testing Errors

### "Assertion failed"

```
error: Panicked with "Expected X, got Y"
```

**Solutions:**
```cairo
// Add descriptive assert messages
assert(value == expected, 'Value mismatch');

// Use == for equality, not =
assert(a == b, 'Not equal');

// Check for panic with should_panic
#[test]
#[should_panic(expected: ('Error message',))]
fn test_panics() { }
```

### "Test resource not found"

**Solutions:**
```cairo
// Ensure TEST_CLASS_HASH is available
use super::m_Session;

TestResource::Model(m_Session::TEST_CLASS_HASH)

// Verify model is included in test namespace
```

## Build Errors

### "Package not found"

**Solutions:**
```toml
# Add dependency in Scarb.toml
[dependencies]
dojo = { git = "https://github.com/dojoengine/dojo", tag = "v1.0.11" }
```

### "Circular dependency"

**Solutions:**
```cairo
// Move shared types to separate module
// Avoid mutual imports between files
// Use forward declarations where possible
```

## Runtime Errors (Panics)

### "Integer overflow"

```cairo
// Use checked arithmetic
let result = value.checked_add(other).expect('Overflow');

// Or use larger integer type
let value: u128 = large_calc();
```

### "Array index out of bounds"

```cairo
// Check length first
assert(index < array.len(), 'Index out of bounds');
let value = *array.at(index);

// Or use get() for Option
match array.get(index) {
    Option::Some(value) => { /* use value */ },
    Option::None => { /* handle missing */ }
}
```

### "Division by zero"

```cairo
// Check denominator
assert(denominator != 0, 'Division by zero');
let result = numerator / denominator;
```

## Sozo Migration Errors

### "World address not found"

**Solutions:**
```bash
# Ensure migration succeeded
sozo migrate

# Check .world_address file exists
cat .world_address

# Restart Torii with correct world address
```

## Quick Debugging Checklist

When you encounter an error:

1. ✅ Read the full error message (not just first line)
2. ✅ Check the file and line number
3. ✅ Verify types match expected types
4. ✅ Ensure models are registered in world
5. ✅ Check for moved values
6. ✅ Verify mut/ref usage
7. ✅ Run `sozo build` to see all errors
8. ✅ Check recent git changes if it "just broke"
9. ✅ Try `sozo clean && sozo build` for fresh rebuild
10. ✅ Check dependencies are up to date
