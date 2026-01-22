# Browser Testing Workflow

Steps for testing Next.js pages using browser automation.

## Workflow Steps

### 1. Start Browser Session

```
mcp__next-devtools__browser_eval(action="start", headless=true)
```

Options:
- `headless=true` for automated testing (default)
- `headless=false` to watch the browser interact

### 2. Navigate to Target Page

```
mcp__next-devtools__browser_eval(action="navigate", url="http://localhost:3000/target-route")
```

### 3. Check for Errors

```
mcp__next-devtools__browser_eval(action="console_messages", errorsOnly=true)
```

Review output for:
- JavaScript runtime errors
- React hydration mismatches
- Failed network requests
- Unhandled promise rejections

### 4. Take Screenshot

```
mcp__next-devtools__browser_eval(action="screenshot", fullPage=true)
```

Options:
- `fullPage=true` captures entire scrollable page
- `fullPage=false` (default) captures viewport only

### 5. Test Interactions (if needed)

```
# Click navigation
mcp__next-devtools__browser_eval(action="click", element="a[href='/dashboard']")

# Fill form
mcp__next-devtools__browser_eval(action="type", element="input[name='search']", text="query")

# Submit
mcp__next-devtools__browser_eval(action="click", element="button[type='submit']")
```

### 6. Verify State

```
# Run JavaScript to check state
mcp__next-devtools__browser_eval(action="evaluate", script="window.location.pathname")
```

### 7. Clean Up

```
mcp__next-devtools__browser_eval(action="close")
```

## Common Scenarios

### Verify Page Loads Without Errors

```
browser_eval(action="start")
browser_eval(action="navigate", url="http://localhost:3000")
browser_eval(action="console_messages", errorsOnly=true)
browser_eval(action="screenshot")
browser_eval(action="close")
```

### Test Form Submission

```
browser_eval(action="start")
browser_eval(action="navigate", url="http://localhost:3000/contact")
browser_eval(action="fill_form", fields=[
  {"selector": "#name", "value": "Test User"},
  {"selector": "#email", "value": "test@example.com"},
  {"selector": "#message", "value": "Test message"}
])
browser_eval(action="click", element="button[type='submit']")
browser_eval(action="console_messages", errorsOnly=true)
browser_eval(action="screenshot")
browser_eval(action="close")
```

### Test Navigation Flow

```
browser_eval(action="start")
browser_eval(action="navigate", url="http://localhost:3000")
browser_eval(action="click", element="nav a[href='/about']")
browser_eval(action="evaluate", script="window.location.pathname")  # Should be "/about"
browser_eval(action="screenshot")
browser_eval(action="close")
```

### Test Multiple Routes

```
browser_eval(action="start")

# Route 1
browser_eval(action="navigate", url="http://localhost:3000")
browser_eval(action="console_messages", errorsOnly=true)
browser_eval(action="screenshot")

# Route 2
browser_eval(action="navigate", url="http://localhost:3000/dashboard")
browser_eval(action="console_messages", errorsOnly=true)
browser_eval(action="screenshot")

# Route 3
browser_eval(action="navigate", url="http://localhost:3000/settings")
browser_eval(action="console_messages", errorsOnly=true)
browser_eval(action="screenshot")

browser_eval(action="close")
```

## Output

Report:
- Pages tested: `{routes}`
- Errors found: `{error-count}`
- Screenshots captured: `{screenshot-count}`
- Issues to address: `{issues-list}`
