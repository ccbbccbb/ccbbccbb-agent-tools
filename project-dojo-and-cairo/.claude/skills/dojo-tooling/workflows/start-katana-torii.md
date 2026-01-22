# Start Katana & Torii Services

Start the Dojo development environment (local blockchain and indexer).

## Workflow Steps

### 1. Start Services

```bash
./contracts/scripts/dev.sh start
```

This starts:
- **Katana** on port 5050 (local Starknet)
- **Torii** on port 8080 (GraphQL indexer)

**(Optional) If running with Frontend Client, enable CORS:**

```bash
katana --dev --dev.no-fee --http.cors_origins "*"
```

Or configure in a TOML file (`katana.toml`):
```toml
[server]
http_cors_origins = ["*"]
```
Then run: `katana --config katana.toml --dev --dev.no-fee`

### 2. Verify Katana

```bash
# Check process
lsof -i :5050

# Test endpoint
curl -s http://localhost:5050
```

**Expected:** Process running, endpoint responds

### 3. Verify Torii

```bash
# Check process
lsof -i :8080

# Test GraphQL endpoint
curl -s http://localhost:8080/graphql
```

**Expected:** Process running, GraphQL responds

### 4. Report World Address

```bash
cat contracts/.world_address
```

Report the world address for reference.

### 5. Confirm Accessibility

Verify both endpoints are accessible:
- Katana RPC: `http://localhost:5050`
- Torii GraphQL: `http://localhost:8080/graphql`

## Troubleshooting

If any service fails to start:

```bash
# Check logs
./contracts/scripts/dev.sh logs

# Common issues:
# - Port in use: kill conflicting process
# - World address missing: run sozo migrate from contracts/
# - Katana not up: Torii depends on Katana
```

## Prerequisites

- Katana binary installed (via `asdf install` from `contracts/`)
- Torii binary installed (via `asdf install` from `contracts/`)
- For Torii: `contracts/.world_address` file (run `sozo migrate` from `contracts/` first)
