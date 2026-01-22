---
description: Inspect deployed world state
argument-hint: [resource_name]
allowed-tools: sozo, echo
---

# Inspect World State

Inspect deployed Dojo world resources:

```bash
if [ -z "$ARGUMENTS" ]; then
  echo "Usage: /inspect <resource_name>"
  echo ""
  echo "Examples:"
  echo "  /inspect Session"
  echo "  /inspect HybridInstance"
  echo "  /inspect Actions"
  echo ""
  echo "Available resource types:"
  echo "  - Models (ECS components)"
  echo "  - Systems (contract logic)"
  echo "  - Events"
  echo ""
  sozo inspect
else
  sozo inspect $ARGUMENTS
fi
```

This command:
1. Queries the deployed world for resource information
2. Shows ABI, schema, and metadata for models/systems
3. Without arguments, lists all registered resources
4. With arguments, shows detailed info for specific resource

**Prerequisites:**
- World must be deployed (`.world_address` file exists)
- Katana/Torii should be running for live state
