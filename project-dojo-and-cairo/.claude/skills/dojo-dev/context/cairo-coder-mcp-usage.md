# Cairo Coder MCP Best Practices

The `mcp__cairo-coder__assist_with_cairo` tool provides access to Cairo documentation, code examples, and corelib references.

## Query Guidelines

**Keep queries atomic** - Focus on one concept per query. Multiple specific queries are better than one overloaded query.

```
# Good - specific queries
Query 1: "How to implement ERC20 transfer function"
Query 2: "What is the Serde trait in Cairo"

# Bad - overloaded query
Query: "Implement ERC20 with Serde serialization and event emission"
```

## When to Use

- Writing Cairo code from scratch
- Implementing specific features or TODOs
- Understanding Cairo/Starknet patterns
- Debugging compilation errors
- Using OpenZeppelin Cairo contracts

## Workflow

1. Make atomic MCP query for the specific concept
2. Write the Cairo code
3. Run `sozo build` immediately to verify compilation
4. Iterate: fix errors, query again if needed

**Important:** Always use `sozo build` (not `scarb build`) for Dojo projects.
