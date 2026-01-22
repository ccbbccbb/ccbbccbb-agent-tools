# Create Component Workflow

Steps for creating a new React component following project conventions.

## Workflow Steps

### 1. Determine Component Type

| Type | Location | Naming |
|------|----------|--------|
| Core/primitive | `components/core/` | `core-{name}.tsx` |
| Feature component | `components/{feature}/` | `{name}.tsx` |
| Page/screen | `app/screens/` | `{name}-screen.tsx` |

### 2. Create Component File

**For core components:**

```bash
# Create file with core- prefix
touch src/components/core/core-{name}.tsx
```

**For feature components:**

```bash
# Create file in appropriate directory
touch src/components/{feature}/{name}.tsx
```

### 3. Implement Component

Use CVA pattern for components with variants:

```typescript
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils/cn-util";

const {name}Variants = cva(
  "base-classes-here",
  {
    variants: {
      variant: {
        default: "default-styles",
        primary: "primary-styles",
      },
      size: {
        sm: "small-styles",
        md: "medium-styles",
        lg: "large-styles",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    },
  }
);

interface I{Name}Props
  extends React.HTMLAttributes<HTMLDivElement>,
    VariantProps<typeof {name}Variants> {}

export const {Name} = ({ className, variant, size, ...props }: I{Name}Props) => {
  return (
    <div className={cn({name}Variants({ variant, size }), className)} {...props} />
  );
};
```

### 4. Update Barrel Export

Add to the directory's `index.ts`:

```typescript
export { {Name} } from "./core-{name}";
// or
export { {Name} } from "./{name}";
```

### 5. Verify

- [ ] File uses correct naming convention
- [ ] Component uses CVA if it has variants
- [ ] Props interface extends HTML attributes
- [ ] className prop is merged with cn()
- [ ] Barrel export is updated
- [ ] TypeScript compiles without errors

## Examples

### Core Button

```typescript
// src/components/core/core-button.tsx
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils/cn-util";

const buttonVariants = cva(
  "inline-flex items-center justify-center rounded-md font-medium transition-colors",
  {
    variants: {
      variant: {
        default: "bg-gray-100 hover:bg-gray-200",
        primary: "bg-blue-500 text-white hover:bg-blue-600",
        destructive: "bg-red-500 text-white hover:bg-red-600",
      },
      size: {
        sm: "h-8 px-3 text-xs",
        md: "h-10 px-4 text-sm",
        lg: "h-12 px-6 text-base",
      },
    },
    defaultVariants: {
      variant: "default",
      size: "md",
    },
  }
);

interface IButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {}

export const Button = React.forwardRef<HTMLButtonElement, IButtonProps>(
  ({ className, variant, size, ...props }, ref) => {
    return (
      <button
        className={cn(buttonVariants({ variant, size }), className)}
        ref={ref}
        {...props}
      />
    );
  }
);

Button.displayName = "Button";
```

## Output

Report:
- Component file created at: `{path}`
- Barrel export updated: `{barrel-path}`
- Ready for use: `import { {Name} } from "@/components/{...}";`
