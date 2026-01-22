---
name: client-nextjs
description: |
  Client frontend development conventions for the Dojo Next.js client. Use when:
  - Creating new components, hooks, or screens
  - Renaming files to follow naming conventions
  - Setting up barrel exports (index.ts)
  - Adding audio/animation feature flags to components
  - Auditing code for convention compliance
  - Working with RetroUI neobrutalist design system components
  - Creating or modifying core UI components (Button, Card, Alert, etc.)
  - Keywords: "client", "component", "hook", "screen", "naming", "kebab-case", "export", "barrel", "audio", "animation", "sfx", "retroui", "neobrutalism", "retro", "button", "card", "alert", "badge", "drawer", "modal"
allowed-tools: Read, Bash, Edit, Write, Grep, Glob, mcp__next-devtools-mcp__nextjs_docs, mcp__next-devtools-mcp__index, mcp__next-devtools-mcp__call, mcp__next-devtools-mcp__eval
---

# Client Frontend Skill

Development conventions and patterns for the Dojo client (Next.js + React).

## Version History
- v3.0.0 (2026-01-21): Merged retroui skill, added MCP tools, fixed paths
- v2.0.0 (2026-01-04): Restructured to follow Claude Skills format
- v1.0.0 (2026-01-03): Initial implementation with naming conventions and audit

## Quick Reference

### Naming Conventions

| Category | Convention | Example |
|----------|------------|---------|
| Core Components | kebab-case + `core-` prefix | `core-button.tsx` |
| Components | kebab-case | `user-avatar.tsx` |
| Hooks | camelCase + use prefix | `useGameState.ts` |
| Providers | PascalCase + Provider suffix | `AudioProvider.tsx` |
| Markdown | COBOL-CASE | `README.md` |
| Everything else | kebab-case | `type-chart.ts` |

### Import Pattern

```typescript
// Always import from barrel exports
import { Button, Card } from "@/components/core";
import { useGameState, useSFX } from "@/hooks";
import { SPECIES, MOVES } from "@/lib/constants";
```

### Next.js DevTools MCP (if available)

When the Next.js dev server is running, use these MCP tools for diagnostics:

| Tool | Purpose |
|------|---------|
| `mcp__next-devtools__nextjs_index` | Discover running Next.js servers and available MCP tools |
| `mcp__next-devtools__nextjs_call` | Call MCP tools on dev server (errors, routes, cache) |
| `mcp__next-devtools__browser_eval` | Browser automation for page verification and testing |

Example workflow:
1. Call `nextjs_index` to discover servers
2. Call `nextjs_call` with `port=3000`, `toolName="get_errors"` to check for errors

## When to Use This Skill

Trigger on user mentions of:
- Creating components, hooks, screens
- File naming conventions
- Export patterns / barrel exports
- Audio or animation feature flags
- Convention auditing / compliance
- RetroUI components (Button, Card, Alert, Badge, etc.)
- Neobrutalist design patterns
- Core component creation or modification

## Routing Logic

Route to appropriate workflow based on user intent:

| Intent | Workflow |
|--------|----------|
| Create component | workflows/create-component.md |
| Create RetroUI component | workflows/create-retroui-component.md |
| Audit naming | workflows/audit-naming.md |
| Add feature flags | workflows/add-feature-flags.md |

## Context Files

Load context based on task:

| Context | When to Load |
|---------|--------------|
| context/naming-conventions.md | File/folder naming rules |
| context/export-patterns.md | Barrel exports, import conventions |
| context/component-flags.md | useAnimation/useSFX patterns |
| context/directory-structure.md | Project folder organization |
| context/retroui-design-principles.md | RetroUI neobrutalist design rules |
| context/theme-system.md | CSS variables and theming |
| context/component-patterns.md | CVA patterns for RetroUI components |
| components/installed.md | List of installed core components |

## External Resources

- **Official RetroUI docs:** https://retroui.dev/docs/

## Workflow Pattern

1. Determine user's intent (create/rename/audit/add-flags/retroui)
2. Load relevant context file
3. Route to appropriate workflow
4. Execute workflow steps
5. Report results and suggest next steps
