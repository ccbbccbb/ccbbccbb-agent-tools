# Add Feature Flags Workflow

Add `useAnimation` and `useSFX` props to interactive components.

## Steps

1. **Identify interactive components**
   - Buttons, cards, list items
   - Components with onClick, onHover, onChange handlers

2. **Add props to interface**
   ```typescript
   interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement> {
     useAnimation?: boolean;
     useSFX?: boolean;
     // existing props...
   }
   ```

3. **Destructure with defaults**
   ```typescript
   export function Button({
     useAnimation: enableAnimation = false,
     useSFX: enableSFX = false,
     onClick,
     children,
     ...props
   }: ButtonProps) {
   ```

4. **Import hooks**
   ```typescript
   import { useAnimation, useSFX } from "@/hooks";
   ```

5. **Initialize hooks**
   ```typescript
   const { trigger, animationClass } = useAnimation("bounce", {
     enabled: enableAnimation,
   });

   const { play } = useSFX({ enabled: enableSFX });
   ```

6. **Wire up event handlers**
   ```typescript
   const handleClick = (e: React.MouseEvent<HTMLButtonElement>) => {
     if (enableSFX) play("click");
     if (enableAnimation) trigger();
     onClick?.(e);
   };
   ```

7. **Apply animation class**
   ```typescript
   return (
     <button
       className={cn(className, animationClass)}
       onClick={handleClick}
       {...props}
     >
       {children}
     </button>
   );
   ```

## Component-Specific Defaults

| Component | Animation | SFX |
|-----------|-----------|-----|
| Button | bounce | click |
| Card | fadeIn | - |
| ListItem | pop | select |
| Checkbox | pop | select |
| Alert | shake | error |
| Modal | scaleIn | - |

## Full Example

```tsx
"use client";

import { cn } from "@/lib/utils";
import { useAnimation, useSFX } from "@/hooks";

interface CardProps {
  useAnimation?: boolean;
  useSFX?: boolean;
  onClick?: () => void;
  className?: string;
  children: React.ReactNode;
}

export function Card({
  useAnimation: enableAnimation = false,
  useSFX: enableSFX = false,
  onClick,
  className,
  children,
}: CardProps) {
  const { trigger, animationClass } = useAnimation("fadeIn", {
    enabled: enableAnimation,
  });

  const { play } = useSFX({ enabled: enableSFX });

  const handleClick = () => {
    if (enableSFX) play("select");
    if (enableAnimation) trigger();
    onClick?.();
  };

  return (
    <div
      className={cn("rounded-lg border p-4", className, animationClass)}
      onClick={onClick ? handleClick : undefined}
    >
      {children}
    </div>
  );
}
```

## Testing

```tsx
// Test without flags (should work normally)
<Button>No effects</Button>

// Test with animation only
<Button useAnimation>Animated</Button>

// Test with SFX only
<Button useSFX>With sound</Button>

// Test with both
<Button useAnimation useSFX>Full effects</Button>
```
