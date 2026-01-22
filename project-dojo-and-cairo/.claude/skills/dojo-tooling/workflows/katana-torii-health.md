# Check Katana & Torii Health

Verify the health of running Dojo development services.

## Workflow Steps

### 1. Check Katana Health

```bash
# Check if process is running
lsof -i :5050

# Test RPC endpoint
curl -s http://localhost:5050/health || curl -s http://localhost:5050
```

**Healthy indicators:**
- Process running on port 5050
- Endpoint responds to requests

### 2. Check Torii Health

```bash
# Check if process is running
lsof -i :8080

# Test GraphQL endpoint
curl -s http://localhost:8080/graphql
```

**Healthy indicators:**
- Process running on port 8080
- GraphQL responds (even with empty query)

### 3. Verify World Address

```bash
# Read stored world address
cat .world_address

# Compare with deployed world (if needed)
sozo inspect | grep -i "world"
```

### 4. Check Service Versions

```bash
# From logs or direct query
head -5 katana.log
head -5 torii.log
```

### 5. Report Status

Summarize:
- Katana: Running/Stopped
- Torii: Running/Stopped
- World Address: Present/Missing
- Any issues found

## Quick Health Script

```bash
echo "=== Dojo Services Health ==="

# Katana
if lsof -ti:5050 > /dev/null 2>&1; then
    echo "Katana (5050): UP"
else
    echo "Katana (5050): DOWN"
fi

# Torii
if lsof -ti:8080 > /dev/null 2>&1; then
    echo "Torii (8080): UP"
else
    echo "Torii (8080): DOWN"
fi

# World Address
if [ -f ".world_address" ]; then
    echo "World Address: $(cat .world_address)"
else
    echo "World Address: NOT SET"
fi
```

## Suggested Fixes for Unhealthy Services

| Issue | Fix |
|-------|-----|
| Katana down | `./scripts/dev.sh start` |
| Torii down | Check Katana first, then start |
| World address missing | Run `sozo migrate` |
| Both unresponsive | Full restart: `./scripts/dev.sh restart` |
