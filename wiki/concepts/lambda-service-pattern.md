---
description: Three-tier Lambda architecture pattern — Function entry point, Engine business orchestration, DataService GraphQL wrapper
tags: ["aws-lambda", "csharp", "architecture", "serverless"]
sources: ["assessmentauditor-assignmentchecker-pattern-analysis"]
created: 2026-04-28
updated: 2026-04-28
---

# Lambda Service Pattern

A three-tier architecture for AWS Lambda functions using C# and dependency injection.

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

## Components

### Function.cs
- `[LambdaFunction]` attribute marks the handler
- Constructor injects `ILogger` and `Engine`
- Minimal wrapper: logs request ID, delegates to `Engine.RunAsync()`, catches exceptions

### Startup.cs
- `[LambdaStartup]` on class inheriting `Shared.Environment.Startup`
- Constructor validates required env vars via `HashSet<string>`
- Fluent `IServiceCollection` chain:
  - Singletons: config, secret providers, environment
  - Scoped: GraphQL services, AWS SDK clients, business services
  - `AddGraphQLClientWithAuth` for GraphQL client setup

### Engine.cs
- Constructor receives `ILoggerFactory` (creates its own logger) + domain dependencies
- `RunAsync()` orchestrates calls to external services, data layer, event publishers
- Business constants and env-driven configuration as fields

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

**Keep per-service:**
- Concrete `Engine` implementing `ILambdaEngine<TPayload>`
- Concrete `DataService` with domain methods
- Domain-specific DI registrations

## Related

- [[assessmentauditor-assignmentchecker-pattern-analysis]] — Side-by-side comparison of two NC Lambdas
- [[dependency-injection]] — DI patterns in C#
- [[aws-lambda]] — Serverless compute patterns
- [[inference-engine]] — Lambda that infers student skill states
- [[learnosity-result-fetcher]] — Lambda that retrieves assessment results from Learnosity
- [[bff-learnosity-bridge]] — BFF service also deployed as Lambda
