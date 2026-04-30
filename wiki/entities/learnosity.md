---
description: Third-party assessment platform providing APIs for student assessment sessions, results, and analytics
tags: [entity, third-party, assessment, learnosity, work]
created: 2026-04-30
updated: 2026-04-30
sources: ["bff-learnosity-bridge", "learnosity-result-fetcher"]
---

# Learnosity

[Learnosity](https://www.learnosity.com/) is a third-party assessment platform used by New Classrooms for student assessment sessions, result retrieval, and analytics.

## NC Integration

| Service | Purpose |
|---------|---------|
| [[bff-learnosity-bridge]] | BFF proxy for frontend assessment session initialization |
| [[learnosity-result-fetcher]] | Lambda that retrieves assessment results and persists through GraphQL |

## APIs

- [Learnosity API Reference](https://reference.learnosity.com/)
- [Learnosity Access (Confluence)](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/43057209/Learnosity+Access)

## Related

- [[graphql-service]] — Receives persisted assessment data
- [[inference-engine]] — Consumes assessment data to infer skill states
