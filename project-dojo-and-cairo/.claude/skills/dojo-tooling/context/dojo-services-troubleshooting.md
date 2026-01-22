# Dojo Services Troubleshooting

Common issues and solutions for Katana and Torii.

## Katana Issues

### Katana Won't Start

**Symptom:** Katana fails to start or immediately exits

**Common Causes:**
1. Port 5050 already in use
2. Previous katana process still running
3. Corrupted state

**Solutions:**
```bash
# Check if port is in use
lsof -i :5050

# Kill existing katana process
pkill katana

# Remove PID file
rm .katana_pid

# Try starting again
./contracts/scripts/dev.sh start
```

### Katana Running But Not Responding

**Symptom:** Process exists but RPC calls fail

**Solutions:**
```bash
# Check process status
ps aux | grep katana

# Check logs for errors
tail -50 katana.log

# Restart
./contracts/scripts/dev.sh restart
```

## Torii Issues

### Torii Won't Start

**Symptom:** Torii fails to start or can't connect

**Common Causes:**
1. Port 8080 already in use
2. No world address file
3. Katana not running
4. Wrong world address

**Solutions:**
```bash
# Check if port is in use
lsof -i :8080

# Verify world address exists
cat .world_address

# Ensure Katana is running first
lsof -i :5050

# Check torii logs
tail -20 torii.log
```

### Torii Can't Index

**Symptom:** Torii running but GraphQL returns no data

**Causes:**
1. World address mismatch
2. Katana restarted with new state
3. Migration changed world

**Solutions:**
```bash
# Verify world address matches
cat .world_address
sozo inspect | grep "World address"

# Restart Torii with correct world
./contracts/scripts/dev.sh restart
```

## World Address Issues

### World Address Missing

**Symptom:** `.world_address` file doesn't exist

**Solution:**
```bash
# Build and migrate to generate world address
sozo build
sozo migrate

# World address should now be in .world_address
cat .world_address
```

### World Address Stale

**Symptom:** World address exists but doesn't match deployed world

**Solution:**
```bash
# Re-run migration to update
sozo migrate

# Restart Torii
./contracts/scripts/dev.sh restart
```

## Port Conflicts

### "Address already in use"

**Symptom:** Service fails with port error

**Solutions:**
```bash
# Find what's using the port
lsof -i :5050
lsof -i :8080

# Kill the conflicting process
kill -9 <PID>

# Or use different ports
katana --port 5051
torii --port 8081 --rpc http://localhost:5051
```

## Log Locations

| Service | Log File |
|---------|----------|
| Katana | `katana.log` |
| Torii | `torii.log` |

**View recent logs:**
```bash
./scripts/dev.sh logs

# Or directly
tail -50 katana.log
tail -50 torii.log
```

**Follow logs in real-time:**
```bash
tail -f katana.log
tail -f torii.log
```

## Clean Restart Procedure

If all else fails, do a complete clean restart:

```bash
# 1. Stop everything
./scripts/dev.sh stop

# 2. Kill any remaining processes
pkill katana
pkill torii

# 3. Clean up PIDs
rm -f .katana_pid .torii_pid

# 4. Verify ports are free
lsof -i :5050
lsof -i :8080

# 5. Start fresh
./contracts/scripts/dev.sh start
```

## Common Error Messages

| Error | Meaning | Fix |
|-------|---------|-----|
| "Connection refused" | Service not running | Start Katana/Torii |
| "World not found" | Wrong world address | Re-run `sozo migrate` |
| "Address already in use" | Port conflict | Kill conflicting process |
| "No such file: .world_address" | Not deployed | Run `sozo migrate` |
