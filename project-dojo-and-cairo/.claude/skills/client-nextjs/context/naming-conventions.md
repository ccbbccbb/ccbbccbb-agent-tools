# File & Folder Naming Conventions

## 1. Default: kebab-case

All files and folders use **kebab-case** by default:

```
client/src/app/screens/dashboard-screen.tsx
client/src/components/user-avatar.tsx
client/src/lib/utils.ts
client/src/constants/item-data.ts
```

## 2. Exception: Hooks & Stores (camelCase with `use` prefix)

Hooks and store files use **camelCase** with `use` as a prefix:

```
client/src/hooks/useAuth.ts
client/src/hooks/useGameState.ts
client/src/hooks/useSFX.ts
client/src/dojo/useDojoStore.ts
```

## 3. Exception: Providers (PascalCase with `Provider` suffix)

Provider files use **PascalCase** with `Provider` as the suffix:

```
client/src/providers/AudioProvider.tsx
client/src/providers/StarknetProvider.tsx
client/src/providers/AnimationProvider.tsx
```

## 4. Exception: Markdown Files (COBOL-CASE)

All `.md` files use **COBOL-CASE** (uppercase with hyphens):

```
client/README.md
client/ARCHITECTURE.md
client/GETTING-STARTED.md
```

## Summary Table

| Category | Convention | Example |
|----------|------------|---------|
| Components | kebab-case | `user-avatar.tsx` |
| Screens | kebab-case | `dashboard-screen.tsx` |
| Utilities | kebab-case | `data-utils.ts` |
| Constants | kebab-case | `item-data.ts` |
| Hooks | camelCase + `use` | `useGameState.ts` |
| Providers | PascalCase + `Provider` | `AudioProvider.tsx` |
| Markdown | COBOL-CASE | `README.md` |
