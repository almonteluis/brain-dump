---
description: Complete guide to Relay Compiler configuration — code generation workflow, GraphQL schema integration, TypeScript types generation, fragment colocation rules, and build pipeline setup.
tags: ["relay", "relay-compiler", "build-setup", "typescript", "code-generation", "graphql"]
created: 2026-02-02
---

# Relay Compiler & Build Setup

## What is Relay Compiler?

**Relay Compiler** is a build tool that:
- Parses GraphQL queries and fragments in your code
- Generates strongly-typed Flow/TypeScript definitions
- Optimizes queries (deduplication, constant folding)
- Validates fragments against GraphQL schema
- Generates persisted queries for production

## Basic Setup

### Installation

```bash
# Core Relay runtime
npm install relay-runtime

# React integration
npm install react-relay

# Relay compiler
npm install --save-dev relay-compiler relay-compiler-language-typescript relay-compiler-language-javascript
```

### Project Structure

```
src/
  ├── __generated__/           # Generated types (auto-created)
  ├── components/
  │   ├── User.tsx
  │   ├── Post.tsx
  │   └── queries/
  │       └── UserProfileQuery.graphql
  └── App.tsx

graphql/
  └── schema.graphql           # GraphQL schema

relay.config.js               # Compiler configuration
package.json
tsconfig.json
```

## relay-compiler Configuration

### relay.config.js

```javascript
module.exports = {
  src: './src',
  schema: './graphql/schema.graphql',
  language: 'typescript',
  artifactDirectory: './src/__generated__',
  exclude: ['**/node_modules/**', '**/__tests__/**'],

  // Optional: Generate persisted queries
  customScalars: {
    DateTime: 'string',
    Date: 'string',
    JSON: 'unknown',
  },

  // Optional: Parser options
  parserConfig: {
    // Enable experimental features
    enableExperimentalFragmentVariables: false,
    enableInputObjectDefaults: true,
  },

  // Optional: Format generated code
  formatModule: 'prettier',
  formatModuleOptions: {
    printWidth: 100,
    singleQuote: true,
  },
};
```

### Environment-Specific Configuration

```javascript
// relay.config.js
const isDevelopment = process.env.NODE_ENV === 'development';

module.exports = {
  src: './src',
  schema: isDevelopment
    ? 'http://localhost:4000/graphql' // Introspection
    : './graphql/schema.graphql',     // Local file

  language: 'typescript',
  artifactDirectory: './src/__generated__',

  // Development-only features
  ...(isDevelopment && {
    // Enable watch mode for development
    watch: true,
    // Validate queries against schema
    validate: true,
  }),

  // Production optimizations
  ...(!isDevelopment && {
    // Generate persisted queries
    persistOutput: './relay-persisted-queries.json',
  }),
};
```

## Code Generation Workflow

### Manual Compilation

```bash
# Run compiler once
npx relay-compiler

# With verbose output
npx relay-compiler --verbose

# Watch mode (recompile on changes)
npx relay-compiler --watch

# Validate without generating (CI/CD)
npx relay-compiler --validate
```

### npm Scripts

```json
{
  "scripts": {
    "relay": "relay-compiler",
    "relay:watch": "relay-compiler --watch",
    "relay:validate": "relay-compiler --validate",
    "build": "npm run relay && tsc",
    "dev": "npm run relay:watch & vite"
  }
}
```

### Pre-commit Hook (Husky)

```bash
# .husky/pre-commit
#!/bin/sh
. "$(dirname "$0")/_/husky.sh"

# Validate Relay queries before commit
npm run relay:validate
```

### CI/CD Pipeline

```yaml
# .github/workflows/ci.yml
name: CI

on: [push, pull_request]

jobs:
  test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - uses: actions/setup-node@v3
        with:
          node-version: '18'
      - run: npm ci
      - run: npm run relay:validate  # Validate queries
      - run: npm run relay             # Generate types
      - run: npm test
```

