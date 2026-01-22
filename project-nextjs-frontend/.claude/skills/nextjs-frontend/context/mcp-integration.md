# Next.js DevTools MCP Integration

Next.js 16+ exposes an MCP (Model Context Protocol) endpoint at `/_next/mcp` automatically when the dev server starts. No configuration needed.

## Available MCP Tools

### Discovery

Use `nextjs_index` to discover running servers and available tools:

```
mcp__next-devtools__nextjs_index
```

Returns:
- Server port, PID, and URL
- Complete list of available MCP tools
- Tool descriptions and input schemas

### Calling Tools

Use `nextjs_call` to execute specific tools on a running server:

```
mcp__next-devtools__nextjs_call(port="3000", toolName="get_errors")
```

Common tools include:
- `get_errors` - Get compilation/runtime errors
- `get_routes` - List all routes
- `get_build_status` - Check compilation state
- `clear_cache` - Clear caches

### Browser Automation

Use `browser_eval` for page verification and testing:

```
mcp__next-devtools__browser_eval(action="navigate", url="http://localhost:3000")
mcp__next-devtools__browser_eval(action="console_messages", errorsOnly=true)
```

## Workflow Example

1. **Check for running servers:**
   ```
   nextjs_index
   ```

2. **Get current errors:**
   ```
   nextjs_call(port="3000", toolName="get_errors")
   ```

3. **Verify page loads correctly:**
   ```
   browser_eval(action="start")
   browser_eval(action="navigate", url="http://localhost:3000")
   browser_eval(action="console_messages", errorsOnly=true)
   ```

4. **Take screenshot for verification:**
   ```
   browser_eval(action="screenshot", fullPage=true)
   ```

## When to Use MCP

- **Before implementing changes**: Check current errors and routes
- **After making changes**: Verify no new errors introduced
- **Debugging issues**: Get runtime diagnostics
- **Page verification**: Use browser automation instead of curl

## Requirements

- Next.js 16 or later
- Dev server running (`npm run dev` or `bun dev`)
- For versions < 16, use the upgrade tool first
