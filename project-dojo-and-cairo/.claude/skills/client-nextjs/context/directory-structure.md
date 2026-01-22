# Client Directory Structure

```
client/
├── src/
│   ├── app/                    # Next.js app router
│   │   ├── screens/            # Screen components (kebab-case)
│   │   ├── game/[id]/          # Dynamic game routes with parallel routes
│   │   ├── globals.css
│   │   ├── layout.tsx
│   │   └── page.tsx
│   ├── components/             # Reusable components
│   │   ├── core/               # Design system (core-*.tsx)
│   │   ├── game/               # Game-specific components
│   │   ├── ui/                 # General UI components
│   │   ├── layout/             # Layout components
│   │   └── icons/              # Icon components
│   ├── hooks/                  # Custom hooks (camelCase with use prefix)
│   │   └── index.ts            # Barrel exports
│   ├── lib/                    # Utilities and constants
│   │   ├── config/             # Configuration
│   │   ├── constants/          # Static data
│   │   └── utils/              # Utility functions
│   ├── dojo/                   # Dojo SDK integration
│   │   ├── hooks/              # Dojo-specific hooks
│   │   └── index.ts            # Barrel exports
│   ├── generated/              # Auto-generated types from Dojo
│   │   └── typescript/         # TypeScript bindings
│   └── animations/             # Animation system
│       └── index.ts            # Barrel exports
├── public/
│   ├── audio/                  # Sound files
│   │   ├── sfx/               # Sound effects
│   │   └── music/             # Background music
│   └── images/                # Image assets
└── .claude/
    └── skills/                # Claude skills
```

## Directory Purposes

| Directory | Purpose | Naming |
|-----------|---------|--------|
| `app/screens/` | Full-page screen components | kebab-case |
| `components/` | Reusable UI components | kebab-case |
| `components/core/` | Design system primitives | `core-` prefix |
| `components/game/` | Game-specific components | kebab-case |
| `components/ui/` | General UI components | kebab-case |
| `hooks/` | React custom hooks | camelCase |
| `lib/` | Utility functions and constants | kebab-case |
| `lib/constants/` | Static data | kebab-case |
| `dojo/` | Blockchain integration | kebab-case |
| `generated/` | Auto-generated Dojo types | - |
| `animations/` | Animation utilities | kebab-case |

## Audio File Organization

```
public/audio/
├── sfx/
│   ├── ui/
│   │   ├── click.mp3
│   │   ├── hover.mp3
│   │   ├── select.mp3
│   │   └── confirm.mp3
│   └── notification/
│       ├── error.mp3
│       └── success.mp3
└── music/
    ├── menu-theme.mp3
    └── ambient.mp3
```
