---
description: Backend for Frontend (BFF) service providing secure Learnosity API access for the frontend, storing private API keys and handling authorization
tags: [source, work, bff, learnosity, csharp, lambda, docker, dotnet]
sources: ["BFF_LearnosityBridge.md"]
created: 2026-04-30
updated: 2026-04-30
---

# BFF / Learnosity Bridge

**Source:** `BFF_LearnosityBridge.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

Backend for Frontend (BFF) service that stores private Learnosity API keys and provides authorized access for frontend requests. Handles assessment session initialization and other Learnosity API interactions.

## Technology

- **Language:** C#
- **Runtime:** dotnet
- **Deployment:** Docker Compose (local) + AWS Lambda (production)

## Connections

| Component | Direction | Purpose |
|-----------|-----------|---------|
| [[Frontend]] | ← | Frontend makes requests to initialize assessment sessions |
| [[Learnosity]] | → | Calls Learnosity APIs to retrieve assessment data |

## See Also

- [Learnosity Access (Confluence)](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access)
- [Learnosity API Reference](https://reference.learnosity.com/)

## Entities Mentioned

- [[Learnosity Bridge]] — BFF service for Learnosity API proxying
- [[Learnosity]] — Third-party assessment platform

## Concepts Covered

- [[backend-for-frontend]] — BFF pattern for securing third-party API access
- [[lambda-service-pattern]] — C# Lambda deployment pattern

## Related

- [[learnosity-result-fetcher]] — Lambda that retrieves assessment results from Learnosity
- [[graphql-service]] — Core GraphQL service that Learnosity data flows through
