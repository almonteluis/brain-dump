---
description: Lambda service that retrieves student assessment results from Learnosity API and persists them through the GraphQL service
tags: [source, work, learnosity, lambda, csharp, aws, graphql, assessment]
sources: ["LearnosityResultFetcher.md"]
created: 2026-04-30
updated: 2026-04-30
---

# Learnosity Result Fetcher

**Source:** `LearnosityResultFetcher.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

AWS Lambda service that retrieves student assessment results from the Learnosity API and persists them through the GraphQL service. Acts as a data bridge between the third-party assessment platform and the internal data layer.

## Technology

- **Language:** C#
- **Runtime:** AWS Lambda
- **Local Development:** AWS .NET Mock Lambda Test Tool (out-of-band, not in Docker Compose)

## Connections

| Component | Direction | Purpose |
|-----------|-----------|---------|
| [[GraphQL Service]] | → | Persists assessment information retrieved from Learnosity |
| [[Learnosity]] | ← | Retrieves student session data from Learnosity APIs |

## See Also

- [Learnosity Result Fetcher (Confluence)](https://newclassrooms.atlassian.net/wiki/x/KADBAg)

## Entities Mentioned

- [[Learnosity Result Fetcher]] — Lambda service for assessment data retrieval
- [[Learnosity]] — Third-party assessment platform

## Concepts Covered

- [[lambda-service-pattern]] — Three-tier Lambda architecture
- [[data-bridge]] — Moving data between external systems and internal services

## Related

- [[bff-learnosity-bridge]] — BFF service for frontend Learnosity access
- [[graphql-service]] — Service that receives persisted assessment data
- [[inference-engine]] — Consumes assessment data to infer skill states
