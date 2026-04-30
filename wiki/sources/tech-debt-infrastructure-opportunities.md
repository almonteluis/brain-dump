---
tags: [tech-debt, frontend, testing, infrastructure, work]
sources: ["TechDebtandInfrastructureOpportunities.md"]
created: 2026-04-29
updated: 2026-04-29
---

# Tech Debt and Infrastructure Opportunities

**Source:** TechDebtandInfrastructureOpportunities.md
**Date ingested:** 2026-04-29
**Type:** Work documentation

## Summary

Tracking document for frontend tech debt, data initialization, testing automation, and documentation improvements. Last updated 17 Sep 2025.

## Frontend Tech Debt

- Pruning `extensions.scss` + reducing initial load size
- Migrating global styles to in-component Tailwind
- Updating PrimeFlex to Tailwind
- Separating GraphQL query logic from UI concerns → reusable context or custom hooks
- Reducing useEffect usage
- Pruning unused components / refactoring pass-through components
- Refactor role-based routing into the router itself

## Data Initialization

- Pre-loaded test accounts (student, teacher, site/network admins)
- QA seed users should work on localhost
- Sign in as test users in various skill states/brands with minimal work

## Data Synchronization

- Production data sync via local-only migration (Team D)
- Stable localhost fallback for missing Presigned URL variables (WIP, Team D)

## Learnosity Integrations

- Practice Problems rendering consistently (S3 access/presigned URL)
- Skill Assessments — multi-skill local updates
- Diagnostic experience testing

## Testing Automations

- Formatting + Linting tests
- Local enforcement
- Pre-commit hooks
- Unit tests (state management and business logic)
- Consolidate test suites
- End-to-End QA tests
- Style regression tests

## Documentation

- Improved local setup Confluence docs
- Better flagged LF vs CRLF issues on Windows and impact on `entrypoint.sh`

## Concepts Covered

- [[tech-debt-tracking]] — Catalog of known improvements
- [[frontend-migration]] — PrimeFlex → Tailwind, SCSS → Tailwind
- [[graphql-separation]] — Moving query logic out of UI components
- [[test-automation]] — Pre-commit hooks, unit tests, E2E, style regression
