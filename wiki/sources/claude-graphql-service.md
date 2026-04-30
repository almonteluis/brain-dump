---
tags: [graphql, dotnet, hot-chocolate, entity-framework, work]
sources: ["CLAUDE-graphql-service.md"]
created: 2026-04-29
updated: 2026-04-29
---

# CLAUDE GraphQL Service Guide

**Source:** CLAUDE-graphql-service.md
**Date ingested:** 2026-04-29
**Type:** Work documentation

## Summary

Architecture guide for the .NET 6 Hot Chocolate GraphQL service with Entity Framework Core and PostgreSQL.

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

## Key Patterns

### Schema Organization
- Types mirror database entities with explicit field resolvers
- `[ID(nameof(Entity))]` for global IDs (Node:123 format)
- Custom filter inputs (not HotChocolate built-in — see bug note in README)

### Authorization
- Policy-based: `[Authorize(Policy = "ReadStudents")]`
- `PermissionRequirement` takes `Type` + `PermissionAction`
- `RelationshipChecker.HasPermittedRelationship()` for ownership checks
- Permissions hardcoded to roles in `UserManagerService.cs`

### DataLoaders
- Batched child collection loading
- Registered in `Extensions/ServiceCollectionExtensions.cs`

### Resolver Example
```csharp
[Authorize(Policy = "ReadStudents")]
public IEnumerable<StudentSkill> GetSkillStatesByStudentId(
    Context dbContext,
    IResolverContext resolverContext,
    [ID(nameof(Student))] int studentId,
    SkillStatesByStudentIdFilterInput? filter = null)
```

## Workflow

```bash
dotnet run                              # Start service (port 5172)
dotnet run -- schema export --output ../../shared/Nc.GraphQLClient/GraphQLClient/schema.graphql
```

## Concepts Covered

- [[hot-chocolate-graphql]] — .NET GraphQL server framework
- [[graphql-authorization]] — Policy-based permission requirements
- [[dataloader-pattern]] — Batched loading to prevent N+1 queries
- [[global-id-pattern]] — Node:123 format for entity identification
- [[graphql-service]] — NC GraphQL service overview
- [[general-graphql-conventions]] — Team naming and formatting conventions
