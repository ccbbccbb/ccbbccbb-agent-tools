# Component Feature Flags Pattern

Components support optional feature flags for audio and animation. Both default to `false` to keep components lightweight.

## Flag Definitions

```typescript
interface ComponentWithFlagsProps {
  /** Enable animation effects. @default false */
  useAnimation?: boolean;

  /** Enable sound effects. @default false */
  useSFX?: boolean;
}
```

## Usage Examples

```tsx
// Animation only
<Button useAnimation>CLICK ME</Button>

// SFX only
<Button useSFX>CLICK ME</Button>

// Both animation and SFX
<Button useAnimation useSFX>CLICK ME</Button>

// Neither (default behavior)
<Button>CLICK ME</Button>
```

## Implementation Pattern

```tsx
"use client";

import { useAnimation } from "@/hooks";
import { useSFX } from "@/hooks";

interface MyComponentProps {
  useAnimation?: boolean;
  useSFX?: boolean;
  children: React.ReactNode;
}

export function MyComponent({
  useAnimation: enableAnimation = false,
  useSFX: enableSFX = false,
  children,
}: MyComponentProps) {
  const { trigger, animationClass } = useAnimation("bounce", {
    enabled: enableAnimation,
  });

  const { play } = useSFX({ enabled: enableSFX });

  const handleClick = () => {
    if (enableSFX) play("click");
    if (enableAnimation) trigger();
  };

  return (
    <div className={animationClass} onClick={handleClick}>
      {children}
    </div>
  );
}
```

## Component-Specific Defaults

| Component | Default Animation | Default SFX |
|-----------|-------------------|-------------|
| Button | bounce | click |
| Card | fadeIn | - |
| Modal | scaleIn | - |
| ListItem | pop (hover) | select |
| Alert | shake (error) | error |

## Animation Types

| Type | Use Case | Duration |
|------|----------|----------|
| blink | Menu highlights | 200ms |
| pulse | Loading, processing | 1000ms loop |
| bounce | Selection feedback | 300ms |
| shake | Error, damage | 300ms |
| fadeIn | Screen transitions | 300ms |
| slideIn | Panel entrance | 300ms |

## Sound Categories

| Category | Examples |
|----------|----------|
| ui | click, hover, select, cancel, confirm |
| battle | attack, damage, heal, faint, switch |
| notification | error, success, warning, level-up |
