---
name: dojo-tooling
description: |
  Manage Dojo development services: Katana (local blockchain) and Torii (indexer). Use when:
  - Starting/stopping Katana or Torii
  - Checking service health or ports
  - Debugging connection issues
  - Viewing service logs
  - Keywords: "start", "stop", "katana", "torii", "services", "ports", "logs", "indexer", "bindings", "typescript", "dojo.js", "sdk", "query", "subscribe", "zustand", "optimistic"
allowed-tools: Read, Bash, Grep
---

# Dojo Tooling Skill

Manage Katana (local blockchain) and Torii (GraphQL indexer) services for Dojo development.

## Version History
- v3.0.0 (2026-01-21): Updated file paths for monorepo flexibility
- v2.0.0 (2025-12-18): Renamed from devops, focused on Katana/Torii
- v1.0.0 (2025-12-11): Initial implementation

## Note on Paths

File paths like `contracts/.world_address` assume a monorepo structure. Adapt paths based on your project layout.

## Dojo Service Stack

### Katana - Local Blockchain
- **Port:** 5050
- **Purpose:** Local Starknet sequencer for development
- **RPC URL:** `http://localhost:5050`

### Torii - GraphQL Indexer
- **Port:** 8080
- **Purpose:** Index world state, provide GraphQL/gRPC API
- **GraphQL URL:** `http://localhost:8080/graphql`
- **Requirement:** Needs world address from `contracts/.world_address`

## When to Use This Skill

Trigger on user mentions of:
- Starting or stopping the dev environment
- Checking if Katana/Torii are running
- Debugging connection issues
- Viewing service logs
- Port conflicts or service health

## Routing Logic

| Intent | Workflow |
|--------|----------|
| Start environment | workflows/start-katana-torii.md |
| Stop environment | workflows/stop-katana-torii.md |
| Check service health | workflows/katana-torii-health.md |
| View/analyze logs | workflows/analyze-service-logs.md |
| Generate TypeScript bindings | workflows/generate-bindings.md |
| SDK setup / connect frontend | workflows/torii-sdk-setup.md |
| Query entities from Torii | workflows/torii-sdk-queries.md |
| Subscribe to entity changes | workflows/torii-sdk-subscriptions.md |
| Zustand state management | workflows/torii-sdk-zustand.md |
| Optimistic updates | workflows/torii-sdk-optimistic.md |

## Context Files

| Context | When to Load |
|---------|--------------|
| context/katana-torii-ports.md | Port config, health check endpoints |
| context/dojo-services-troubleshooting.md | Common issues and solutions |
| context/torii-sdk-reference.md | SDK API reference, query operators, clauses |
| context/asdf-tool-management.md | asdf setup, version management, troubleshooting |

## Quick Health Check

```bash
# Check if Katana is running
lsof -i :5050

# Check if Torii is running
lsof -i :8080

# Test Katana endpoint
curl -s http://localhost:5050

# Test Torii GraphQL
curl -s http://localhost:8080/graphql
```

## Service Management

```bash
# Start services
./contracts/scripts/dev.sh start

# Stop services
./contracts/scripts/dev.sh stop

# View logs
./contracts/scripts/dev.sh logs

# Restart services
./contracts/scripts/dev.sh restart
```

## File Tracking

| File | Purpose |
|------|---------|
| `contracts/.world_address` | Deployed world address (from `sozo migrate`) |
| `contracts/.katana_pid` | Katana process ID |
| `contracts/.torii_pid` | Torii process ID |
| `contracts/katana.log` | Katana blockchain logs |
| `contracts/torii.log` | Torii indexer logs |

**Note:** All `sozo` commands must be run from the `contracts/` directory.
