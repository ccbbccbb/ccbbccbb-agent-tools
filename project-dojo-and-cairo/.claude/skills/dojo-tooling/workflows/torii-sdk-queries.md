# Querying Entities

Fetch entities from Torii using ToriiQueryBuilder.

**Source:** https://dojoengine.org/client/sdk/javascript#querying-entities

## Important: Return Type

**`getEntities()` returns a `Pagination<T>` object, NOT a raw array!**

```typescript
// ❌ WRONG
const entities = await sdk.getEntities({...});
for (const e of entities) { }  // TypeError: not iterable

// ✅ CORRECT - call .getItems() to extract array
const result = await sdk.getEntities({...});
const entities = result.getItems();
```

## Basic Query (KeysClause)

Query by entity keys:

```typescript
import { KeysClause, ToriiQueryBuilder } from "@dojoengine/sdk";

const result = await sdk.getEntities({
  query: new ToriiQueryBuilder()
    .withClause(KeysClause(["namespace", "Model"], ["key1"]).build())
    .build(),
});
const entities = result.getItems();  // Extract array from Pagination
```

## Conditional Query (MemberClause)

Query by model field values:

```typescript
import { MemberClause } from "@dojoengine/sdk";

const result = await sdk.getEntities({
  query: new ToriiQueryBuilder()
    .withClause(
      MemberClause("namespace", "Model", "field", "Eq", value).build()
    )
    .build(),
});
const entities = result.getItems();
```

## Composite Query

Combine multiple conditions:

```typescript
import { AndComposeClause } from "@dojoengine/sdk";

const query = new ToriiQueryBuilder()
  .withClause(
    AndComposeClause([
      MemberClause("ns", "Model", "field1", "Gt", 10),
      MemberClause("ns", "Model", "field2", "Eq", "active"),
    ]).build()
  )
  .build();
```

## Pagination

Handle large datasets:

```typescript
const query = new ToriiQueryBuilder()
  .withClause(clause)
  .withLimit(10)
  .withOffset(20)
  .withOrderBy("field", "Asc")
  .build();
```

## Access Results

```typescript
const value = entity.models.namespace.ModelName;
```
