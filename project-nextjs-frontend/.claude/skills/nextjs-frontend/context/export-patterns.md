# Export Patterns

Guidelines for barrel exports and import conventions.

## Barrel Exports (index.ts)

Every directory with multiple exports should have an `index.ts` barrel file:

```typescript
// src/components/core/index.ts
export { Button } from "./core-button";
export { Card } from "./core-card";
export { Input } from "./core-input";
export { Modal } from "./core-modal";
```

## Import Convention

Always import from barrel exports, not individual files:

```typescript
// CORRECT - import from barrel
import { Button, Card } from "@/components/core";
import { useAuth, useTheme } from "@/hooks";

// INCORRECT - import from individual files
import { Button } from "@/components/core/core-button";
import { useAuth } from "@/hooks/useAuth";
```

## Directory Structure with Barrels

```
src/
├── components/
│   ├── core/
│   │   ├── core-button.tsx
│   │   ├── core-card.tsx
│   │   └── index.ts          # Barrel export
│   ├── ui/
│   │   ├── user-avatar.tsx
│   │   ├── nav-menu.tsx
│   │   └── index.ts          # Barrel export
│   └── index.ts              # Top-level barrel (optional)
├── hooks/
│   ├── useAuth.ts
│   ├── useTheme.ts
│   └── index.ts              # Barrel export
└── lib/
    ├── utils/
    │   ├── cn-util.ts
    │   └── index.ts          # Barrel export
    └── constants/
        ├── api-config.ts
        └── index.ts          # Barrel export
```

## Export Types

### Named Exports (Preferred)

```typescript
// In component file
export const Button = () => { ... };

// In barrel
export { Button } from "./core-button";
```

### Re-exporting Types

```typescript
// Include types in barrel exports
export { Button, type ButtonProps } from "./core-button";
export type { CardProps } from "./core-card";
```

### Default Exports (Avoid)

Avoid default exports in component libraries. Named exports provide:
- Better IDE autocomplete
- Easier refactoring
- Consistent import names

## When to Create a Barrel

Create `index.ts` when:
- Directory has 2+ exported modules
- You want cleaner imports elsewhere
- Creating a component library

Skip barrel when:
- Single file in directory
- Internal/private modules
