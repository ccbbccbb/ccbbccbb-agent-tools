# RetroUI Design Principles

RetroUI is a neobrutalist design system that creates bold, playful interfaces with distinctive visual characteristics.

**Official docs:** https://retroui.dev/docs/

## Core Philosophy

Neobrutalism combines:
- **Brutalism's raw honesty** - Visible structure, no hiding the mechanics
- **Playful, vibrant colors** - High contrast, bold palettes
- **Intentional "imperfection"** - Hard edges, offset shadows
- **Strong visual hierarchy** - Clear distinction between elements

## Visual Characteristics

### 1. Hard Shadows (Offset Drop Shadows)

The signature neobrutalist element - solid color shadows offset from elements:

```css
/* Standard shadow */
shadow-[4px_4px_0px_0px_var(--accent)]

/* Hover state - shadow shrinks */
shadow-[2px_2px_0px_0px_var(--accent)]

/* Active/pressed state - no shadow */
shadow-none
```

Shadow colors match the element's purpose:
- `--accent` - Default interactive elements
- `--error` - Destructive/error states
- `--warning` - Warning states
- `--border-muted` - Subtle/non-interactive elements

### 2. Bold Borders

Strong, visible borders define element boundaries:

```css
border-2 border-accent      /* Standard border */
border-2 border-border-muted /* Muted border */
border-2 border-error        /* Status borders */
```

### 3. No Rounded Corners

Neobrutalism favors sharp, geometric shapes:

```css
rounded-none  /* Always */
```

### 4. Interactive Feedback

Elements physically respond to interaction through translation:

```css
/* Hover - slight movement toward shadow */
hover:translate-x-0.5 hover:translate-y-0.5

/* Active/pressed - full movement, shadow disappears */
active:translate-x-1 active:translate-y-1 active:shadow-none
```

### 5. High Contrast Typography

- **UPPERCASE** text for headings and interactive elements
- **Bold weights** for emphasis
- **Wide letter-spacing** (tracking-wider)
- **Monospace or geometric fonts**

```css
font-bold uppercase tracking-wider
```

## Color Usage

### Primary Palette

| Role | Color | Usage |
|------|-------|-------|
| Primary/Accent | `#F2E14C` (yellow) | Buttons, highlights, focus states |
| Foreground | `#000000` (black) | Text, borders, shadows |
| Background | `#ffffff` (white) | Page background |

### Status Colors

| Status | Color | Usage |
|--------|-------|-------|
| Error | `#ff4444` (red) | Destructive actions, errors |
| Warning | `#ffaa00` (orange) | Warnings, caution |
| Success | `#22c55e` (green) | Success states |

## Animation Principles

All transitions should be:
- **Quick**: 200ms duration
- **Smooth**: Standard easing
- **Purposeful**: Only animate what changes

```css
transition-all duration-200
```

## Anti-Patterns

Avoid these in neobrutalist design:
- Gradients (use solid colors)
- Soft/blurred shadows (use hard offset shadows)
- Rounded corners (use sharp edges)
- Subtle/muted interactive feedback (be bold)
- Light/thin borders (use 2px+ borders)
- Lowercase UI text (use uppercase for controls)
