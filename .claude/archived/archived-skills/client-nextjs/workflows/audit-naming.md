# Audit Naming Conventions Workflow

## Quick Audit Commands

### Find PascalCase files that should be kebab-case

```bash
# Components
ls client/src/components/*.tsx | grep -E '[A-Z]' | grep -v Provider

# Screens
ls client/src/app/screens/*.tsx | grep -E '[A-Z]'

# RetroUI
ls client/src/components/retroui/*.tsx | grep -E '[A-Z]'
```

### Find hooks without `use` prefix

```bash
ls client/src/hooks/*.ts | grep -v '^use' | grep -v index
```

### Find providers without `Provider` suffix

```bash
ls client/src/providers/*.tsx | grep -v 'Provider.tsx' | grep -v index
```

## Renaming Files

Use `git mv` to preserve history:

```bash
cd client/src/components

# Rename component
git mv CreatureSprite.tsx creature-sprite.tsx

# Update imports in the file (change the export name remains same)
# Export name stays PascalCase: export function CreatureSprite
```

## Common Renames

### Components (PascalCase → kebab-case)

```bash
git mv Box.tsx box.tsx
git mv Button.tsx button.tsx
git mv CreatureSprite.tsx creature-sprite.tsx
git mv DraftGrid.tsx draft-grid.tsx
git mv HpBar.tsx hp-bar.tsx
git mv TypeBadge.tsx type-badge.tsx
```

### Screens (PascalCase → kebab-case)

```bash
cd client/src/app/screens
git mv DraftScreen.tsx draft-screen.tsx
git mv BattleScreen.tsx battle-screen.tsx
git mv PartyScreen.tsx party-screen.tsx
```

## Post-Rename Checklist

After renaming files:

1. [ ] Update barrel exports in `index.ts`
2. [ ] Update imports in files that use the renamed component
3. [ ] Run `bun run types` to verify no broken imports
4. [ ] Run `bun run build` to verify build works

## Expected File Naming

| Type | Convention | Example |
|------|------------|---------|
| Component | kebab-case | `creature-sprite.tsx` |
| Hook | camelCase + use | `useGameState.ts` |
| Provider | PascalCase + Provider | `AudioProvider.tsx` |
| Screen | kebab-case | `draft-screen.tsx` |
| Constant | kebab-case | `species-data.ts` |
| Model | kebab-case | `hybrid-instance.ts` |