## GraphQL Schema Integration

### Introspection from Live Server

```javascript
// relay.config.js
module.exports = {
  src: './src',
  schema: {
    url: 'http://localhost:4000/graphql',
    method: 'POST',
    headers: {
      'Authorization': 'Bearer YOUR_TOKEN',
    },
    // Retry configuration
    retry: {
      maxRetries: 3,
      backoffBase: 300, // ms
    },
  },
};
```

### Local Schema File

```bash
# Download schema from server
npx get-graphql-schema http://localhost:4000/graphql > graphql/schema.graphql

# Or with Apollo CLI
npx apollo client:download-schema --endpoint=http://localhost:4000/graphql
```

```javascript
// relay.config.js
module.exports = {
  src: './src',
  schema: './graphql/schema.graphql',
};
```

### Schema with Custom Scalars

```graphql
# graphql/schema.graphql
scalar DateTime
scalar Date
scalar JSON

type User {
  id: ID!
  name: String!
  createdAt: DateTime!
  metadata: JSON
}
```

```javascript
// relay.config.js
module.exports = {
  src: './src',
  schema: './graphql/schema.graphql',
  customScalars: {
    DateTime: 'string',
    Date: 'string',
    JSON: 'unknown',
  },
};
```

### Multiple Schemas

```javascript
// relay.config.js
module.exports = {
  src: './src',

  // Define multiple schemas with namespaces
  schema: [
    {
      name: 'primary',
      schema: './graphql/schema.graphql',
    },
    {
      name: 'analytics',
      schema: './graphql/analytics-schema.graphql',
    },
  ],

  // Use @relay(operationType: ANALYTICS) directive
};
```

## TypeScript Types Generation

### Automatic Type Generation

Relay Compiler automatically generates types for:

1. **Query variables** — Input types for `useLazyLoadQuery`
2. **Fragment refs** — Opaque fragment reference types
3. **Mutation inputs** — Input types for `useMutation`
4. **Subscription types** — Input and response types

### Using Generated Types

```typescript
// src/components/User.tsx
import {graphql, useLazyLoadQuery} from 'react-relay';
import type {UserQuery} from './__generated__/UserQuery.graphql';
import type {User_user$key} from './__generated__/User_user.graphql';

// Query type
const query = graphql`
  query UserQuery($userId: ID!) {
    user(id: $userId) {
      id
      name
      ...User_user
    }
  }
`;

function UserComponent({userId}: {userId: string}) {
  // Variables are type-checked
  const data = useLazyLoadQuery<UserQuery>(
    query,
    {userId} // ✅ Correct type
    // {userId: 123} // ❌ Type error: number != string
  );

  return <UserProfile user={data.user} />;
}

// Fragment type
const fragment = graphql`
  fragment User_user on User {
    id
    name
    email
  }
`;

function UserProfile({user}: {user: User_user$key}) {
  const data = useFragment(fragment, user);

  // Type-safe access
  return (
    <div>
      <h1>{data.name}</h1>
      <p>{data.email}</p> {/* ✅ Email exists on type */}
      {/* <p>{data.invalidField}</p>  ❌ Type error: property doesn't exist */}
    </div>
  );
}
```

### Generic Fragment Props

```typescript
import type {RelayProp, RelayPaginationProp} from 'react-relay';

interface UserContainerProps {
  user: User_user$key;  // Fragment reference type
}

// Generic component
function UserContainer({user}: UserContainerProps) {
  const data = useFragment(userFragment, user);
  return <UserDisplay user={data} />;
}
```

### Mutation Types

```typescript
import {graphql, useMutation} from 'react-relay';
import type {LikeButtonMutation} from './__generated__/LikeButtonMutation.graphql';

const mutation = graphql`
  mutation LikeButtonMutation($input: FeedbackLikeData!) {
    feedback_like(data: $input) {
      feedback {
        viewer_does_like
        like_count
      }
    }
  }
