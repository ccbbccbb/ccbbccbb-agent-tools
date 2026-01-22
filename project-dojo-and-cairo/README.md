# project-dojo-and-cairo

Claude Code skills, commands, and subagents for Dojo and Cairo development on Starknet.

## Contents

### Skills
- **dojo-dev** - Build, test, deploy, and document Dojo contracts using sozo
- **dojo-analysis** - Search code patterns and inspect deployed world state
- **dojo-tooling** - Manage Katana/Torii services and SDK integration

### Subagents
- **dojo-security-auditor** - Security audit agent for Cairo contracts
- **dojo-game-designer** - Game mechanics and tokenomics design agent

### Commands
- `/sozo-migrate` - Deploy contracts to Katana
- `/sozo-deploy` - Production deployment
- `/sozo-inspect` - Inspect world state
- `/sozo-abi` - Generate ABI files
- `/fix-dojo-imports` - Fix import conventions
- `/generate-cairo-comments` - Add NatSpec documentation

## MCP Server Setup

This project uses MCP servers for enhanced Dojo and Cairo development capabilities.

### Required MCP Servers

#### 1. Sensei MCP (Dojo Framework Guidance)

```bash
claude mcp add sensei-mcp npx github:dojoengine/sensei-mcp
```

Provides:
- Dojo model patterns
- System implementation guidance
- Configuration best practices
- Testing strategies

Available tools:
- `mcp__sensei-mcp__dojo_101` - Beginner introduction
- `mcp__sensei-mcp__dojo_config` - Configuration and setup
- `mcp__sensei-mcp__dojo_logic` - System implementation
- `mcp__sensei-mcp__dojo_model` - Model design patterns
- `mcp__sensei-mcp__dojo_test` - Testing strategies
- `mcp__sensei-mcp__dojo_token` - Token standards

#### 2. Cairo Coder MCP

First, get an API key from https://cairo-coder.com/

```bash
claude mcp add cairo-coder -e CAIRO_CODER_API_KEY=YOUR-KEY -- npx -y @kasarlabs/cairo-coder-mcp
```

Provides:
- Cairo syntax assistance
- Corelib references
- Code examples
- Security patterns

Available tool:
- `mcp__cairo-coder__assist_with_cairo` - Cairo development assistance

### Verify Installation

```bash
claude mcp list
```

Both `sensei-mcp` and `cairo-coder` should appear in the list.

### Restart Required

After adding MCP servers, restart Claude Code for changes to take effect.

## Installation

Copy the `.claude` directory to your Dojo project:

```bash
cp -r project-dojo-and-cairo/.claude /path/to/your-dojo-project/
```

Or symlink for shared updates:

```bash
ln -s /path/to/project-dojo-and-cairo/.claude /path/to/your-dojo-project/.claude
```
