---
description: "Technical debt tracking and infrastructure improvement opportunities"
tags: ['research']
raw_file: "Tech Debt  andInfrastructure Opportunities.md"
created: 2026-05-17
---

---

# Tech Debt and Infrastructure Opportunities

*Last updated: 17 Sep 2025*

## Frontend Tech Debt

- Pruning extensions.scss + reducing initial load size
- Migrating global styles to in-component Tailwind
- Updating PrimeFlex to Tailwind
- Separating GraphQL query logic from UI concerns - moving into reusable context or custom hooks
- Reducing useEffect usage
- Pruning unused components / refactoring pass-through components
- Refactor role-based routing into the router itself

## Data Initialization

- Pre-loaded test accounts (student, teacher, site and network admins) - Existing QA work to seed users should also work on localhost - likely merged by 02 Sep 2025
- Want to be able to sign in as test users in various skill states / brands / with minimal additional work

## Data Synch

- Data Synch. of Production Data via Local-only Migration (Team D)
- Stable Localhost fallback for missing Presigned URL variables - Work in Progress in Team D

## Improved Learnosity Integrations / Workarounds

- Practice Problems Rendering Consistently - S3 Bucket access? Might be related to pre-signed URL. List of data in the tables may be incomplete
- Skill Assessments - multi-skill local updates
- Diagnostic experience testing

## Testing Automations

- Formatting + Linting Tests
- Local Enforcement
- Pre-Commit Hooks
- Unit Tests (State Management and Business Logic)
- Consolidate
- End-to-End QA tests
- Style Regression Tests

## Documentation

- Improved Local Setup Confluence Docs
- Better flagged LF vs. CRLF issues on Windows and impact on entrypoint.sh
