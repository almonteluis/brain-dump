---
description: New Classrooms tech stack one-line summary covering React/Relay frontend, GraphQL data layer, C#/.NET microservices, Python tests, PostgreSQL, AWS CDK, GitLab pipeline
tags: [source, tech-stack, qa, work, overview]
sources: ["New Classrooms Tech Stack - Quality Assurance.md"]
created: 2026-05-03
updated: 2026-05-03
---

# New Classrooms Tech Stack Overview

**Source:** `New Classrooms Tech Stack - Quality Assurance.md`
**Date ingested:** 2026-05-03
**Type:** Stack reference

## Summary

QA-space confluence page summarizing the New Classrooms tech stack at one-line granularity:

- Frontend: **React + Relay**
- Data: **GraphQL** for access + updates
- Microservices: **C# / .NET Core**
- Test suites: **Python**
- Database: **PostgreSQL** clusters
- Infra: **AWS** managed via **CDK**
- CI/CD: **GitLab** pipeline

## Key Claims

- One-language frontend (TypeScript/React) + one-language backend (C#/.NET) reduces context switching
- Python for test suites is the team-wide test language regardless of system under test
- AWS CDK over Terraform/CloudFormation for IaC

## Concepts Covered

- [[react]] — Frontend framework
- [[relay]] — GraphQL client
- [[graphql]] — Data layer
- [[postgresql]] — Database
- [[aws-aurora-serverless]] — Database hosting (related)
- [[hot-chocolate-graphql]] — .NET GraphQL framework

## Related

- [[marvin-architecture]] — Marvin-specific architecture
- [[lambda-service-pattern]] — Lambda services
- [[graphql-service]] — .NET GraphQL service implementation
- [[bff-learnosity-bridge]] — BFF pattern
- [[claude-graphql-service]] — GraphQL service team docs
- [[claude-backend-for-frontend]] — BFF team docs
