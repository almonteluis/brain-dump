---
description: Learnosity — third-party assessment platform. NC uses it for student assessment sessions, result retrieval, and analytics. The engine behind the items that feed [[knowledge-tracing]].
tags: [entity, third-party, assessment, learnosity, work]
created: 2026-04-30
updated: 2026-05-17
sources: ["bff-learnosity-bridge", "learnosity-result-fetcher"]
---

# Learnosity

[Learnosity](https://www.learnosity.com/) is the third-party assessment platform New Classrooms uses for serving assessment items, collecting student responses, and feeding results into the [[inference-engine]]. It's the item-delivery layer between the student and the [[knowledge-tracing]] model — Learnosity serves the question, the student answers, the result flows back through GraphQL, and the mastery estimate updates.

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
