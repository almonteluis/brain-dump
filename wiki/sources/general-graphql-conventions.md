---
description: GraphQL naming, query, mutation, formatting, and nullability conventions for server and client development
tags: [source, graphql, conventions, naming, hot-chocolate, work, dotnet]
sources: ["GeneralConventions.md"]
created: 2026-04-30
updated: 2026-04-30
---

# General GraphQL Conventions

**Source:** `GeneralConventions.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

Team conventions for GraphQL schema design and client usage covering naming (types, attributes, queries, mutations, enums), formatting rules, and nullability decisions. Used with Hot Chocolate .NET GraphQL framework.

## Naming Conventions

| Element | Case | Example | Anti-Example |
|---------|------|---------|--------------|
| Type names | UpperCamelCase | `SkillLadderNode` | — |
| Attribute names | lowerCamelCase | `skillBucket` | `skillBucketNode` |
| Query names | lowerCamelCase, no verb prefix | `allActiveSkills` | `getAllActiveSkills` |
| Mutation names | lowerCamelCase, verb prefix | `createFoo`, `deactivateBar` | `fooCreation` |
| Enum types | UpperCamelCase | `StatusEnum` | — |
| Enum values | ALL_CAPS_SNAKE_CASE | `ACTIVE`, `IN_PROGRESS` | `active`, `inProgress` |
| Acronyms in CamelCase | First letter only | `Id`, `Http`, `Us` | `ID`, `HTTP`, `US` |

### Query Name Patterns

- No verb prefix — queries indicate fetched data nature, not action
- Single required parameter: include in name: `skillStatesByStudentId`

### Mutation Name Patterns

- Start with verb: `create`, `delete`, `upsert`, or less CRUDdy like `deactivate`
- Single input / single payload pattern: `makeFoo` → `MakeFooInput` + `MakeFooPayload`
- Payload must return affected objects

## Query Rules

- All query operations should be named
- Values passed as variables, not inline

## Mutation Rules

- Single input, single payload
- Named operations
- Values passed as variables

## Formatting

- Two-space indent for schema documents and queries
- No linting tool currently configured
- Single-line comments use `#`, not `"""`

## Nullability and Lists

All collections defined as `[!]!`:
- Collection itself never null
- Collection contains no null values
- Returns empty list `[]` instead of error when collection does not exist

This is a restrictive but safe choice. The GraphQL service will not raise an error for missing collections — it returns an empty list.

## Concepts Covered

- [[graphql-schema-design]] — Naming and structural conventions for GraphQL APIs
- [[nullability-patterns]] — `[!]!` vs `[!]` vs `[]` vs `[]!` trade-offs
- [[naming-conventions]] — Case rules across the codebase

## Related

- [[claude-graphql-service]] — Hot Chocolate GraphQL service architecture
- [[graphql-schema]] — Schema documentation (Confluence link)
- [[graphql-service]] — GraphQL service connections and MiniProfiler
