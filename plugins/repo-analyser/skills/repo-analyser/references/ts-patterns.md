# TypeScript/JavaScript Architecture Patterns

## Project Structure Indicators

### Monorepo Patterns
- `packages/` or `apps/` directories with separate package.json files
- Workspace configuration in root package.json (npm/yarn/pnpm workspaces)
- Turborepo (`turbo.json`), Nx (`nx.json`), or Lerna (`lerna.json`) config

### Common Architectures

**Layered Architecture**
```
src/
├── controllers/    # HTTP handlers
├── services/       # Business logic
├── repositories/   # Data access
├── models/         # Domain entities
└── utils/          # Shared utilities
```

**Feature-based (Modular)**
```
src/
├── features/
│   ├── auth/
│   │   ├── auth.controller.ts
│   │   ├── auth.service.ts
│   │   └── auth.types.ts
│   └── users/
└── shared/
```

**Next.js App Router**
```
app/
├── (auth)/         # Route groups
├── api/            # API routes
├── [slug]/         # Dynamic routes
└── layout.tsx      # Root layout
```

## Key Files to Analyze

| File | Reveals |
|------|---------|
| `package.json` | Dependencies, scripts, project type |
| `tsconfig.json` | Module system, paths, strictness |
| `*.config.ts/js` | Build tools, frameworks used |
| `index.ts` (barrel) | Public API surface |
| `types.ts`, `*.d.ts` | Domain models, contracts |

## Patterns to Identify

### Dependency Injection
- Constructor injection in classes
- IoC containers (tsyringe, inversify, typedi)
- Factory functions

### State Management
- Redux/Zustand/Jotai stores
- React Context providers
- Server state (TanStack Query, SWR)

### API Patterns
- REST controllers with decorators (NestJS)
- tRPC routers and procedures
- GraphQL resolvers

### Module Boundaries
- Barrel exports (`index.ts`) define public API
- Internal modules prefixed with `_` or in `internal/`
- Circular dependency indicators
