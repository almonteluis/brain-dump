---
description: Lambda Service Pattern — three-tier AWS Lambda architecture (Function → Engine → DataService) with DI, GraphQL, and clear separation of concerns.
tags:
  - aws/lambda
  - csharp
  - architecture
  - serverless
sources:
  - assessmentauditor-assignmentchecker-pattern-analysis
created: 2026-04-28
updated: 2026-05-17
---

# Lambda Service Pattern

A three-tier architecture for AWS Lambda functions using C# and dependency injection. The pattern keeps each Lambda's code structured the same way — Function (entry point) → Engine (business logic) → DataService (data access) — so any developer can drop into any Lambda and know where they are.

## Structure

```
Function.cs      → Entry point: [LambdaFunction], DI injection, try/catch wrapper
    ↓
Startup.cs       → DI configuration: [LambdaStartup], env validation, service registration
    ↓
Engine.cs        → Business orchestration: domain logic, external service calls
    ↓
DataService.cs   → GraphQL wrapper: typed client, null-guard, logging
```

## What Each Layer Does

### Function.cs
- `[LambdaFunction]` attribute marks the handler
- Constructor injects `ILogger` and `Engine`
- Minimal wrapper: logs request ID, delegates to `Engine.RunAsync()`, catches exceptions. Nothing sexy. Just the door.

### Startup.cs
- `[LambdaStartup]` on class inheriting `Shared.Environment.Startup`
- Constructor validates required env vars via `HashSet<string>`
- Fluent `IServiceCollection` chain — singletons for config, scoped for GraphQL and AWS SDK clients, `AddGraphQLClientWithAuth` for the GraphQL client

### Engine.cs
- Constructor receives `ILoggerFactory` + domain dependencies
- `RunAsync()` orchestrates calls to external services, data layer, event publishers
- Business constants and env-driven configuration as fields
- This is where the actual work happens

### DataService.cs
- Implements `IDataService` interface
- Injects `IGraphQLResponseUnwrapper` + domain-specific GraphQL service interfaces
- Pattern per method: build filter → call via unwrapper → null/empty check → log → return

## When to Extract a Generic Framework

**Extract when:**
- Two or more Lambdas share 100% of structural scaffolding
- Only business logic (payload types, service interfaces, operation sequences) differs
- A base `Startup` class already exists, recognizing the commonality

**Proposed abstraction:**
```csharp
public abstract class LambdaFunction<TPayload> { ... }
public interface ILambdaEngine<TPayload> { Task RunAsync(TPayload input); }
public abstract class LambdaDataService { ... }
```

**Keep per-service:** concrete Engine, concrete DataService, domain-specific DI registrations.

The pattern is [[backend-for-frontend|BFF]] thinking applied to serverless — each function is a small, purpose-built service with clear boundaries. The same way BFFs prevent frontend-backend coupling, this pattern prevents Lambda-to-Lambda coupling.

## Related

- [[assessmentauditor-assignmentchecker-pattern-analysis]] — Side-by-side comparison of two NC Lambdas
- [[dependency-injection]] — DI patterns in C#
- [[aws-lambda]] — Serverless compute patterns
- [[inference-engine]] — Lambda that infers student skill states
- [[learnosity-result-fetcher]] — Lambda that retrieves assessment results from Learnosity
- [[bff-learnosity-bridge]] — BFF service also deployed as Lambda
