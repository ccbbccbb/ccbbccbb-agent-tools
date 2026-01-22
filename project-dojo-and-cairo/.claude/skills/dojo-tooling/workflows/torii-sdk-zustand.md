# Zustand Integration

Manage Dojo state with Zustand store.

**Source:** https://dojoengine.org/client/sdk/javascript#saving-state-with-zustand

## Convenience Hooks

The SDK provides built-in hooks:

```typescript
import { useDojoStore, useEntityQuery, useModel, useEntityId } from "@dojoengine/sdk";

// Query entities
const entities = useEntityQuery("namespace", "Model", [key]);

// Get single model
const position = useModel("namespace", "Position", entityId);

// Get entity ID
const entityId = useEntityId("namespace", "Model", [key]);
```

## Direct Store Access

For advanced control:

```typescript
const store = useDojoStore();

// Access state directly
const entities = store.getState().entities;

// Subscribe to changes
store.subscribe((state) => {
  console.log("State updated:", state);
});
```

## Automatic Updates

The SDK automatically updates the Zustand store when Torii detects changes, triggering component re-renders.

## Best Practices

| Scenario | Approach |
|----------|----------|
| Standard use cases | Use convenience hooks |
| Complex scenarios | Direct store access |
| Performance-sensitive | Use selectors with shallow comparison |
