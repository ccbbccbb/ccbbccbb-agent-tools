# Torii SQL Queries

Query Dojo entity state using direct SQL queries to Torii's `/sql` endpoint.

## Overview

This project uses HTTP-based SQL queries instead of WebSocket subscriptions for data fetching. This approach:
- Works reliably for all entity key formats
- Uses simple HTTP requests (no connection management)
- Allows manual refetch after state-changing actions

## Core Pattern

### 1. Execute SQL Query

```typescript
// client/src/dojo/torii-sql.ts
async function query<T>(sql: string): Promise<T[]> {
  const url = `${networkConfig.toriiUrl}/sql?query=${encodeURIComponent(sql)}`;
  const response = await fetch(url);
  return (await response.json()) as T[];
}
```

### 2. Hex Conversion for Keys

Torii stores numeric IDs as padded hex strings. Convert keys before querying:

```typescript
const toHex = (value: number | string): string => {
  const n = typeof value === "string" ? parseInt(value, 10) : value;
  return `0x${n.toString(16).padStart(16, "0")}`;
};
```

### 3. Table Naming Convention

Torii tables follow the pattern: `"namespace-ModelName"`

```sql
SELECT * FROM "rivals-Session" WHERE session_id = "0x0000000000000001"
SELECT * FROM "rivals-Battle" WHERE session_id = "0x0000000000000001" AND rival_index = 0
```

## Writing Query Functions

Export typed query functions in `client/src/dojo/torii-sql.ts`:

```typescript
export async function querySession(sessionId: string | number): Promise<Session | null> {
  const results = await query<Session>(
    `SELECT * FROM "rivals-Session" WHERE session_id = "${toHex(sessionId)}"`
  );
  return results[0] ?? null;
}

export async function queryPlayerTeam(sessionId: string | number): Promise<HybridInstance[]> {
  return await query<HybridInstance>(
    `SELECT * FROM "rivals-HybridInstance" WHERE session_id = "${toHex(sessionId)}" ORDER BY team_slot`
  );
}
```

## React Hook Pattern

Create hooks in `client/src/dojo/hooks/` following this pattern:

```typescript
export function useSession(sessionId: string | null): {
  session: ParsedSession | null;
  loading: boolean;
  error: string | null;
  refetch: () => Promise<void>;
} {
  const [session, setSession] = useState<ParsedSession | null>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  const refetch = useCallback(async () => {
    if (!sessionId) {
      setSession(null);
      setLoading(false);
      return;
    }
    setLoading(true);
    setError(null);
    try {
      const data = await querySession(sessionId);
      setSession(data ? parseSession(data) : null);
    } catch (err) {
      setError(err instanceof Error ? err.message : "Query failed");
    } finally {
      setLoading(false);
    }
  }, [sessionId]);

  useEffect(() => {
    refetch();
  }, [refetch]);

  return { session, loading, error, refetch };
}
```

**Key points:**
- Expose `refetch()` for post-action updates
- Handle null/undefined session ID gracefully
- Use parsers to transform raw Torii data

## Data Transformation

Raw SQL results need parsing (hex to decimal, snake_case to camelCase):

```typescript
// client/src/dojo/parsers.ts
export function parseSession(session: Session): ParsedSession {
  return {
    sessionId: toStringValue(session.session_id),
    playerAddress: session.player_address,
    currentRivalIndex: toNumber(session.current_rival_index),
    credits: toNumber(session.credits),
    // ...
  };
}
```

## Example Reference Files

- Query functions: `client/src/dojo/torii-sql.ts`
- React hooks: `client/src/dojo/hooks/`
- Data parsers: `client/src/dojo/parsers.ts`
- Generated types: `client/src/generated/typescript/models.gen.ts`
