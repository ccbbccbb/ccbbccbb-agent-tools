# ccbbccbb-agent-tools

> work in progress

claude code configuration templates and tooling for development workflows.

## repository structure

### .claude/ (user configuration)

root-level claude code settings that apply across all projects.

- **settings.json** - permissions, hooks, sandbox config, enabled plugins
- **hooks/** - automation scripts
  - `auto-compact-transcript.sh` - saves transcript before auto-compact
  - `manual-compact-transcript.sh` - saves transcript before manual compact
  - `save-plan-to-repo.sh` - copies plan files with yaml frontmatter
- **skills/** - reusable skill definitions
  - `cli-commands/` - cli tool reference (jq, tree, gh, delta)
  - `ui-skills/` - ui development constraints
- **commands/** - slash commands
  - `git-catchup.md` - read changed files in current branch
  - `rams.md` - accessibility and visual design review
  - `vercel-ui-rules.md` - vercel ui guidelines compliance check
- **sfx/** - audio notification files for hooks

### project-dojo-and-cairo/

dojo framework template for starknet/cairo game development.

- **commands/** - sozo cli commands (abi, deploy, inspect, migrate)
- **skills/**
  - `dojo-tooling/` - katana/torii service management
  - `dojo-analysis/` - code search patterns for cairo/dojo
  - `dojo-dev/` - cairo coding, testing, import conventions
  - `dojo-docs/` - documentation maintenance rules
  - `client-nextjs/` - next.js client conventions for dojo projects
- **hooks/** - session start hook for environment status

### project-nextjs-frontend/

generic next.js frontend template.

- **skills/**
  - `nextjs-frontend/` - component patterns, naming conventions, mcp integration

### project-ralph-loop/

autonomous iteration system (ralph wiggum technique).

- re-feeds claude responses back as prompts for multi-iteration workflows
- iteration tracking with max caps and completion promises
- **commands/** - ralph-loop-start, ralph-loop-stop, ralph-loop-help
- **hooks/** - stop hook that intercepts exit to continue iteration
- **scripts/** - setup script for initializing loop state

## settings.json defaultmode reference

```json
"defaultMode": "acceptEdits"
```

| mode              | behavior                                                                                                                                                    |
|-------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------|
| default           | standard interactive mode. prompts for permission on first use of each tool, then remembers your choice for the session.                                    |
| acceptEdits       | auto-approves file edit/write operations. still prompts for other tools (bash, webfetch, etc). good for workflows where you trust file modifications.       |
| plan              | read-only analysis mode. claude can read files but cannot modify anything, run commands, or fetch web content. useful for safe exploration and code review. |
| dontAsk           | auto-denies all tools unless explicitly pre-approved via permissions.allow rules. restrictive mode for sensitive environments.                              |
| bypassPermissions | skips all permission prompts and auto-approves everything. full unrestricted access. dangerous - only use in isolated/safe environments.                    |

## usage

copy any project folder to use as a template:

```bash
cp -r project-dojo-and-cairo/ ~/my-dojo-project/.claude/
cp -r project-nextjs-frontend/ ~/my-nextjs-app/.claude/
cp -r project-ralph-loop/ ~/my-project/.claude/
```

## environment variables

add to your `.zshrc` or `.bashrc` to reduce mcp context window and token usage:

```bash
# enable tool search for claude code, save on mcp context window/token usage
export ENABLE_TOOL_SEARCH=true
export ENABLE_EXPERIMENTAL_MCP_CLI=false
```

| variable | purpose |
|----------|---------|
| `ENABLE_TOOL_SEARCH` | enables tool search feature, reduces context by filtering available tools |
| `ENABLE_EXPERIMENTAL_MCP_CLI` | controls experimental mcp cli features |

see `.zshrc` in this repo for reference configuration.
