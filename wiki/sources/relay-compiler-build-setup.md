---
description: "Relay compiler configuration and build setup"
tags: ["source", "relay", "relay-compiler", "build-setup", "typescript", "graphql"]
sources: ["relay-compiler-build-setup.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Relay Compiler & Build Setup

**Source:** raw/02_reference/approaches/relay-compiler-build-setup.md
**Date ingested:** 2026-04-09
**Type:** Build configuration guide

## Summary

Complete guide to Relay Compiler configuration — code generation workflow, GraphQL schema integration, TypeScript types generation, fragment colocation rules, and build pipeline setup.

## Key Claims

- Relay Compiler parses GraphQL queries, generates TypeScript types, optimizes queries
- Fragment colocation: place fragments next to components that use them
- `relay.config.js` controls source directories, schema location, output settings
- Persisted queries reduce bundle size and improve security

## What Relay Compiler Does

- Parses GraphQL queries and fragments
- Generates strongly-typed TypeScript/Flow definitions
- Optimizes queries (deduplication, constant folding)
- Validates fragments against schema
- Generates persisted queries for production

## Basic Configuration

```javascript
// relay.config.js
module.exports = {
  src: './src',
  schema: './graphql/schema.graphql',
  language: 'typescript',
  artifactDirectory: './src/__generated__',
  exclude: ['**/node_modules/**', '**/__tests__/**'],
};
```

## npm Scripts

```json
{
  "scripts": {
    "relay": "relay-compiler",
    "relay:watch": "relay-compiler --watch",
    "relay:validate": "relay-compiler --validate",
    "build": "npm run relay && tsc"
  }
}
```

## Fragment Colocation Rules

1. **Colocate fragments with components** — Same directory
2. **Consistent naming** — `ComponentName.tsx` → `ComponentName.graphql`
3. **Use fragment spreads** — Not direct field selection
4. **Declare dependencies in fragments** — Self-contained

## TypeScript Integration

```typescript
import type {UserQuery} from './__generated__/UserQuery.graphql';
import type {User_user$key} from './__generated__/User_user.graphql';

// Query type
const data = useLazyLoadQuery<UserQuery>(query, {userId});

// Fragment type
function UserProfile({user}: {user: User_user$key}) {
  const data = useFragment(fragment, user);
}
```

## Build Pipeline Integration

- **Vite:** `vite-plugin-relay`
- **Webpack:** `RelayCompilerWebpackPlugin`
- **Next.js:** Webpack config with Relay plugin
- **Turborepo:** Add relay task to pipeline

## Persisted Queries

```javascript
// relay.config.js
module.exports = {
  persistOutput: './src/__generated__/persisted-queries.json',
  persistQuery: true,
};
```

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[TypeScript]] — Type system
- [[GraphQL]] — Query language

## Concepts Covered

- [[relay-compiler]] — Build-time code generation
- [[fragment-colocation]] — Co-locating fragments with components
- [[persisted-queries]] — Query ID instead of full text
- [[type-generation]] — Automatic TypeScript types
- [[build-pipeline]] — CI/CD integration
