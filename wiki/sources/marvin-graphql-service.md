---
description: Marvin GraphQL service — Hot Chocolate .NET framework, ECS deployment, MiniProfiler, and schema regeneration
tags: ["marvin", "graphql", "hot-chocolate", "dotnet", "ecs", "miniprofiler"]
created: 2026-04-30
updated: 2026-04-30
sources: ["GraphQL Service - Marvin.md"]
---

## GraphQL Service

The central data access layer for the Marvin platform.

### Purpose

Allows other components to retrieve and store any data they need. Provides the critical abstraction layer between New Classrooms and partner systems.

### Technology

- **Language:** C#
- **Framework:** [[hot-chocolate-graphql|Hot Chocolate]]
- **Local:** Runs via `dotnet` in Docker Compose
- **AWS:** ECS task behind an ALB

### Connections

- [[database-postgresql-aurora-guide|Database]] — serves and stores all data (future: other backends via resolvers)
- [[inference-engine]] — reads skill states, saves new ones
- [[learnosity-result-fetcher]] — caches Learnosity data
- [[marvin-frontend|Front End]] — reads and writes program data

### Schema Regeneration

For client use, regenerate schema files following the guide at:
`graphql-service#generating-a-schema-file-for-client-use`

### MiniProfiler

[MiniProfiler](https://miniprofiler.com/) provides database interaction insights for development environments only.

**Access:** `https://<graphql-host>/mini-profiler-resources/results-index`

**Per-request:** Check the `X-MiniProfiler-Ids` response header. The last GUID in the list corresponds to that request's report:
`https://<graphql-host>/mini-profiler-resources/results?id=<guid>`

Shows granular timing including SQL queries and PostgreSQL response times.

### See Also

- [[marvin-architecture]] — System architecture overview
- [[graphql-service]] — General GraphQL service page (work doc)
- [[hot-chocolate-graphql]] — Hot Chocolate framework
- [[relay-connections]] — Connection pagination
- [[global-object-ids]] — Global object identification
- [[query-filters]] — Query filtering patterns
