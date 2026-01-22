# Export Patterns

## Barrel Exports (index.ts)

Each major directory has an `index.ts` that re-exports all public modules. Use named exports, not default exports.

### Components (`src/components/index.ts`)

```typescript
// Game components - named exports from kebab-case files
export { Box, Card } from "./box";
export { Button, buttonVariants } from "./button";
export { ProgressBar } from "./progress-bar";
export { CreatureSprite } from "./creature-sprite";
export { TypeBadge } from "./type-badge";
export { HpBar } from "./hp-bar";

// Draft components
export { DraftGrid } from "./draft-grid";
export { DraftDetailView } from "./draft-detail-view";

// RetroUI components (subdirectory)
export { Badge } from "./retroui/badge";
export { Input } from "./retroui/input";
export { Alert } from "./retroui/alert";
```

### Hooks (`src/hooks/index.ts`)

```typescript
// Re-export everything from camelCase hook files
export * from "./useDojoActions";
export * from "./useGameState";
export { useQueryWithRefetch, useQueryArrayWithRefetch } from "./useQueryWithRefetch";

// Audio hooks
export { useAudio } from "./useAudio";
export { useSFX } from "./useSFX";
export { useMusic } from "./useMusic";

// Animation hooks
export { useAnimation } from "./useAnimation";
```

### Models (`src/models/index.ts`)

```typescript
// Types and interfaces from kebab-case files
export * from "./session";
export * from "./battle";
export * from "./hybrid-instance";
export * from "./draft-option";
export * from "./item";

// Enums
export { SessionState, BattleStatus } from "./enums";

// Utility functions
export { calculateMaxHp, rivalToHybrid } from "./calculations";
```

### Constants (`src/constants/index.ts`)

```typescript
// Static game data from kebab-case files
export { SPECIES } from "./species-data";
export { MOVES } from "./move-data";
export { ITEMS } from "./item-data";
export { TRAITS } from "./trait-data";
export { TYPE_CHART } from "./type-chart";
```

## Export Rules

1. **Named exports only** - No default exports except Next.js pages
2. **Export from barrel** - Import from `@/components`, not `@/components/button`
3. **PascalCase exports** - Component and type names are PascalCase
4. **camelCase exports** - Functions and hooks are camelCase

```typescript
// Correct - import from barrel
import { Button, Card, CreatureSprite } from "@/components";
import { useGameState, useSFX } from "@/hooks";
import { SPECIES, MOVES } from "@/constants";

// Incorrect - direct file import
import { Button } from "@/components/button";
import { useGameState } from "@/hooks/useGameState";
```

## Screen Exports (Exception)

Screen components use **default exports** for Next.js compatibility:

```typescript
// src/app/screens/draft-screen.tsx
export default function DraftScreen({ ... }) { ... }

// Usage in page.tsx - import directly (not from barrel)
import DraftScreen from "./screens/draft-screen";
```
