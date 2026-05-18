---
description: "Learn the hidden costs about importing everything directly and the structural change you need to make. (8 min)"
tags: ['research']
source: "https://thetshaped.dev/p/dependency-injection-in-nodejs-and-typescript-dependency-inversion-part-no-body-teaches-you?utm_campaign=how-netflix-reaches-100m-devices-in-60-seconds-here-s-the-architecture&utm_medium=referral&utm_source=www.hungryminds.dev"
raw_file: "Dependency Injection in Node.js & TypeScript. The Part Nobody Teaches You.md"
created: 2026-05-17
---

### Learn the hidden costs about importing everything directly and the structural change you need to make. (8 min)

*This post outlines a common Node.js pattern and how to solve it.*

- *[Share this post](https://thetshaped.dev/p/dependency-injection-in-nodejs-and-typescript-dependency-inversion-part-no-body-teaches-you) & I’ll send you some rewards for the referrals.*

In the Java/C# world, DI containers are a religion.

In Node.js, most developers just `import` modules directly, until testing becomes a nightmare and swapping implementations means rewriting half the app.

You don’t need dependency injection containers like [InversifyJS](https://github.com/inversify/InversifyJS) or [tsyringe](https://github.com/microsoft/tsyringe).

Here’s how to do dependency injection with plain TypeScript, and why it’ll make your code instantly more testable.

---

## Dependency Injection vs. Dependency Inversion

These terms get used interchangeably. But they're not the same.

**Dependency Injection** (DI) is a technique: instead of a class/function creating its own dependencies, you pass them in from the outside.

**Dependency Inversion** is a principle (the “D” in SOLID): high-level modules shouldn’t depend on low-level modules. Both should depend on abstractions.

Dependency Injection is how you implement Dependency Inversion.

But you can do DI without inverting anything. This is the place where most Node.js developers stop.

```markup
// Direct dependency — no injection
import { db } from './database';

export async function getUser(id: string) {
  return db.query('SELECT * FROM users WHERE id = $1', [id]);
}
```

This works. But you can’t test `getUser` without a real database.

You can’t swap PostgreSQL for an in-memory store.

And if `database.ts` has side effects on import, every test file that touches `getUser` pays that cost.

---

## The Node.js Anti-Pattern: Import Everything Directly

Here’s what most Express apps look like:

```markup
// userService.ts
import { knex } from ‘../lib/database’;
import { sendEmail } from ‘../lib/email’;
import { logger } from ‘../lib/logger’;

export async function createUser(data: CreateUserInput) {
  const [user] = await knex(’users’).insert(data).returning(’*’);
  await sendEmail(user.email, ‘Welcome!’);
  logger.info(\`User created: ${user.id}\`);
  return user;
}
```

There are three hardcoded dependencies. And to test this function, you need:

- A running database (or mock Knex globally)
- An email service (or mock the module)
- A logger (or suppress output)

Module mocking (`jest.mock`, `vi.mock`) is the usual escape hatch, but it’s brittle because we’re mocking import paths, not the actual contracts.

For example, if you rename a file, your mocks break silently.

**Module mocking is a code smell.**

It tells you your code has hidden dependencies that should be explicit.

---

## What Dependency Injection Actually Solves

Before we continue further, let’s be clear about what we’re fixing:

- **Testability.** When a module imports its dependencies directly, you’re forced into module-level mocking (`jest.mock()`, `vi.mock()`) to test it. These mocks are fragile, magical, and break when you rename a file. With DI, you pass plain objects, and no mocking framework is needed.
- **Swappability.** Imagine you have to switch from Knex to Drizzle, or from SendGrid to AWS SES. When dependencies are injected, you swap the implementation in one place. When they’re imported, you touch every file.
- **Explicit dependencies.** A function’s signature should tell you what it needs. If `createUser` secretly depends on a database, an email client, and a logger, but its signature only shows `data: CreateUserDTO`, that’s a lie. DI makes dependencies visible.
- **Separation of concerns.** Your business logic shouldn’t know (or care) whether it’s talking to Postgres or SQLite, SendGrid or a local SMTP server. DI enforces that boundary naturally.

Now, let’s see how to do dependency injection in Node.js without any frameworks.

---

## Step 1: Constructor Injection (Manual DI)

The simplest fix: **accept dependencies as parameters**.

```markup
// userService.ts
interface UserRepository {
  create(data: CreateUserInput): Promise<User>;
}

interface EmailService {
  send(to: string, subject: string): Promise<void>;
}

interface Logger {
  info(message: string): void;
}

export function createUserService(
  repo: UserRepository,
  email: EmailService,
  logger: Logger
) {
  return {
    async createUser(data: CreateUserInput) {
      const user = await repo.create(data);
      await email.send(user.email, ‘Welcome!’);
      logger.info(\`User created: ${user.id}\`);
      return user;
    },
  };
}
```

![](https://substackcdn.com/image/fetch/$s_!H_M7!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Ff4664d57-86d7-484e-9f6d-cdb4dcdab229_1932x744.png)

### Before and After DI: How You Use the Code

The real difference isn’t just how the service is ***defined***, but how it’s ***consumed***.

**Before DI, we use direct imports (hidden dependencies):**

```markup
// Somewhere in your route handler or controller
import { createUser } from ‘./userService’;

// Just call it. What does it need? Who knows.
// Knex? Email service? Logger? You can’t tell from here.
const user = await createUser({ email: ‘alice@example.com’, name: ‘Alice’ });
```

Dependencies are invisible.

The function looks simple, but it’s secretly reaching into the module graph for a database client, an email service, and a logger.

You only discover this when something breaks or when you try to test it.

**After DI, we use Factory + DI (explicit dependencies):**

```markup
// In your composition root or setup code
import { createUserService } from ‘./userService’;
import { createUserRepo } from ‘./repos/userRepo’;
import { createEmailService } from ‘./infra/email’;
import { createLogger } from ‘./infra/logger’;

// Dependencies are explicit at creation time
const userService = createUserService(
  createUserRepo(knex),
  createEmailService({ apiKey: process.env.SENDGRID_KEY! }),
  createLogger({ level: ‘info’ })
);

// Now use it — the service is fully configured
const user = await userService.createUser({ email: ‘alice@example.com’, name: ‘Alice’ });
```

Yes, the setup is more verbose. But now you can see every dependency. The function signature tells the truth.

When you read the composition root, you know exactly what each service needs, no grepping through imports, no surprises.

---

## Step 2: The Composition Root

If every service takes its dependencies as arguments, where do you actually wire everything together?

At the **composition root**, the entry point of your application. This is the one place that knows about all the concrete implementations.

```markup
// composition-root.ts
import Knex from ‘knex’;
import { createKnexDatabase } from ‘./infra/knexDatabase’;
import { createUserService } from ‘./services/userService’;
import { createOrderService } from ‘./services/orderService’;
import { createEmailService } from ‘./infra/email’;
import { createLogger } from ‘./infra/logger’;

export function createApp() {
  // Infrastructure
  const knex = Knex({
    client: ‘pg’,
    connection: process.env.DATABASE_URL,
  });
  const db = createKnexDatabase(knex);
  const email = createEmailService({ apiKey: process.env.SENDGRID_KEY! });
  const logger = createLogger({ level: ‘info’ });

  // Repositories
  const userRepo = createUserRepo(db);
  const orderRepo = createOrderRepo(db);

  // Services
  const userService = createUserService(userRepo, email, logger);
  const orderService = createOrderService(orderRepo, userService, logger);

  return { userService, orderService, knex };
}
```
```markup
// server.ts
import express from ‘express’;
import { createApp } from ‘./composition-root’;

const app = express();
const { userService, orderService } = createApp();

app.post(’/users’, async (req, res) => {
  const user = await userService.createUser(req.body);
  res.status(201).json(user);
});
```

Everything flows downward from one place. No global singletons. No magical auto-wiring. Just functions calling functions.

---

## When to Reach for a Container?

Manual DI works beautifully for small-to-medium apps.

But when you have 20-30+ services with complex dependency graphs, the composition root becomes hard to read and follow.

I’ve personally used [tsyringe](https://github.com/microsoft/tsyringe). It’s a lightweight container, easy to use and configure.

[tsyringe](https://github.com/microsoft/tsyringe) uses decorators and `reflect-metadata` to inspect constructor parameters and auto-wire dependencies.

It supports singleton, transient, and scoped lifecycles, with strong TypeScript support.

To be honest, I didn’t have any trouble with it.

Here is a simple example:

```markup
import ‘reflect-metadata’;
import { container, injectable, inject, singleton } from ‘tsyringe’;
import Knex from ‘knex’;

@singleton()
class KnexDatabase implements Database {
  private knex = Knex({ client: ‘pg’, connection: process.env.DATABASE_URL });

  users = {
    create: async (data: CreateUserInput) => {
      const [user] = await this.knex(’users’).insert(data).returning(’*’);
      return user;
    },
    findById: async (id: string) => {
      return this.knex(’users’).where({ id }).first() ?? null;
    },
  };
}

container.register(’Database’, { useClass: KnexDatabase });

@injectable()
class UserService {
  constructor(@inject(’Database’) private db: Database) {}

  async createUser(data: CreateUserInput) {
    return this.db.users.create(data);
  }
}

// Resolve with all dependencies auto-wired
const userService = container.resolve(UserService);
```

If you’re not sure whether you need a container, start simple without an additional framework.

You can easily add it later if needed.

---

## The Testing Payoff

Here’s why all this matters. Let’s compare full test files side by side.

### Before: Testing with Module Mocking

```markup
import { describe, it, expect, vi, beforeEach } from ‘vitest’;

// Mock every dependency by file path — get any path wrong and it silently breaks
vi.mock(’../lib/database’, () => ({
  knex: vi.fn().mockReturnValue({
    insert: vi.fn().mockReturnValue({
      returning: vi.fn().mockResolvedValue([{ id: ‘1’, email: ‘test@example.com’ }]),
    }),
  }),
}));

vi.mock(’../lib/email’, () => ({
  sendEmail: vi.fn(),
}));

vi.mock(’../lib/logger’, () => ({
  logger: {
    info: vi.fn(),
  },
}));

// Now import the function AFTER the mocks (order matters!)
import { createUser } from ‘./userService’;
import { knex } from ‘../lib/database’;
import { sendEmail } from ‘../lib/email’;

describe(’createUser’, () => {
  beforeEach(() => {
    vi.clearAllMocks();
  });

  it(’creates a user and sends a welcome email’, async () => {
    const user = await createUser({ email: ‘test@example.com’, name: ‘Test’ });

    expect(user.id).toBe(’1’);
    expect(sendEmail).toHaveBeenCalledWith(’test@example.com’, ‘Welcome!’);
  });
});
```

Problems everywhere:

- **Path-coupled**: rename `../lib/database` to `../db/database` and the mock breaks silently — the test passes but uses the real module
- **Import order matters**: `vi.mock` calls are hoisted, but if you get it wrong, debugging is miserable
- **Type-unsafe**: you’re casting to `any` because the mock system doesn’t know your interfaces
- **Framework-locked**: switch from Vitest to Node’s built-in test runner? Rewrite every mock

### After: Testing with DI

```markup
import { describe, it, expect } from ‘vitest’;
import { createUserService } from ‘./userService’;

describe(’createUser’, () => {
  it(’creates a user and sends a welcome email’, async () => {
    // Plain objects that satisfy the interface — no mock framework needed
    const fakeRepo = {
      create: async (data: any) => ({ id: ‘1’, email: data.email }),
    };
    const fakeEmail = {
      send: async () => {},
    };
    const fakeLogger = {
      info: () => {},
    };

    // Track calls manually if needed (or use vi.fn() — your choice, not a requirement)
    const emailCalls: any[] = [];
    fakeEmail.send = async (to: string, subject: string) => {
      emailCalls.push({ to, subject });
    };

    const service = createUserService(fakeRepo, fakeEmail, fakeLogger);
    const user = await service.createUser({ email: ‘test@example.com’, name: ‘Test’ });

    expect(user.id).toBe(’1’);
    expect(emailCalls).toEqual([{ to: ‘test@example.com’, subject: ‘Welcome!’ }]);
  });

  it(’logs user creation’, async () => {
    const logs: string[] = [];
    const service = createUserService(
      { create: async (data: any) => ({ id: ‘42’, email: data.email }) },
      { send: async () => {} },
      { info: (msg: string) => logs.push(msg) }
    );

    await service.createUser({ email: ‘test@example.com’, name: ‘Test’ });

    expect(logs).toEqual([’User created: 42’]);
  });
});
```

The difference:

- **No mocking framework required**: plain objects that match the interface
- **Type-safe**: TypeScript checks your fakes against the real interfaces
- **No import order tricks**: just functions and objects
- **Portable**: works with Vitest, Jest, Node’s test runner, or even a plain script
- **Each test is self-contained**: no shared mutable mock state leaks between tests

![](https://substackcdn.com/image/fetch/$s_!vQvD!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F75616c64-f8fd-43a4-b22f-6e5bb4e4c8e3_1658x978.png)

---

## 📌 Key Takeaways

1. **Dependency Injection isn’t a framework feature** — it’s passing arguments to functions. You already know how to do it.
2. **Module mocking is a smell.** If you need `vi.mock()` to test something, remember that something has hidden dependencies.
3. **Start with manual DI.** Factory functions + a composition root covers 90% of Node.js apps.
4. **Graduate to a container (tsyringe) when your dependency graph gets complex.** Not because it’s “proper”, but because it saves maintenance.
5. **The real value is testability.** DI makes unit testing trivial, integration testing focused, and your architecture honest about its dependencies.

---

![](https://substackcdn.com/image/fetch/$s_!cmMn!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F9aea932b-6248-4324-9ec7-68d0bfed782e_800x670.png)

**Follow me on [LinkedIn](https://www.linkedin.com/in/petarivanovv9/)** | **[Twitter(X)](https://x.com/intent/follow?screen_name=petarivanovv9)** | **[Threads](https://www.threads.net/@petarivanovv9)**

Thank you for supporting this newsletter.

Consider sharing this post with your friends and get rewards.

You are the best! 🙏

![](https://substackcdn.com/image/fetch/$s_!EvJY!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2Fa356e02d-1b11-4eca-81ea-3db29a595cb9_800x500.jpeg)

![](https://substackcdn.com/image/fetch/$s_!UzWz!,w_1456,c_limit,f_webp,q_auto:good,fl_progressive:steep/https%3A%2F%2Fsubstack-post-media.s3.amazonaws.com%2Fpublic%2Fimages%2F39609b45-f68c-4557-8772-8e2a45182842_500x600.gif)

***Press the Like button if you found this post helpful***
