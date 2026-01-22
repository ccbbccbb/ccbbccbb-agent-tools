# Component Patterns

Standard patterns for building React components.

## CVA (Class Variance Authority) Pattern

Use CVA for variant management:

```typescript
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils/cn-util";

// 1. Define variants
const componentVariants = cva(
  // Base classes (always applied)
  "rounded-md border font-medium transition-all duration-200",
  {
    variants: {
      variant: {
        default: "border-gray-200 bg-white",
        primary: "border-blue-500 bg-blue-500 text-white",
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
  <div className={cn("flex flex-col p-4 pb-2", className)} {...props} />
);

const CardTitle = ({ className, children, ...props }: ICardTitleProps) => (
  <h3 className={cn("font-bold text-sm", className)} {...props}>
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
<Card variant="primary">
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

## Standard Variant Structures

### Visual Variants
```typescript
variant: {
  default: "border-gray-200 bg-white",
  primary: "border-blue-500 bg-blue-500 text-white",
  secondary: "border-gray-500 bg-gray-100",
  destructive: "border-red-500 bg-red-500 text-white",
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

## File Location

Core components typically live in:
```
src/components/core/
├── core-button.tsx
├── core-card.tsx
├── core-input.tsx
├── core-modal.tsx
└── index.ts
```