`;

function LikeButton({feedbackId}: {feedbackId: string}) {
  const [commitMutation] = useMutation<LikeButtonMutation>(mutation);

  return (
    <button
      onClick={() => {
        commitMutation({
          variables: {
            input: {
              id: feedbackId,
              // ✅ Type-checked against FeedbackLikeData
            },
          },
        });
      }}
    >
      Like
    </button>
  );
}
```

## Fragment Colocation Rules

### What is Fragment Colocation?

Fragment colocation means: **Place fragments next to the components that use them.**

### Rule 1: Colocate Fragments with Components

```
src/
  └── components/
      ├── UserProfile/
      │   ├── UserProfile.tsx       # Component
      │   ├── UserProfile.graphql   # Fragment ✅
      │   └── index.ts
      ├── PostCard/
      │   ├── PostCard.tsx          # Component
      │   └── PostCard.graphql      # Fragment ✅
      └── queries/
          └── UserPageQuery.graphql # Query (spread fragments) ✅
```

### Rule 2: Use Consistent Naming

```
ComponentName.tsx → ComponentName.graphql

UserProfile.tsx   → UserProfile.graphql
PostCard.tsx      → PostCard.graphql
```

### Rule 3: Fragment Spreads, Not Fields

```graphql
# ❌ BAD: Querying fields directly
query UserPageQuery {
  user(id: "123") {
    id
    name
    email      # Duplicated in multiple queries
    posts {
      edges {
        node {
          id
          title  # Duplicated
        }
      }
    }
  }
}

# ✅ GOOD: Spreading fragments
query UserPageQuery {
  user(id: "123") {
    id
    ...UserProfile_user      # Reusable fragment
    ...UserPosts_user        # Reusable fragment
  }
}
```

### Rule 4: Declare Dependencies in Fragments

```typescript
// UserProfile.tsx
import {graphql} from 'react-relay';

// Define fragment in same file as component
export const fragment = graphql`
  fragment UserProfile_user on User {
    id
    name
    email
    avatar
    # Dependencies nested here
    posts(first: 10) {
      edges {
        node {
          id
          title
        }
      }
    }
  }
`;

function UserProfile({user}: {user: UserProfile_user$key}) {
  const data = useFragment(fragment, user);
  return <div>{/* ... */}</div>;
}
```

### ESLint Rule Enforcement

```javascript
// .eslintrc.js
module.exports = {
  extends: ['plugin:relay/recommended'],
  rules: {
    // Require fragments to be colocated
    'relay/must-colocate-fragment-spreads': 'error',

    // Error when queried fields aren't used
    'relay/unused-fields': 'error',

    // Require fragment variables to be defined
    'relay/graphql-syntax': 'error',
  },
};
```

## Build Pipeline Integration

### Vite Integration

```javascript
// vite.config.ts
import {defineConfig} from 'vite';
import relay from 'vite-plugin-relay';

export default defineConfig({
  plugins: [
    relay({
      src: './src',
      schema: './graphql/schema.graphql',
      language: 'typescript',
      artifactDirectory: './src/__generated__',
    }),
  ],
});
```

### Webpack Integration

```javascript
// webpack.config.js
const RelayCompilerWebpackPlugin = require('relay-compiler/lib/RelayCompilerWebpackPlugin');

module.exports = {
  plugins: [
    new RelayCompilerWebpackPlugin({
      schema: './graphql/schema.graphql',
      src: './src',
      artifactDirectory: './src/__generated__',
      language: 'typescript',
    }),
  ],
};
```

### Next.js Integration

```javascript
// next.config.js
const {RelayPlugin} = require('vite-plugin-relay');

module.exports = {
  webpack(config) {
    config.plugins.push(
      new RelayPlugin({
        schema: './graphql/schema.graphql',
        src: './src',
        artifactDirectory: './src/__generated__',
        language: 'typescript',
      })
    );
    return config;
  },
};
```

