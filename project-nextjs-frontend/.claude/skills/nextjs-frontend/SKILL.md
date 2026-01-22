---
name: nextjs-frontend
description: |
  Next.js frontend development conventions and patterns. Use when:
  - Creating new components, hooks, or screens
  - Renaming files to follow naming conventions
  - Setting up barrel exports (index.ts)
  - Working with Next.js DevTools MCP integration
  - Creating or modifying core UI components
  - Keywords: "component", "hook", "screen", "naming", "kebab-case", "export", "barrel", "nextjs", "mcp", "devtools"
allowed-tools: Read, Bash, Edit, Write, Grep, Glob, mcp__next-devtools__nextjs_docs, mcp__next-devtools__nextjs_index, mcp__next-devtools__nextjs_call, mcp__next-devtools__browser_eval, Skill(dev-browser:dev-browser)
---

# Next.js Frontend Skill

Development conventions and patterns for Next.js + React applications.

## Quick Reference

### Naming Conventions

| Category | Convention | Example |
|----------|------------|---------|
| Core Components | kebab-case + `core-` prefix | `core-button.tsx` |
| Components | kebab-case | `user-card.tsx` |
| Hooks | camelCase + use prefix | `useAuth.ts` |
| Providers | PascalCase + Provider suffix | `ThemeProvider.tsx` |
| Markdown | COBOL-CASE | `README.md` |
| Everything else | kebab-case | `data-utils.ts` |

### Import Pattern

```typescript
// Always import from barrel exports
import { Button, Card } from "@/components/core";
import { useAuth, useTheme } from "@/hooks";
import { API_URL, ROUTES } from "@/lib/constants";
```

### Next.js DevTools MCP (if available)

When the Next.js dev server is running, use these MCP tools for diagnostics:

| Tool | Purpose |
|------|---------|
| `mcp__next-devtools__nextjs_index` | Discover running Next.js servers and available MCP tools |
| `mcp__next-devtools__nextjs_call` | Call MCP tools on dev server (errors, routes, cache) |
| `mcp__next-devtools__browser_eval` | Browser automation for page verification and testing |
| `Skill(dev-browser:dev-browser)` | Playwright automation for user flows and testing |

Example workflow:
1. Call `nextjs_index` to discover servers
2. Call `nextjs_call` with `port=3000`, `toolName="get_errors"` to check for errors

## When to Use This Skill

Trigger on user mentions of:
- Creating components, hooks, screens
- File naming conventions
- Export patterns / barrel exports
- MCP integration / devtools
- Core component creation or modification

## Routing Logic

Route to appropriate workflow based on user intent:

| Intent | Workflow |
|--------|----------|
| Create component | workflows/create-component.md |
| Test pages / verify UI | workflows/browser-testing.md |

## Context Files

Load context based on task:

| Context | When to Load |
|---------|--------------|
| context/naming-conventions.md | File/folder naming rules |
| context/export-patterns.md | Barrel exports, import conventions |
| context/component-patterns.md | CVA patterns, compound components |
| context/mcp-integration.md | Next.js MCP devtools usage |
| context/dev-browser-automation.md | Browser automation / Playwright |

## Workflow Pattern

1. Determine user's intent (create/rename/audit)
2. Load relevant context file
3. Route to appropriate workflow
4. Execute workflow steps
5. Report results and suggest next steps
