# Generate TypeScript Bindings

Generate typed bindings for [dojo.js](https://github.com/dojoengine/dojo.js) frontend integration.

## Generate Bindings

```bash
# During build (preferred)
sozo build --typescript

# Standalone generation
sozo bindgen --typescript
```

## Generated Files

```
bindings/typescript/
├── contracts.gen.ts   # setupWorld()
└── models.gen.ts      # SchemaType
```

## Usage in dojo.js

```typescript
import { setupWorld } from "./bindings/typescript/contracts.gen.ts";
import type { SchemaType } from "./bindings/typescript/models.gen.ts";

// Type-safe model access: entity.models.{namespace}.{ModelName}
```

## When to Regenerate

- After model changes
- After adding new systems
- After schema updates
