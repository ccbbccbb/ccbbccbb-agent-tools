# Build and Migrate Dojo Contracts

Compile Cairo contracts with `sozo build` and deploy to Katana with `sozo migrate`.

## Workflow Steps

### 1. Build Contracts

```bash
sozo build
```

**Success indicators:**
- "Compiling" messages for each contract
- No error output
- `contracts/target/dev/` directory populated

**Note:** Run all `sozo` commands from the `contracts/` directory.

**On error:**
- Parse error message for file and line number
- Load `context/dojo-common-errors.md` for fixes
- Check imports use `game::` not `crate::`

### 2. Migrate to Katana

```bash
sozo migrate
```

**Prerequisites:**
- Katana running on port 5050
- Build succeeded (step 1)

**Success indicators:**
- World address displayed
- Models registered
- Contracts deployed

### 3. Save World Address

```bash
# Extract and save world address (from contracts directory)
cat contracts/.world_address
```

If migration updated the world address, suggest:
- Restarting Torii with new world address
- Updating any client configurations

### 4. Verify Deployment

```bash
sozo inspect
```

Check:
- All expected models are registered
- All expected systems are deployed
- Permissions are configured correctly

## Clean Build (if needed)

When encountering stale artifacts:

```bash
sozo clean && sozo build
```

## Verbosity Flags

For troubleshooting builds/migrations:

```bash
sozo build -v      # Info
sozo build -vv     # Debug
sozo build -vvv    # Trace

sozo migrate -v    # Info
sozo migrate -vvv  # Full trace
```

## Common Issues

| Issue | Solution |
|-------|----------|
| Build fails with type error | Check integer types, use `.into()` |
| "Model not found" | Verify `#[dojo::model]` attribute |
| Migration fails | Ensure Katana is running |
| Stale artifacts | Run `sozo clean && sozo build` |
