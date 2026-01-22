# Analyze Katana & Torii Logs

Fetch and analyze logs from Dojo development services to identify issues.

## Workflow Steps

### 1. Fetch Recent Logs

```bash
./contracts/scripts/dev.sh logs
```

Or directly:

```bash
# Katana logs
tail -50 katana.log

# Torii logs
tail -50 torii.log
```

### 2. Parse Katana Logs

Look for:
- **Errors:** `grep -i "error" katana.log`
- **Warnings:** `grep -i "warn" katana.log`
- **Transaction failures:** `grep -i "fail\|reject" katana.log`

Common Katana issues:
- Transaction reverted
- Gas estimation failed
- State corruption

### 3. Parse Torii Logs

Look for:
- **Errors:** `grep -i "error" torii.log`
- **Indexing issues:** `grep -i "index\|sync" torii.log`
- **Connection problems:** `grep -i "connect\|rpc" torii.log`

Common Torii issues:
- Failed to connect to Katana
- World address mismatch
- Indexing lagged behind

### 4. Summarize Problems

Report:
- Number of errors/warnings found
- Specific error messages
- Timestamps of issues

### 5. Suggest Solutions

Based on log analysis:

| Log Pattern | Likely Issue | Solution |
|-------------|--------------|----------|
| "Connection refused" | Katana not running | Start Katana |
| "World not found" | Wrong world address | Re-migrate with `sozo migrate` |
| "Transaction reverted" | Contract error | Check contract logic |
| "Sync failed" | Indexing issue | Restart Torii |

## Follow Logs in Real-Time

```bash
# Follow Katana
tail -f katana.log

# Follow Torii
tail -f torii.log

# Follow both
tail -f katana.log torii.log
```

## Search Specific Patterns

```bash
# Find all errors
grep -n "ERROR\|error\|Error" katana.log torii.log

# Find timestamps of issues
grep -E "^\d{4}-\d{2}-\d{2}.*error" katana.log

# Find transaction hashes
grep -oE "0x[a-fA-F0-9]{64}" katana.log
```
