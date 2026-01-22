# Subscribing to Entity Changes

Real-time updates when blockchain state changes.

**Source:** https://dojoengine.org/client/sdk/javascript#subscribing-to-entity-changes

## SDK v1.8.x Return Types

**IMPORTANT:** The return types differ between initial data and callback data:

| Source | Type | Access Pattern |
|--------|------|----------------|
| Initial data (first element) | `Pagination<T>` | Call `.getItems()` to get array |
| Callback `data` | `Array<ParsedEntity>` | Already an array, use directly |

## Entity Subscription

```typescript
const [initialData, subscription] = await sdk.subscribeEntityQuery({
  query: new ToriiQueryBuilder()
    .withClause(KeysClause(["ns", "Model"], [key]).build())
    .includeHashedKeys(),
  callback: ({ data, error }) => {
    if (error) {
      console.error(error);
      return;
    }
    // Callback data IS already an array - use directly
    updateState(data);
  },
});

// IMPORTANT: Initial data is Pagination object - must call .getItems()
const entities = initialData?.getItems?.() ?? [];
processEntities(entities);
```

## Event Subscription

```typescript
const [initialEvents, subscription] = await sdk.subscribeEventQuery({
  query: eventQuery,
  callback: ({ data, error }) => {
    if (data) handleEvent(data);
  },
});
```

## React Hook Pattern

```typescript
useEffect(() => {
  let subscription;

  async function subscribe() {
    const [initialData, sub] = await sdk.subscribeEntityQuery({
      query: query,
      callback: ({ data }) => updateState(data),  // data is already an array
    });
    subscription = sub;

    // IMPORTANT: initialData is Pagination - extract array with .getItems()
    const entities = initialData?.getItems?.() ?? [];
    processEntities(entities);

    setIsInitialized(true);  // Track initialization for loading states
  }

  subscribe();

  // Cleanup on unmount
  return () => {
    subscription?.cancel();
  };
}, []);
```

## Key Points

- Subscriptions return `[Pagination<T>, Subscription]` (NOT a raw array!)
- **Initial data is `Pagination` object** - call `.getItems()` to get array
- **Callback data is already an array** - use directly
- Use `isInitialized` flag to track loading state (don't rely on empty data)
- Callback receives `{ data, error }` object
- Call `subscription.cancel()` on cleanup
- Updates trigger when Torii detects blockchain changes
