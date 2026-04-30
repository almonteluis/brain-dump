---
description: High-level architecture overview of the Marvin platform — components, connections, and design goals
tags: ["marvin", "architecture", "aws", "graphql", "microservices"]
created: 2026-04-30
updated: 2026-04-30
sources: ["Architecture - Marvin.md"]
---

## Marvin Architecture Overview

Marvin is a narrowly-focused platform comprising a small set of services triggered through an event system and operating on data through GraphQL.

### Architectural Goals

1. **Simplicity** — Buildable by a small group of experienced developers in a short timeframe
2. **Clarity** — Coherent interfaces between internal components and between NC and partner systems
3. **Flexibility** — Components can be added, removed, or changed with reasonable effort
4. **Testability** — Amenable to testing at any level of granularity
5. **Scalability** — At least an order of magnitude easily achievable
6. **Portability** — Movable to other hosting or execution environments
7. **Security** — Follows established security best practices

### Internal Components

| Component | Technology | Purpose |
|-----------|------------|---------|
| [[database-postgresql-aurora-guide\|Database]] | AWS RDS Aurora PostgreSQL serverless | Stores all product data |
| [[graphql-service]] | C# / [[hot-chocolate-graphql\|Hot Chocolate]] / AWS ECS | Data access abstraction layer |
| [[marvin-frontend]] | React 18 / TypeScript / [[relay]] / CloudFront | Primary user interface |
| [[bff-learnosity-bridge\|BFF / Learnosity Bridge]] | C# .NET 8 / AWS Lambda + API Gateway | Auth, Learnosity gateway |
| [[event-stream]] | AWS Kinesis | Centralized event recording |
| [[event-dispatcher]] | C# / AWS Lambda | Listens and triggers services |
| [[roadmap-builder]] | C# / AWS Lambda | Builds student roadmaps |
| [[inference-engine]] | C# / AWS Lambda | Updates skill states |
| [[learnosity-result-fetcher]] | C# / AWS Lambda | Retrieves Learnosity assessment results |
| [[strapi-cms]] | Node.js / ECS / ALB | Content management |
| [[external-sync-service]] | AWS Lambda (hourly) | Pulls data from Clever |

### External Integrations

- [[auth0]] — Identity provider and SSO
- [[learnosity]] — Assessment platform
- GitLab — Code hosting and SDLC
- AWS — Cloud infrastructure
- GitHub — Cloud Posse infrastructure
- Clever — SSO provider and external data source

### Key Connections

```
Frontend ←→ BFF ←→ GraphQL Service ←→ Database
                ↕
Event Stream ←→ Event Dispatcher ←→ Roadmap Builder / Inference Engine / LRF
```

### See Also

- [[marvin-frontend]] — Frontend architecture and configuration
- [[graphql-service]] — GraphQL service details
- [[logging-conventions]] — Logging standards across Marvin services
- [[relay-connections]] — GraphQL pagination patterns
- [[global-object-ids]] — GraphQL global object ID specification
- [[query-filters]] — Server-side filtering patterns
