# Torii SDK Reference

Quick reference for the Dojo.js SDK API (v1.8.x).

**Source:** https://dojoengine.org/client/sdk/javascript

## Core SDK Methods

| Method | Purpose | Return Type |
|--------|---------|-------------|
| `getEntities()` | Retrieve entities with filtering | `Pagination<T>` |
| `subscribeEntityQuery()` | Real-time entity updates | `[Pagination<T>, Subscription]` |
| `getEventMessages()` | Fetch historical events | `Pagination<T>` |
| `subscribeEventQuery()` | Real-time event stream | `[Pagination<T>, Subscription]` |
| `sendMessage()` | Signed off-chain messages | `Promise<string>` |

## Critical: Pagination Return Type

**All query methods return `Pagination<T>` objects, NOT raw arrays!**

```typescript
// ❌ WRONG - initialData is Pagination, not array
const [initialData, sub] = await sdk.subscribeEntityQuery({...});
for (const entity of initialData) { }  // TypeError: not iterable

// ✅ CORRECT - extract array with .getItems()
const entities = initialData.getItems();
for (const entity of entities) { }
```

**Exception:** Subscription callback `data` IS already an array.

## Query Operators

All queries use `ToriiQueryBuilder` with these operators:

| Operator | Description |
|----------|-------------|
| `Eq` | Equal to |
| `Neq` | Not equal to |
| `Gt` | Greater than |
| `Gte` | Greater than or equal |
| `Lt` | Less than |
| `Lte` | Less than or equal |
| `In` | Value in array |
| `NotIn` | Value not in array |

## Clause Types

| Clause | Purpose |
|--------|---------|
| `KeysClause` | Query by entity keys |
| `MemberClause` | Query by model field values |
| `AndComposeClause` | Combine clauses with AND |
| `OrComposeClause` | Combine clauses with OR |

## Pagination Methods

```typescript
new ToriiQueryBuilder()
  .withClause(clause)
  .withLimit(10)      // Limit results
  .withOffset(20)     // Skip results
  .withOrderBy("field", "Asc")  // Sort results
  .build();
```

## Entity Result Structure

Access model data using:

```typescript
entity.models.{namespace}.{ModelName}
```

## SDK Packages

| Package | Purpose |
|---------|---------|
| `@dojoengine/core` | Core utilities |
| `@dojoengine/sdk` | Main SDK (init, queries, subscriptions) |
| `@dojoengine/torii-client` | Torii WASM client |
