# Create RetroUI Component Workflow

Step-by-step guide for creating new RetroUI components.

## Prerequisites

Load context before starting:
- `context/retroui-design-principles.md` - Neobrutalism visual rules
- `context/component-patterns.md` - CVA and compound patterns
- `context/theme-system.md` - Color and styling references

## Workflow Steps

### 1. Determine Component Type

| Component Type | Pattern | Example |
|----------------|---------|---------|
| Simple element | Basic CVA | Badge, Text |
| Interactive element | CVA + forwardRef | Button, Input |
| Container with parts | Compound component | Card, Alert |

### 2. Create Component File

Location: `client/src/components/core/core-{component-name}.tsx`

Use kebab-case with `core-` prefix for filename.

### 3. Set Up Imports

```typescript
"use client";

import { cva, type VariantProps } from "class-variance-authority";
import React, { type HTMLAttributes } from "react";
import { cn } from "@/lib/utils/cn-util";

// If interactive, add these:
import type { AnimationType } from "@/animations/index";
import { useAnimation } from "@/hooks/useAnimation";
import { type SFXType, useSFX } from "@/hooks/useSFX";
```

### 4. Define Variants with CVA

Apply neobrutalist styling:

```typescript
const componentVariants = cva(
  // Base classes - always include these for neobrutalism:
  "rounded-none border-2 transition-all duration-200",
  {
    variants: {
      variant: {
        default:
          "border-border-muted bg-card shadow-[4px_4px_0px_0px_var(--border-muted)]",
        accent:
          "border-accent bg-card shadow-[4px_4px_0px_0px_var(--accent)]",
        error:
          "border-error bg-error/10 shadow-[4px_4px_0px_0px_var(--error)]",
      },
      size: {
        sm: "px-2 py-1 text-xs",
        md: "px-4 py-2 text-sm",
        lg: "px-6 py-3 text-base",
      },
      // Add interactive variant for clickable elements
      interactive: {
        true: "cursor-pointer hover:translate-x-0.5 hover:translate-y-0.5 hover:shadow-[2px_2px_0px_0px_var(--accent)] active:translate-x-1 active:translate-y-1 active:shadow-none",
        false: "",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
      interactive: false,
    },
  }
);
```

### 5. Define Props Interface

```typescript
interface IComponentProps
  extends HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof componentVariants> {
  className?: string;

  // For interactive components:
  /** Enable animation effects. @default false */
  useAnimations?: boolean;
  /** Animation type to use when enabled. @default "fadeIn" */
  animationType?: AnimationType;
  /** Enable sound effects. @default false */
  useSFX?: boolean;
  /** SFX type to play when enabled. @default "click" */
  sfxType?: SFXType;
}
```

### 6. Implement Component

**Simple component:**
```typescript
export const Component = ({
  className,
  variant,
  size,
  ...props
}: IComponentProps) => {
  return (
    <div
      className={cn(componentVariants({ variant, size }), className)}
      {...props}
    />
  );
};
```

**With forwardRef (for inputs/buttons):**
```typescript
export const Component = React.forwardRef<HTMLDivElement, IComponentProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <div
        className={cn(componentVariants({ variant, size }), className)}
        ref={ref}
        {...props}
      />
    );
  }
);

Component.displayName = "Component";
```

### 7. Add Compound Sub-Components (if needed)

```typescript
const ComponentHeader = ({ className, ...props }: HTMLAttributes<HTMLDivElement>) => (
  <div className={cn("p-4 pb-2", className)} {...props} />
);

// Combine with Object.assign
const ComponentExport = Object.assign(Component, {
  Header: ComponentHeader,
});

export { ComponentExport as Component };
```

### 8. Export from Core Index

Add to `client/src/components/core/index.ts` (if exists):

```typescript
export { Component } from "./core-component";
```

## Checklist

Before completing:

- [ ] File uses `core-` prefix and kebab-case naming
- [ ] Component uses CVA for variants
- [ ] Base classes include `rounded-none border-2 transition-all duration-200`
- [ ] Shadows use CSS variable syntax: `shadow-[4px_4px_0px_0px_var(--accent)]`
- [ ] Interactive elements have hover/active translate effects
- [ ] Props interface extends HTML attributes + VariantProps
- [ ] `cn()` is used for className merging
- [ ] displayName is set for forwardRef components
- [ ] Animation/SFX hooks added if interactive
- [ ] TypeScript compiles without errors
