# Installed Core Components

Components in `client/src/components/core/`. All use RetroUI neobrutalist patterns.

**Official RetroUI docs:** https://retroui.dev/docs/

---

## Button
**File:** `core-button.tsx`

Interactive element for actions. Extended with `useAnimations` and `useSFX` props.

**Variants:** `default`, `secondary`, `outline`, `danger`, `accent`, `ghost`, `link`
**Sizes:** `sm`, `md`, `lg`, `icon`

```tsx
<Button variant="default" size="md" useSFX sfxType="click">
  Click Me
</Button>
```

---

## Card
**File:** `core-card.tsx`

Container for grouped content. Supports interactive and selected states.

**Variants:** `default`, `accent`, `warning`, `error`
**Modifiers:** `interactive`, `selected`
**Sub-components:** `Card.Header`, `Card.Title`, `Card.Description`, `Card.Content`, `Card.Footer`

```tsx
<Card variant="accent" interactive>
  <Card.Header>
    <Card.Title>Stats</Card.Title>
  </Card.Header>
  <Card.Content>Content</Card.Content>
</Card>
```

---

## Badge
**File:** `core-badge.tsx`

Non-interactive status indicator for tags, labels, counts.

**Variants:** `default`, `outline`, `solid`, `surface`, `warning`, `error`, `success`
**Sizes:** `sm`, `md`, `lg`

```tsx
<Badge variant="success" size="sm">Active</Badge>
```

---

## Alert
**File:** `core-alert.tsx`

System messages and notifications with status styling.

**Variants:** `default`, `solid`
**Status:** `error`, `success`, `warning`, `info`
**Sub-components:** `Alert.Title`, `Alert.Description`

```tsx
<Alert status="error">
  <Alert.Title>Error</Alert.Title>
  <Alert.Description>Something went wrong.</Alert.Description>
</Alert>
```

---

## Input
**File:** `core-input.tsx`

Text input with focus states and validation support.

```tsx
<Input placeholder="Enter name" aria-invalid={hasError} />
```

---

## Text
**File:** `core-text.tsx`

Typography with semantic HTML and consistent styling.

**As variants:** `h1`, `h2`, `h3`, `h4`, `h5`, `h6`, `p`, `li`, `a`

```tsx
<Text as="h1">Heading</Text>
<Text as="p">Body text</Text>
```

---

## Drawer
**File:** `core-drawer.tsx`

Slide-out panel for menus and settings. Uses Vaul under the hood.

**Sub-components:** `Drawer.Trigger`, `Drawer.Content`, `Drawer.Header`, `Drawer.Title`, `Drawer.Close`

```tsx
<Drawer>
  <Drawer.Trigger asChild>
    <Button>Open Menu</Button>
  </Drawer.Trigger>
  <Drawer.Content>
    <Drawer.Header>
      <Drawer.Title>Menu</Drawer.Title>
    </Drawer.Header>
    {/* content */}
  </Drawer.Content>
</Drawer>
```

---

## Drawer Trigger
**File:** `core-drawer-trigger.tsx`

Standalone drawer trigger component.

---

## Confirmation Drawer
**File:** `core-confirmation-drawer.tsx`

Specialized drawer for confirm/cancel actions.

---

## Modal
**File:** `core-modal.tsx`

Dialog overlay for focused content or actions.

---

## Loader
**File:** `core-loader.tsx`

Loading indicator with neobrutalist styling.

```tsx
<Loader />
```

---

## Sonner (Toast)
**File:** `core-sonner.tsx`

Toast notifications using Sonner library with RetroUI styling.

---

## Game Layout
**File:** `core-game-layout.tsx`

Main game screen layout wrapper.

---

## Type Chart
**File:** `core-type-chart.tsx`

Displays elemental type effectiveness chart.

---

## Team Offensive Chart
**File:** `core-team-offensive-chart.tsx`

Displays team offensive type coverage.

---

## Team Defensive Chart
**File:** `core-team-defensive-chart.tsx`

Displays team defensive type vulnerabilities.

---

## Animation/SFX Props

Interactive core components support these optional props:

| Prop | Type | Default | Description |
|------|------|---------|-------------|
| `useAnimations` | `boolean` | `false` | Enable animation effects |
| `animationType` | `AnimationType` | `"bounce"` | Animation type to use |
| `useSFX` | `boolean` | `false` | Enable sound effects |
| `sfxType` | `SFXType` | `"click"` | Sound effect type |
