---
description: Hot Chocolate — .NET GraphQL server framework used for the NC GraphQL service with schema stitching, DataLoaders, and authorization
tags: [graphql, dotnet, hot-chocolate, framework, concept]
created: 2026-04-30
updated: 2026-04-30
sources: ["claude-graphql-service", "graphql-service", "general-graphql-conventions"]
---

# Hot Chocolate GraphQL

[Hot Chocolate](https://chillicream.com/docs/hotchocolate) is the .NET GraphQL server framework used for the NC GraphQL service. Provides schema stitching, batched DataLoaders, policy-based authorization, and MiniProfiler integration.

## Key Features Used

| Feature | Purpose |
|---------|---------|
| Schema stitching | Compose multiple schemas into one endpoint |
| DataLoaders | Batch N+1 queries into single round-trip |
| Authorization | Policy-based `[Authorize]` attributes |
| Global IDs | `[ID(nameof(Entity))]` for Node:123 format |
| Custom filters | Domain-specific filter inputs (not built-in) |

## Architecture

```
Nc.GraphQL.Service/
├── Schema/              # GraphQL types, queries, mutations
├── Authorization/       # Permission requirements, relationship checking
├── DataLoaders/         # Batch loading for N+1 prevention
├── Extensions/          # Service registration, DI configuration
├── Middleware/          # Request pipeline (logging, auth)
├── Services/            # Business logic, implementations
├── PdfTemplates/        # PDF generation templates
└── Startup.cs           # App configuration, schema stitching
```

## Resolver Example

```csharp
[Authorize(Policy = "ReadStudents")]
public IEnumerable<StudentSkill> GetSkillStatesByStudentId(
    Context dbContext,
    IResolverContext resolverContext,
    [ID(nameof(Student))] int studentId,
    SkillStatesByStudentIdFilterInput? filter = null)
```

## Related

- [[graphql-service]] — NC GraphQL service overview
- [[claude-graphql-service]] — Detailed architecture guide
- [[general-graphql-conventions]] — Team naming and formatting conventions
- [[dataloader-pattern]] — N+1 query prevention
- [[graphql-authorization]] — Policy-based permissions