### Turbopack Integration

```javascript
// turbo.json
{
  "pipeline": {
    "build": {
      "outputs": [".next/**", "!.next/cache/**"],
      "dependsOn": ["relay"]
    },
    "relay": {
      "outputs": ["src/__generated__/**"],
      "cache": true
    }
  }
}
```

## Persisted Queries

### Configuration

```javascript
// relay.config.js
module.exports = {
  src: './src',
  schema: './graphql/schema.graphql',
  language: 'typescript',

  // Generate persisted queries
  persistOutput: './src/__generated__/persisted-queries.json',

  // Use SHA-256 hash (recommended)
  persistQuery: true,
};
```

### Using Persisted Queries

```typescript
import {Environment, Network, RecordSource, Store} from 'relay-runtime';
import persistedQueries from './__generated__/persisted-queries.json';

// Custom network layer that sends query ID instead of full text
const network = Network.create(async (operation, variables) => {
  const queryText = operation.text;
  const queryId = operation.id; // Generated by compiler

  const body = {
    id: queryId,          // Send persisted query ID
    variables,
    operationName: operation.name,
  };

  const response = await fetch('/graphql', {
    method: 'POST',
    headers: {'Content-Type': 'application/json'},
    body: JSON.stringify(body),
  });

  return response.json();
});
```

### Server-Side Support (Node.js)

```javascript
const persistedQueries = require('./src/__generated__/persisted-queries.json');

// Express/GraphQL server setup
app.use('/graphql', graphqlHTTP({
  schema,
  context: {},
  // Look up query by ID
  rootValue: (source, body) => {
    if (body.id) {
      const queryText = persistedQueries[body.id];
      if (!queryText) {
        throw new Error('Unknown query ID');
      }
      return queryText;
    }
    return source;
  },
}));
```

## Compiler Options Reference

### Command Line Options

```bash
relay-compiler [options]

Options:
  --src <path>                  # Source directory
  --schema <path>               # Schema file or URL
  --language <name>             # Language: javascript, typescript, flow
  --artifactDirectory <path>    # Output directory for generated files
  --exclude <pattern>           # Glob pattern to exclude
  --watch                       # Watch mode
  --validate                    # Validate without generating
  --verbose                     # Verbose output
  --help                        # Show help
```

### Config File Options

```javascript
module.exports = {
  // Required
  src: './src',                          // Source directory
  schema: './graphql/schema.graphql',   // Schema location
  language: 'typescript',               // Output language

  // Optional
  artifactDirectory: './src/__generated__',
  exclude: ['**/node_modules/**', '**/__tests__/**'],

  // Custom scalars
  customScalars: {
    DateTime: 'string',
    Date: 'string',
  },

  // Parser options
  parserConfig: {
    enableExperimentalFragmentVariables: false,
    enableInputObjectDefaults: true,
    enableFragmentArguments: true,
  },

  // Code generation
  generateGeneratedTypes: false,  // Generate __generated types (legacy)
  useSingleArtifactDirectory: true, // All generated in one directory

  // Persisted queries
  persistOutput: './relay-persisted-queries.json',
  persistQuery: true,

  // Formatting
  formatModule: 'prettier',
  formatModuleOptions: {
    printWidth: 100,
    singleQuote: true,
    trailingComma: 'all',
  },

  // Build settings
  check: true,              // Check for undefined fragments
  noFutureProofEnums: false, // Don't add enum values for future-proofing
  jsModuleFormat: 'esmodule', // Module format: commonjs, esmodule

  // Experimental
  useLegacyArtifactDirectory: false,
  enableFragmentVariables: false,
};
```

## Common Issues & Solutions

### Issue: Generated Types Not Found

**Problem:** TypeScript can't find generated types.

