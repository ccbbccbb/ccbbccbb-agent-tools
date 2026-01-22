# RetroUI Theme System

CSS variables and theming configuration for the RetroUI design system.

## Theme Configuration

Theme is defined in `client/src/app/globals.css` using CSS custom properties with Tailwind v4 integration.

### Color Palette

```css
:root {
  /* Base colors - Original RetroUI yellow/black theme */
  --background: #ffffff;
  --foreground: #000000;

  /* Card backgrounds */
  --card: #ffffff;
  --card-foreground: #000000;

  /* Primary - Original RetroUI yellow */
  --primary: #F2E14C;
  --primary-foreground: #000000;

  /* Accent - Original RetroUI yellow */
  --accent: #F2E14C;
  --accent-foreground: #000000;

  /* Status colors */
  --error: #ff4444;
  --warning: #ffaa00;
  --success: #22c55e;
  --info: #3b82f6;

  /* Borders */
  --border: #000000;
  --border-muted: #e5e5e5;

  /* Neobrutalism shadows */
  --shadow-brutal: 4px 4px 0px 0px #000000;
}
```

## Using Colors in Components

### Tailwind Classes

```tsx
// Background colors
className="bg-background"     // Page background
className="bg-card"           // Card backgrounds
className="bg-primary"        // Primary yellow
className="bg-accent"         // Accent yellow
className="bg-error/10"       // Error with 10% opacity

// Text colors
className="text-foreground"           // Main text (black)
className="text-primary-foreground"   // Text on primary (black)
className="text-muted-foreground"     // Muted text (gray)
className="text-error"                // Error text

// Border colors
className="border-accent"       // Accent border
className="border-border"       // Strong black border
className="border-border-muted" // Subtle gray border
```

### CSS Variable References in Shadows

For hard shadows, reference CSS variables directly:

```tsx
// Standard neobrutalist shadow with accent color
className="shadow-[4px_4px_0px_0px_var(--accent)]"

// Error variant shadow
className="shadow-[4px_4px_0px_0px_var(--error)]"

// Hover state (smaller shadow)
className="shadow-[2px_2px_0px_0px_var(--accent)]"

// Muted shadow for non-primary elements
className="shadow-[4px_4px_0px_0px_var(--border-muted)]"
```

## Color Usage Guidelines

### Primary Actions

| Element | Background | Border | Text | Shadow |
|---------|------------|--------|------|--------|
| Primary button | `bg-primary` | `border-primary` | `text-primary-foreground` | `--accent` |
| Secondary button | `bg-secondary` | `border-accent` | `text-secondary-foreground` | `--accent` |
| Outline button | `bg-transparent` | `border-accent` | `text-foreground` | `--accent` |

### Status Indicators

| Status | Background | Border | Text | Shadow |
|--------|------------|--------|------|--------|
| Error | `bg-error/10` | `border-error` | `text-error` | `--error` |
| Warning | `bg-warning/10` | `border-warning` | `text-warning` | `--warning` |
| Success | `bg-success/10` | `border-success` | `text-success` | `--success` |

### Cards & Containers

| Variant | Background | Border | Shadow |
|---------|------------|--------|--------|
| Default | `bg-card` | `border-border-muted` | `--border-muted` |
| Accent | `bg-card` | `border-accent` | `--accent` |
| Selected | `bg-accent/10` | `border-accent` | `--accent` |

## Typography

Global typography settings:

```css
html, body {
  font-family: ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace;
  text-transform: uppercase;
  letter-spacing: 0.05em;
}
```

## Border Radius

Neobrutalism uses zero radius (sharp corners):

```css
:root {
  --radius: 0px;
}
```

Always use `rounded-none` in components.
