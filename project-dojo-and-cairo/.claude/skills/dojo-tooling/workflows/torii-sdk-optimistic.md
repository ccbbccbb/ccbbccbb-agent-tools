# Optimistic Rendering

Show immediate UI feedback before blockchain confirmation.

**Source:** https://dojoengine.org/client/sdk/javascript#optimistic-client-rendering

## Pattern

```typescript
import { useDojoStore } from "@dojoengine/sdk";

async function executeAction() {
  const store = useDojoStore.getState();

  // 1. Snapshot current state
  const snapshot = store.entities.get(entityId);

  // 2. Apply optimistic update (using Immer)
  store.updateEntity(entityId, (draft) => {
    draft.models.namespace.Model.value = newValue;
  });

  try {
    // 3. Execute blockchain action
    await contractAction();

    // 4. Wait for entity change from subscription
    await sdk.waitForEntityChange(entityId, (entity) => {
      return entity?.models.namespace.Model.value === newValue;
    });
  } catch (error) {
    // 5. Rollback on error
    store.setEntity(entityId, snapshot);
  }
}
```

## Requirements

| Requirement | Why |
|-------------|-----|
| Active subscription | `waitForEntityChange` needs subscription to resolve |
| Error handling | Always rollback on failure |
| Immer | Use drafts for immutable updates |

## Signed Messages (Gas-Free)

For off-chain messaging without gas:

```typescript
// Generate typed data
const typedData = sdk.generateTypedData("namespace", "Model", data);

// Sign and send
await sdk.sendMessage(typedData);
```

**Note:** Requires `relayUrl` in SDK config for client-to-client broadcasting.
