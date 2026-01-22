# Stop Katana & Torii Services

Gracefully stop all Dojo development services.

## Workflow Steps

### 1. Stop Services

```bash
./contracts/scripts/dev.sh stop
```

### 2. Verify Ports Free

```bash
# Check Katana port
lsof -i :5050

# Check Torii port
lsof -i :8080
```

**Expected:** No output (ports are free)

### 3. Verify PID Cleanup

```bash
# Check PID files removed
ls -la .katana_pid .torii_pid 2>/dev/null || echo "PID files cleaned up"
```

## Force Stop (if needed)

If services don't stop gracefully:

```bash
# Kill by port
kill -9 $(lsof -ti:5050)
kill -9 $(lsof -ti:8080)

# Or by process name
pkill katana
pkill torii

# Clean up PID files
rm -f .katana_pid .torii_pid
```

## Verify Clean Shutdown

```bash
# Both should return empty
lsof -i :5050
lsof -i :8080
```
