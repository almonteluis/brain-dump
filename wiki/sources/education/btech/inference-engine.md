---
description: Lambda service that processes student assessment and skill state data to infer knowledge and update skill states
tags:
  - source
  - work
  - inference
  - lambda
  - csharp
  - aws
  - skill/state
  - assessment
sources:
  - InferenceEngine.md
created: 2026-04-30
updated: 2026-04-30
---

# Inference Engine

**Source:** `InferenceEngine.md`
**Date ingested:** 2026-04-30
**Type:** work-doc

## Summary

AWS Lambda service that examines student assessment results and skill state information to infer which skills a student can be assumed to know, then updates skill states accordingly. Core to the adaptive learning algorithm.

## Technology

- **Language:** C#
- **Runtime:** AWS Lambda
- **Local Development:** AWS .NET Mock Lambda Test Tool (out-of-band, not in Docker Compose)

## Connections

| Component | Direction | Purpose |
|-----------|-----------|---------|
| [[GraphQL Service]] | ↔ | Reads and writes skill states directly to database |
| [[QA Data Generator]] | → | Inserts test data directly into database |

## See Also

- Inferencing feature specification
- QA docs about testing

## Entities Mentioned

- [[Inference Engine]] — Skill state inference Lambda
- [[Skill State]] — Student's inferred knowledge state per skill

## Concepts Covered

- [[lambda-service-pattern]] — Three-tier Lambda architecture (Function → Engine → DataService)
- [[adaptive-learning]] — Inferring student knowledge from assessment data
- [[skill-inference]] — Bayesian or rule-based knowledge tracing

## Related

- [[graphql-service]] — Service the Inference Engine reads/writes through
- [[learnosity-result-fetcher]] — Provides assessment data that feeds inference
