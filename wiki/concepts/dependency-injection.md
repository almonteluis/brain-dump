---
description: Passing dependencies into functions/classes from the outside rather than having them create or import their own
tags: [typescript, nodejs, architecture, testing, solid]
sources: ["dependency-injection-nodejs-typescript"]
created: 2026-04-29
updated: 2026-04-29
---

# Dependency Injection

Passing dependencies into functions/classes from the outside rather than having them create or import their own. Not a framework feature — just passing arguments.

## DI vs Dependency Inversion

- **DI** = technique: pass dependencies as parameters
- **Dependency Inversion** = SOLID principle: high/low-level modules depend on abstractions

DI implements Dependency Inversion, but you can do DI without inverting anything.

## The Anti-Pattern

```typescript
// Direct import — hidden dependency
import { db } from './database';
export async function getUser(id: string) {
  return db.query('SELECT * FROM users WHERE id = $1', [id]);
}
```

Problems:
- Can't test without real database
- Can't swap PostgreSQL for SQLite
- Side effects on import
- Module mocking required (`jest.mock` — brittle, path-coupled, type-unsafe)

## Manual DI Pattern

```typescript
// Factory function with explicit dependencies
export function createUserService(repo: UserRepository, email: EmailService, logger: Logger) {
  return {
    async createUser(data: CreateUserInput) {
      const user = await repo.create(data);
      await email.send(user.email, 'Welcome!');
      logger.info(`User created: ${user.id}`);
      return user;
    }
  };
}
```

## Composition Root

One entry point that wires all concrete implementations:

```typescript
// composition-root.ts
export function createApp() {
  const db = createKnexDatabase(knex);
  const email = createEmailService({ apiKey: process.env.SENDGRID_KEY! });
  const logger = createLogger({ level: 'info' });
  
  const userRepo = createUserRepo(db);
  const userService = createUserService(userRepo, email, logger);
  
  return { userService };
}
```

## Testing Payoff

No mocking framework needed. Plain objects satisfying interfaces:

```typescript
const fakeRepo = { create: async (data) => ({ id: '1', email: data.email }) };
const fakeEmail = { send: async () => {} };
const service = createUserService(fakeRepo, fakeEmail, fakeLogger);
```

## When to Use a Container

Start manual. Graduate to [[tsyringe]] or [[InversifyJS]] at 20-30+ services with complex graphs.

## Related

- [[dependency-injection-nodejs-typescript]] — Source tutorial
- [[composition-root]] — Single entry point for wiring
- [[testability]] — Making code testable
- [[solid-principles]] — Dependency Inversion principle