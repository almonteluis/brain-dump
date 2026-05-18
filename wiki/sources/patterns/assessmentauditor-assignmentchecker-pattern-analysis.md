---
description: Lambda Service Pattern analysis — two NC Lambdas share identical 3-tier scaffolding, suggesting generic framework extraction
tags:
  - aws/lambda
  - csharp
  - architecture
  - entity/new-classrooms/teach-to-one
  - di-pattern
sources:
  - AssessmentAuditor vs AssignmentChecker Pattern Analysis.md
created: 2026-04-28
updated: 2026-04-28
---

# AssessmentAuditor vs AssignmentChecker: Lambda Service Pattern Analysis

**Source:** `AssessmentAuditor vs AssignmentChecker Pattern Analysis.md`
**Date ingested:** 2026-04-28
**Type:** Architecture analysis

## Summary

Both `AssessmentAuditor` and `AssignmentChecker` implement the identical "Lambda Service Pattern" — a three-tier architecture of `Function` (entry point) → `Engine` (business orchestration) → `DataService` (GraphQL client wrapper), wired together via identical DI configuration shapes in `Startup.cs`. The only meaningful differences are business-domain specific: event payloads, external service integrations (Learnosity/Kinesis vs none), and the particular GraphQL services consumed. The structural scaffolding is copy-paste identical, strongly suggesting these should be merged into a shared generic Lambda framework.

## Key Claims

- **100% structural match** — File layout, Function class structure, Startup inheritance, DI registration style, Engine constructor pattern, DataService wrapper pattern, assembly attributes, and using statements are identical
- **Only business logic differs** — Trigger type (timer vs event-driven), external integrations (Learnosity/Kinesis/CloudWatch vs none), GraphQL service interfaces, and DataService method signatures
- **`Shared.Environment.Startup` already exists** — The codebase already recognizes commonality with a base Startup class; this should be extended to cover the full pattern

## Identical Structure

```
+----------------------------------+
|  Function.cs                     |
|  - [LambdaFunction] Handle(...)  |
|  - Injects: ILogger, Engine      |
|  - Delegates to Engine.RunAsync  |
+----------------------------------+
              |
              v
+----------------------------------+
|  Startup.cs                      |
|  - [LambdaStartup]               |
|  - Inherits Shared.Environment   |
|    .Startup                      |
|  - Validates env vars            |
|  - Registers:                    |
|    * Singletons (config, secrets)|
|    * Scoped GraphQL services     |
|    * Scoped AWS SDK clients      |
|    * IDataService -> DataService |
|    * Engine                      |
|    * AddGraphQLClientWithAuth    |
+----------------------------------+
              |
              v
+----------------------------------+
|  Engine.cs                       |
|  - Injects: ILoggerFactory +     |
|    domain services               |
|  - RunAsync(...)                 |
|  - Orchestrates business flow    |
+----------------------------------+
              |
              v
+----------------------------------+
|  DataService.cs                  |
|  - Implements IDataService       |
|  - Injects: IGraphQLResponse     |
|    Unwrapper + domain services   |
|  - Wraps GraphQL calls with      |
|    null-guard + logging          |
+----------------------------------+
```

## What Differs

| Aspect | AssessmentAuditor | AssignmentChecker |
|--------|-------------------|-------------------|
| **Trigger type** | Timer/scheduled (no payload) | Event-driven (`SkillStatesPayload`) |
| **External integrations** | Learnosity API, Kinesis, CloudWatch | None (only GraphQL) |
| **GraphQL services** | `IStudentSkillDiagnosticService`, `IStudentSkillAssessmentService` | `IAssignmentService`, `IStudentService` |
| **DataService methods** | Read-only queries | Read + write |
| **Env vars required** | `GraphQlServerUrl`, `KinesisEventStreamArn` | `GraphQlServerUrl` only |

## Proposed Generic Framework

```csharp
// Shared.LambdaFramework
public abstract class LambdaFunction<TPayload>
{
    protected readonly ILogger Logger;
    protected readonly ILambdaEngine<TPayload> Engine;

    protected LambdaFunction(ILogger logger, ILambdaEngine<TPayload> engine)
    {
        Logger = logger;
        Engine = engine;
    }

    public async Task HandleAsync(TPayload input, ILambdaContext context)
    {
        Logger.LogInformation("Function called with {AwsRequestId}", context.AwsRequestId);
        try { await Engine.RunAsync(input); }
        catch (Exception ex) { Logger.LogError(ex, ex.Message); }
    }
}

public interface ILambdaEngine<TPayload>
{
    Task RunAsync(TPayload input);
}
```

## Risk Assessment

| Risk | Mitigation |
|------|------------|
| Breaking existing Lambdas | Introduce framework alongside existing code; migrate one at a time |
| Over-abstraction | Keep framework minimal; only extract truly identical scaffolding |
| Testing disruption | Generic base classes are easier to mock; improves testability |
| Deployment complexity | No change to deployment; only code organization |

## Entities Mentioned

- [[marlboro]] — NC codebase
- [[AssessmentAuditor]] — Timer-triggered Lambda comparing Learnosity vs NC diagnostic/assessment data
- [[AssignmentChecker]] — Event-driven Lambda marking student skill assignments complete

## Concepts Covered

- [[lambda-service-pattern]] — Three-tier Lambda architecture: Function → Engine → DataService
- [[dependency-injection]] — Fluent `IServiceCollection` registration pattern in C#
- [[graphql-client-wrapper]] — `IGraphQLResponseUnwrapper` pattern for typed GraphQL calls

## Related

- [[nc-frontend-architecture]] — New Classrooms frontend architecture
- [[jumpcloud-django-user-sync-pipeline]] — Another NC backend integration pattern
