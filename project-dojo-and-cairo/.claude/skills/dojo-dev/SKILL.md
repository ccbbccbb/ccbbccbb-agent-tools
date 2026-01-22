---
name: dojo-dev
description: |
  Dojo development tooling for building, testing, deploying, and documenting onchain contracts. Use when:
  - Building contracts with sozo build
  - Running tests with sozo test
  - Deploying to Katana with sozo migrate
  - Watch mode with sozo dev
  - Formatting code with scarb fmt (only scarb use case)
  - Adding NatSpec documentation to Cairo code
  - Fixing compilation errors
  - Keywords: "build", "test", "deploy", "format", "natspec", "sozo", "migrate", "compilation", "lint", "diagnostics", "warnings", "dev", "watch"
allowed-tools: Read, Bash, Edit, Write, Grep, Glob, mcp__cairo-coder__assist_with_cairo, mcp__ide__getDiagnostics
---

# Dojo Development Skill

Build, test, deploy, and document Dojo contracts using the sozo toolchain.

## Version History
- v3.0.0 (2026-01-21): Updated path patterns for monorepo flexibility
- v2.0.0 (2025-12-18): Renamed from cairo-dev, focused on Dojo/sozo tooling
- v1.1.0 (2025-12-17): Added import-conventions context
- v1.0.0 (2025-12-11): Initial implementation

## Note on Paths

**Run all `sozo` commands from the contracts directory.** Path examples in this skill use `src/` but adapt to your project:
- Monorepo: `contracts/src/`
- Standalone: `src/`

## Primary Tool: sozo

**sozo** is the Dojo command-line tool for all contract operations:

| Command | Purpose |
|---------|---------|
| `sozo build` | Compile Cairo contracts |
| `sozo test` | Run test suite |
| `sozo test -- --verbose` | Run tests with detailed output |
| `sozo migrate` | Deploy contracts to Katana |
| `sozo inspect` | View deployed world state |
| `sozo clean` | Remove build artifacts |
| `sozo dev` | Watch mode with auto-rebuild |

**scarb** is ONLY used for code formatting:
- `scarb fmt` - Format Cairo code
- `scarb fmt --check` - Check formatting without changes

## When to Use This Skill

Trigger on user mentions of:
- Building or compiling Dojo/Cairo contracts
- Running tests (`sozo test`)
- Migrating/deploying to Katana (`sozo migrate`)
- Code formatting (`scarb fmt`)
- Adding NatSpec documentation
- Fixing compilation errors
- Dojo toolchain operations

## Routing Logic

Route to appropriate workflow based on user intent:

| Intent | Workflow |
|--------|----------|
| Build and deploy | workflows/sozo-build-migrate.md |
| Run tests | workflows/sozo-test.md |
| Format code | workflows/scarb-format.md |
| Add documentation | workflows/natspec-document.md |
| Check lints/diagnostics | workflows/check-lints.md |
| Watch mode / dev server | workflows/sozo-dev.md |

## Context Files

Load context based on task complexity:

| Context | When to Load |
|---------|--------------|
| context/sozo-tooling.md | Sozo commands, Dojo CLI reference |
| context/dojo-testing-patterns.md | Writing/debugging tests, serialization notes |
| context/dojo-common-errors.md | Fixing compilation errors |
| context/dojo-import-conventions.md | Import/module naming issues |
| context/natspec-documentation.md | Adding code documentation |
| context/cairo-coder-mcp-usage.md | Best practices for MCP queries |

## External Resources

For complex Cairo questions, use the **cairo-coder MCP tool**:
```
mcp__cairo-coder__assist_with_cairo
```

This provides access to:
- Cairo documentation
- Code examples
- Corelib references
- Technical guides

## Workflow Pattern

1. Determine user's intent (build/test/format/document)
2. Route to appropriate workflow
3. Load relevant context if errors occur
4. Execute workflow steps
5. Use cairo-coder MCP for complex Cairo questions
6. Report results and suggest next steps
