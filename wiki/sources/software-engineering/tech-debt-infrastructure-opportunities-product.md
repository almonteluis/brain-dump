---
description: Tech debt and infrastructure opportunities — frontend, data init, testing, local setup
tags: [source, tech-debt, frontend, testing, local-development, infrastructure, work]
created: 2026-04-30
updated: 2026-04-30
sources: ["Tech Debt and Infrastructure Opportunities - PRODUCT.md"]
---

# Tech Debt and Infrastructure Opportunities

Source: [Confluence — Tech Debt and Infrastructure Opportunities](https://newclassrooms.atlassian.net/wiki/spaces/PRODUCT/pages/1224081420/Tech+Debt+and+Infrastructure+Opportunities)

## Frontend Tech Debt

- Pruning `extensions.scss` + reducing initial load size
- Separating GraphQL query logic from UI concerns → reusable context or custom hooks
- Reducing `useEffect` usage
- Pruning unused components / refactoring pass-through components
- Refactor role-based routing into the router itself

## Data Initialization

- Pre-loaded test accounts (student, teacher, site/network admins)
- Existing QA seeding work should also work on localhost (merged by Sep 2, 2025)
- Sign in as test users in various skill states / brands with minimal work

## Data Synchronization

- Production data sync via local-only migration (Team D)
- Stable localhost fallback for missing Presigned URL variables (Team D — WIP)

## Learnosity Integration Improvements

- Practice problems rendering consistently (S3 bucket access? pre-signed URL related)
- Incomplete data in tables
- Skill assessments — multi-skill local updates
- Diagnostic experience testing

## Testing Automations

| Category | Items |
|----------|-------|
| **Formatting + Linting** | Local enforcement, pre-commit hooks |
| **Unit Tests** | State management and business logic consolidation |
| **E2E QA Tests** | — |
| **Style Regression Tests** | — |

## Documentation

- Improved local setup Confluence docs
- Better flagged LF vs CRLF issues on Windows and impact on `entrypoint.sh`

## Related

- [[learnosity-swap-out-notes-product]] — Major infrastructure initiative
- [[learnosity-access-product]] — Learnosity integration context
- [[team-e-onboarding-product]] — Local dev setup for new team members
