# SDK Setup

Initialize the Dojo.js SDK for frontend integration.

**Source:** https://dojoengine.org/client/sdk/javascript

## Install Packages

```bash
pnpm add @dojoengine/core @dojoengine/sdk @dojoengine/torii-client
```

## Generate TypeScript Bindings

```bash
sozo build --typescript
```

Generated files:
```
bindings/typescript/
├── contracts.gen.ts   # setupWorld()
└── models.gen.ts      # SchemaType
```

## Initialize SDK (Once)

```typescript
import { init } from "@dojoengine/sdk";
import { SchemaType } from "./bindings/models.gen";

const sdk = await init<SchemaType>({
  client: {
    toriiUrl: "http://localhost:8080",
    worldAddress: "0x...",
    relayUrl: "/ip4/127.0.0.1/tcp/9090",
  },
});
```

**Important:** Call `init()` only once per application lifecycle.

## Environment Variables

```
NEXT_PUBLIC_TORII_URL=http://localhost:8080
NEXT_PUBLIC_WORLD_ADDRESS=0x...
```

## Prerequisites

- Katana running on port 5050
- Torii running on port 8080
- World deployed via `sozo migrate`
