# Create Component Workflow

## Steps

1. **Determine component type**
   - Regular component → `src/components/` (kebab-case)
   - Screen component → `src/app/screens/` (kebab-case)
   - Hook → `src/hooks/` (camelCase with `use` prefix)
   - Provider → `src/providers/` (PascalCase with `Provider` suffix)

2. **Create the file with correct naming**
   ```bash
   # Component example
   touch client/src/components/creature-card.tsx

   # Hook example
   touch client/src/hooks/useCreatureData.ts

   # Provider example
   touch client/src/providers/ThemeProvider.tsx
   ```

3. **Add "use client" directive if needed**
   - Required for: hooks, providers, interactive components
   - Not needed for: server components, pure UI components

4. **Implement with feature flags (if interactive)**
   ```tsx
   "use client";

   interface MyComponentProps {
     useAnimation?: boolean;
     useSFX?: boolean;
     // other props
   }

   export function MyComponent({
     useAnimation: enableAnimation = false,
     useSFX: enableSFX = false,
     ...props
   }: MyComponentProps) {
     // implementation
   }
   ```

5. **Add to barrel export**
   ```typescript
   // src/components/index.ts
   export { MyComponent } from "./my-component";
   ```

6. **Verify imports**
   ```typescript
   // Should work:
   import { MyComponent } from "@/components";
   ```

## Checklist

- [ ] File uses correct naming convention
- [ ] Component uses named export (not default, unless screen)
- [ ] Added to barrel export (index.ts)
- [ ] "use client" added if interactive
- [ ] Feature flags added if interactive (useAnimation, useSFX)