**Solution:** Ensure `__generated__` is included in tsconfig:
```json
{
  "compilerOptions": {
    "baseUrl": ".",
    "paths": {
      "src/*": ["./src/*"]
    }
  },
  "include": ["src/**/*", "src/__generated__/**/*"]
}
```

### Issue: Compiler Doesn't Pick Up New Queries

**Problem:** New GraphQL queries not recognized.

**Solution:** Ensure `.graphql` extension:
```typescript
// ✅ Correct
import query from './MyComponent.graphql';

// ❌ Wrong - missing extension
import query from './MyComponent';
```

### Issue: Fragment Not Found Error

**Problem:** `Fragment ... was never used in query ...`

**Cause:** Fragment defined but never spread.

**Solution:** Always spread fragments in queries or parent fragments:
```graphql
query UserPageQuery {
  user(id: "123") {
    ...UserProfile_user  # Must be spread
  }
}
```

### Issue: Slow Compilation

**Problem:** Relay compiler takes too long.

**Solution:** Optimize configuration:
```javascript
module.exports = {
  // Exclude test files from compilation
  exclude: ['**/node_modules/**', '**/__tests__/**', '**/*.test.tsx'],

  // Use faster resolution
  useSingleArtifactDirectory: true,

  // Disable verbose output
  // (in production)
};
```

### Issue: Schema Introspection Fails

**Problem:** Can't connect to GraphQL server for schema.

**Solution:** Use local schema file or authentication:
```javascript
schema: {
  url: 'http://localhost:4000/graphql',
  headers: {
    'Authorization': `Bearer ${process.env.GRAPHQL_TOKEN}`,
  },
  retry: {
    maxRetries: 5,
    backoffBase: 1000,
  },
},
```

## Use Cases

### Monorepo Setup

```javascript
// relay.config.js
module.exports = {
  src: 'apps/*/src',  // All apps
  schema: 'packages/api/schema.graphql',  // Shared schema
  language: 'typescript',
  artifactDirectory: 'apps/*/src/__generated__',
};
```

### Multiple Environments

```bash
# Development: Use live introspection
relay-compiler --schema http://localhost:4000/graphql

# Production: Use local schema
relay-compiler --schema ./graphql/schema.graphql
```

### Incremental Compilation

```javascript
// relay.config.js
module.exports = {
  // Only compile changed files
  watch: true,
  // Faster for large codebases
  useSingleArtifactDirectory: true,
};
```

## Best Practices

### 1. Always Compile Before Type Checking

```json
{
  "scripts": {
    "build": "relay-compiler && tsc"
  }
}
```

### 2. Use Persisted Queries in Production

```javascript
const config = {
  ...productionConfig,
  persistOutput: './src/__generated__/persisted-queries.json',
  persistQuery: true,
};
```

### 3. Validate Queries in CI/CD

```yaml
- name: Validate Relay queries
  run: npm run relay:validate
```

### 4. Keep Schema in Version Control

```bash
# Commit schema.graphql
git add graphql/schema.graphql
git commit -m "Update GraphQL schema"
```

### 5. Use ESLint Rules

```json
{
  "extends": ["plugin:relay/recommended"],
  "rules": {
    "relay/must-colocate-fragment-spreads": "error",
    "relay/unused-fields": "error"
  }
}
```

## See Also

- [[Relay Environment Setup]] — Runtime configuration
- [[Connection Pattern & Pagination]] — Pagination query generation
- [[Data Masking in Relay]] — Fragment reference types
- [[Relay Mutations Guide]] — Mutation query generation
- [[Relay ESLint Rules Guide]] — Linting Relay queries

## External Resources

- [Relay Compiler Docs](https://relay.dev/docs/guides/compiler-setup/)
- [Relay TypeScript Guide](https://relay.dev/docs/guides/typescript/)
- [Relay Configuration Reference](https://relay.dev/docs/guides/relay-compiler-options/)
- [Persisted Queries Guide](https://relay.dev/docs/guides/persisted-queries/)
