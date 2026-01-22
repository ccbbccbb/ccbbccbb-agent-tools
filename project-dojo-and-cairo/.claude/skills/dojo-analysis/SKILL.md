---
name: dojo-analysis
description: |
  Search Dojo code and inspect deployed world state using sozo. Use when:
  - Finding models, systems, events, or functions in codebase
  - Searching for specific patterns (structs, traits, impls)
  - Inspecting deployed world via sozo inspect
  - Querying ECS entities, permissions, or resources
  - Keywords: "find", "search", "where is", "inspect", "sozo inspect", "grep", "convert", "felt", "hex", "uint256"
allowed-tools: Read, Bash, Grep, Glob, mcp__cairo-coder__assist_with_cairo
---

# Dojo Analysis Skill

Search Dojo code patterns and inspect deployed world state using sozo tooling.

## Version History
- v3.0.0 (2026-01-21): Updated to flexible path patterns
- v2.0.0 (2025-12-18): Renamed from code-analysis, focused on Dojo/sozo tooling
- v1.0.0 (2025-12-11): Initial implementation

## Path Patterns

These patterns work regardless of project structure (monorepo or standalone):

| Pattern | Matches |
|---------|---------|
| `**/*.cairo` | All Cairo files |
| `**/models/*.cairo` | Model files |
| `**/systems/*.cairo` | System files |
| `**/utils/*.cairo` | Utility files |

**Note:** Run `sozo` commands from the contracts directory.

## Primary Tools

### sozo inspect
Query deployed Dojo world state:
```bash
sozo inspect                    # Full world overview
sozo inspect models             # List registered models
sozo inspect systems            # List deployed systems
sozo inspect permissions        # View permissions
sozo model schema Session       # Get model schema
sozo model get Session 1        # Get model instance
```

### grep / Grep tool
Search code patterns (use `--include` for flexible matching):
```bash
grep -rn "#\[dojo::model\]" . --include="*.cairo"    # Find all models
grep -rn "#\[dojo::contract\]" . --include="*.cairo" # Find all systems
grep -rn "world.read_model" . --include="*.cairo"    # Find model reads
```

### cairo-coder MCP
For complex Cairo questions, use:
```
mcp__cairo-coder__assist_with_cairo
```

## When to Use This Skill

Trigger on user mentions of:
- Finding models, systems, events, functions
- Searching for code patterns
- Inspecting deployed world state
- Querying ECS resources
- Understanding codebase structure

## Routing Logic

| Intent | Workflow |
|--------|----------|
| Find code patterns | workflows/dojo-code-search.md |
| Inspect deployed world | workflows/sozo-inspect-world.md |
| Convert felt/hex/string | workflows/stark-convert.md |

## Context Files

| Context | When to Load |
|---------|--------------|
| context/sozo-inspect-queries.md | sozo inspect commands |

## Quick Reference

```bash
# Find all Dojo models (flexible path)
grep -rn "#\[dojo::model\]" . --include="*.cairo"

# Find all system contracts
grep -rn "#\[dojo::contract\]" . --include="*.cairo"

# Find function definitions
grep -rn "fn calculate_" . --include="*.cairo"

# Find model reads/writes
grep -rn "world.read_model" . --include="*.cairo"
grep -rn "world.write_model" . --include="*.cairo"

# Search in specific subdirectories
grep -rn "PATTERN" **/models/*.cairo
grep -rn "PATTERN" **/systems/*.cairo

# Inspect deployed world (run from contracts/)
sozo inspect
```
