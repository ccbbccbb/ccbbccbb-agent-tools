# File & Folder Naming Conventions

## 1. Default: kebab-case

All files and folders use **kebab-case** by default:

```
src/app/screens/dashboard-screen.tsx
src/components/user-card.tsx
src/lib/utils.ts
src/constants/api-config.ts
```

## 2. Exception: Hooks & Stores (camelCase with `use` prefix)

Hooks and store files use **camelCase** with `use` as a prefix:

```
src/hooks/useAuth.ts
src/hooks/useTheme.ts
src/hooks/useLocalStorage.ts
src/store/useAppStore.ts
```

## 3. Exception: Providers (PascalCase with `Provider` suffix)

Provider files use **PascalCase** with `Provider` as the suffix:

```
src/providers/ThemeProvider.tsx
src/providers/AuthProvider.tsx
src/providers/QueryProvider.tsx
```

## 4. Exception: Markdown Files (COBOL-CASE)

All `.md` files use **COBOL-CASE** (uppercase with hyphens):

```
README.md
CHANGELOG.md
CONTRIBUTING.md
```

## Summary Table

| Category | Convention | Example |
|----------|------------|---------|
| Components | kebab-case | `user-card.tsx` |
| Screens | kebab-case | `dashboard-screen.tsx` |
| Utilities | kebab-case | `data-utils.ts` |
| Constants | kebab-case | `api-config.ts` |
| Hooks | camelCase + `use` | `useAuth.ts` |
| Providers | PascalCase + `Provider` | `ThemeProvider.tsx` |
| Markdown | COBOL-CASE | `README.md` |
