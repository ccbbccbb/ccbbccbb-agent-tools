# RetroUI Component Patterns

Standard patterns for building RetroUI components in this project.

## CVA (Class Variance Authority) Pattern

All RetroUI components use CVA for variant management:

```typescript
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils/cn-util";

// 1. Define variants
const componentVariants = cva(
  // Base classes (always applied)
  "rounded-none border-2 font-bold uppercase tracking-wider transition-all duration-200",
  {
    variants: {
      variant: {
        default: "border-accent bg-card shadow-[4px_4px_0px_0px_var(--accent)]",
        accent: "border-accent bg-accent text-accent-foreground",
      },
      size: {
        sm: "px-2 py-1 text-xs",
        md: "px-4 py-2 text-sm",
        lg: "px-6 py-3 text-base",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    },
  }
);

// 2. Define props interface
interface ComponentProps
  extends HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof componentVariants> {
  className?: string;
}

// 3. Create component
export const Component = ({ className, variant, size, ...props }: ComponentProps) => {
  return (
    <div className={cn(componentVariants({ variant, size }), className)} {...props} />
  );
};
```

## Compound Components Pattern

For complex components with sub-parts (Card, Alert):

```typescript
// Main component
const Card = ({ className, variant, ...props }: ICardProps) => (
  <div className={cn(cardVariants({ variant }), className)} {...props} />
);

// Sub-components
const CardHeader = ({ className, ...props }: ICardHeaderProps) => (
  <div className={cn("flex flex-col justify-start p-4 pb-2", className)} {...props} />
);

const CardTitle = ({ className, children, ...props }: ICardTitleProps) => (
  <h3 className={cn("font-bold text-accent text-sm uppercase tracking-wider", className)} {...props}>
    {children}
  </h3>
);

// Combine with Object.assign
const CardComponent = Object.assign(Card, {
  Header: CardHeader,
  Title: CardTitle,
});

export { CardComponent as Card };
```

Usage:
```tsx
<Card variant="accent">
  <Card.Header>
    <Card.Title>Title</Card.Title>
  </Card.Header>
  <Card.Content>Content here</Card.Content>
</Card>
```

## forwardRef Pattern

For components that need ref forwarding (inputs, buttons):

```typescript
export const Button = React.forwardRef<HTMLButtonElement, IButtonProps>(
  ({ className, variant, size, ...props }, forwardedRef) => {
    return (
      <button
        className={cn(buttonVariants({ variant, size }), className)}
        ref={forwardedRef}
        {...props}
      />
    );
  }
);

Button.displayName = "Button";
```

## Animation/SFX Integration

Interactive components can include animation and sound effect hooks:

```typescript
import type { AnimationType } from "@/animations/index";
import { useAnimation } from "@/hooks/useAnimation";
import { type SFXType, useSFX } from "@/hooks/useSFX";

interface IButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  /** Enable animation effects. @default false */
  useAnimations?: boolean;
  /** Animation type to use when enabled. @default "bounce" */
  animationType?: AnimationType;
  /** Enable sound effects. @default false */
  useSFX?: boolean;
  /** SFX type to play when enabled. @default "click" */
  sfxType?: SFXType;
}
```

## Standard Variant Structures

### Visual Variants
```typescript
variant: {
  default: "border-border-muted bg-card shadow-[4px_4px_0px_0px_var(--border-muted)]",
  accent: "border-accent bg-accent/10 shadow-[4px_4px_0px_0px_var(--accent)]",
  warning: "border-warning bg-warning/10 shadow-[4px_4px_0px_0px_var(--warning)]",
  error: "border-error bg-error/10 shadow-[4px_4px_0px_0px_var(--error)]",
}
```

### Size Variants
```typescript
size: {
  sm: "px-2 py-1 text-xs",
  md: "px-4 py-2 text-sm",
  lg: "px-6 py-3 text-base",
  icon: "p-2",  // For icon-only buttons
}
```

### Interactive Variants
```typescript
interactive: {
  true: "cursor-pointer hover:translate-x-0.5 hover:translate-y-0.5 active:translate-x-1 active:translate-y-1 active:shadow-none",
  false: "",
}
```

## File Location

All core RetroUI components live in:
```
client/src/components/core/
├── core-button.tsx
├── core-card.tsx
├── core-badge.tsx
├── core-alert.tsx
├── core-input.tsx
├── core-text.tsx
├── core-drawer.tsx
├── core-modal.tsx
└── ...
```
