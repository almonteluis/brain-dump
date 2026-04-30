---
description: Core GraphQL service providing data abstraction between New Classrooms and partner systems, built with Hot Chocolate on .NET
tags: [source, work, graphql, hot-chocolate, dotnet, ecs, postgresql, miniprofiler]
sources: ["GraphQLService.md"]
created: 2026-04-30
updated: 2026-04-30
---

# GraphQL Service

**Source:** `GraphQLService.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

Core GraphQL service that allows other components to retrieve and store data. Provides the critical abstraction layer between New Classrooms (NC) and partner systems. Built with Hot Chocolate on .NET, runs in Docker Compose locally and as an ECS task behind an ALB in AWS.

## Technology

- **Language:** C#
- **Framework:** Hot Chocolate (GraphQL)
- **Runtime:** dotnet
- **Local:** Docker Compose
- **Production:** ECS task behind ALB

## Connections

| Component | Direction | Purpose |
|-----------|-----------|---------|
| [[Database]] | ↔ | Serves and stores all data; future potential for resolvers to connect to other backends |
| [[Inference Engine]] | ↔ | Reads skill states and skill data; saves new skill states |
| [[Learnosity Result Fetcher]] | → | Retrieves data from Learnosity and caches it |
| [[Frontend]] | ↔ | Reads and writes program data |

## MiniProfiler

[MiniProfiler](https://miniprofiler.com/) available for database interaction profiling in development only.

- Results index: `https://<base-url>/mini-profiler-resources/results-index`
- Per-request: check `X-MiniProfiler-Ids` response header, then `https://<base-url>/mini-profiler-resources/results?id=<id>`
- Shows granular SQL query timing from PostgreSQL

## See Also

- [GraphQL Schema (Confluence)](https://newclassrooms.atlassian.net/wiki/spaces/MARVIN/pages/2261029/Database+migrations) — Note: link text says "GraphQL Schema" but URL points to "Database migrations"

## Entities Mentioned

- [[GraphQL Service]] — Core data service
- [[MiniProfiler]] — Development profiling tool for SQL query analysis

## Concepts Covered

- [[hot-chocolate-graphql]] — .NET GraphQL server framework
- [[graphql-service-pattern]] — Central data abstraction layer
- [[ecs-deployment]] — AWS ECS task deployment pattern
- [[database-profiling]] — SQL query performance analysis

## Related

- [[claude-graphql-service]] — Detailed architecture guide (schema, authorization, DataLoaders)
- [[graphql-schema]] — Schema documentation reference
- [[general-graphql-conventions]] — Naming and formatting conventions
- [[inference-engine]] — Reads/writes skill states through this service
- [[learnosity-result-fetcher]] — Caches Learnosity data through this service
