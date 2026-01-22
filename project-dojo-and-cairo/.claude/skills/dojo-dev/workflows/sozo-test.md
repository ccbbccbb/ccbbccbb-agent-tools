# Run Dojo Tests with sozo test

Execute the test suite using `sozo test` and analyze results.

## Workflow Steps

### 1. Run Tests

```bash
# Standard test run
sozo test

# Verbose output (recommended for debugging)
sozo test -- --verbose
```

### 2. Analyze Results

**On success:**
- Report number of tests passed
- Note any skipped tests

**On failure:**
- Parse the failure output
- Identify failing test function and file
- Read the relevant test code
- Suggest fixes based on the assertion that failed

### 3. Run Specific Tests (if needed)

```bash
# Run tests matching a pattern
sozo test battle

# Run specific test by name
sozo test test_calculate_damage
```

## Test Output Interpretation

### Success
```
test game::tests::test_feature ... ok
```

### Failure
```
test game::tests::test_feature ... FAILED
Panicked with "Expected X, got Y"
```

### Panic with Expected
```
#[should_panic(expected: ('Error message',))]
fn test_should_fail() { }
```

## Common Test Failures

| Failure | Likely Cause | Fix |
|---------|--------------|-----|
| "Assertion failed" | Wrong expected value | Check test logic |
| "Value moved" | Ownership issue | Use `@` or clone |
| "Model not found" | Missing test resource | Add to namespace_def |
| "Index out of bounds" | Array access error | Check length first |

## Debugging Tips

1. **Add verbose flag**: `sozo test -- --verbose`
2. **Use `println!`**: Add debug output to tests
3. **Check assertion messages**: Identifies which check failed
4. **Verify test setup**: Ensure world has required models
5. **Run single test**: `sozo test test_name` to isolate
