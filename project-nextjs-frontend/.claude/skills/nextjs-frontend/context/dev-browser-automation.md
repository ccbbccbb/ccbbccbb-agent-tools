# Dev-Browser Plugin Automation

Browser automation using Playwright via the dev-browser plugin for testing and verification.

## Plugin Reference

The `dev-browser:dev-browser` plugin provides Playwright browser automation with persistent page state.

### Available Actions

| Action | Purpose |
|--------|---------|
| `start` | Start browser automation (auto-installs if needed) |
| `navigate` | Navigate to a URL |
| `click` | Click on an element |
| `type` | Type text into an element |
| `fill_form` | Fill multiple form fields at once |
| `evaluate` | Execute JavaScript in browser context |
| `screenshot` | Take a screenshot of the page |
| `console_messages` | Get browser console messages |
| `close` | Close the browser |
| `drag` | Perform drag and drop |
| `upload_file` | Upload files |
| `list_tools` | List all available tools from the server |

### Browser Options

| Parameter | Values |
|-----------|--------|
| `browser` | `chrome`, `firefox`, `webkit`, `msedge` |
| `headless` | `true` / `false` |

## Usage Examples

### Start Browser Session

```
mcp__next-devtools__browser_eval(action="start", headless=true)
```

### Navigate and Verify Page

```
mcp__next-devtools__browser_eval(action="navigate", url="http://localhost:3000")
mcp__next-devtools__browser_eval(action="screenshot", fullPage=true)
```

### Check Console Errors

```
mcp__next-devtools__browser_eval(action="console_messages", errorsOnly=true)
```

### Form Interaction

```
# Click an element
mcp__next-devtools__browser_eval(action="click", element="button[type='submit']")

# Type into input
mcp__next-devtools__browser_eval(action="type", element="input[name='email']", text="test@example.com")

# Fill multiple fields
mcp__next-devtools__browser_eval(action="fill_form", fields=[
  {"selector": "input[name='email']", "value": "test@example.com"},
  {"selector": "input[name='password']", "value": "testpass"}
])
```

### Execute JavaScript

```
mcp__next-devtools__browser_eval(action="evaluate", script="document.title")
```

### Clean Up

```
mcp__next-devtools__browser_eval(action="close")
```

## When to Use

- **Page verification**: Load pages in a real browser instead of curl
- **Runtime error detection**: Catch JavaScript errors, hydration issues
- **Form testing**: Test form submissions and validation
- **Visual verification**: Take screenshots for UI review
- **User flow testing**: Simulate user interactions

## Why Browser vs Curl

For Next.js applications, browser automation is preferred over curl because:

- Executes JavaScript and detects runtime errors
- Catches React hydration issues
- Verifies the full rendered experience
- Captures browser console messages
- Tests client-side interactions

## Integration with Next.js MCP

Combine dev-browser with Next.js MCP for comprehensive testing:

1. **Check build status**: `nextjs_call(toolName="get_build_status")`
2. **Start browser**: `browser_eval(action="start")`
3. **Navigate to route**: `browser_eval(action="navigate", url="...")`
4. **Check for errors**: `browser_eval(action="console_messages", errorsOnly=true)`
5. **Verify with Next.js**: `nextjs_call(toolName="get_errors")`
6. **Screenshot for review**: `browser_eval(action="screenshot")`
