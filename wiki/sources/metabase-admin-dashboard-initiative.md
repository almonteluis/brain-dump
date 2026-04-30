---
description: Cross-functional initiative to deliver a universal admin dashboard for school and district leaders using Metabase
tags: [metabase, dashboard, data-warehouse, analytics, project-planning]
sources: [Metabase conflucence info.md]
created: 2026-04-30
updated: 2026-04-30
---

# Metabase Admin Dashboard Initiative

**Source:** Metabase conflucence info.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Cross-functional program (Product, Data, Engineering, Program Success) to deliver a scalable reporting solution for school and district administrators. Covers the universal admin dashboard scope, delivery method evaluation (automated sends vs embedded dashboards), custom partner dashboards, stakeholder ownership, timeline, and risks.

## Key Claims

- North Star: universally useful administrator dashboard by Aug 1, 2026
- Two delivery paths under consideration: automated data sends (CSV/scheduled reports) vs embedded Metabase dashboards
- Embedded dashboards require solving authentication model, user provisioning, role-level security
- Custom partner dashboards (Miami, Houston, Summit) follow the universal dashboard launch
- Confluence is source of truth for scope, requirements, decisions, metrics definitions
- Jira epics: Universal Admin Dashboard, Reporting Infrastructure, Partner Custom Dashboards, Validation & Rollout

## Dashboard Modules (Initial Scope)

- Student engagement
- Weekly activity
- Usage trends
- Diagnostic completion
- Roadmap progress
- Learning pace
- Outcomes/growth
- School-level summaries
- District-level rollups

## Delivery Method Comparison

| Solution | Benefits | Open Questions |
|----------|----------|----------------|
| Automated Data Sends | Faster access, easier manipulation, lower embedding dependency | Drill-down limits, file format expectations, scheduling |
| Embedded Dashboards | Native UX, interactive filtering, centralized hub | Auth model, user provisioning, role security, engineering effort, QA |

## Stakeholders

| Person | Role | Responsibility |
|--------|------|----------------|
| Joseph | Technical Leadership | Data warehouse architecture, Metabase strategy, dashboard approach, security model |
| Marilia | Product | Requirements, prioritization, documentation, Jira structure |
| Christina | Data Engineer | Data modeling, ETL improvements, warehouse structure |
| Marcos | Developer | Embedding implementation, authorization, role-level security |
| Rachel | Business Stakeholders | Program Success point of contact |

## Timeline

- **Phase 0** (Apr 27–May 4): Organize the system
- **Phase 1** (May 4–May 18): Discovery & Requirements
- **Phase 2** (May 18–Jul 13): Build Universal Admin Dashboard
- **Phase 3** (Jul 13–Aug 1): Internal Validation & Initial Rollout
- Post-Aug 1: Build & Launch Custom Partner Dashboards

## Risks

- Ambiguous ownership
- Hidden work in spreadsheets
- Timeline pressure for August 1st
- Data quality issues
- Dependency on onboarding resources
- Undefined stakeholder expectations
- Authentication/embedding complexity

## Entities Mentioned

- [[Metabase]] — dashboard/visualization platform
- [[Quicksight]] — AWS analytics tool (existing reporting)
- [[Auth0]] — identity provider (SSO context)

## Concepts Covered

- [[embedded-analytics]] — surfacing dashboards inside a product
- [[data-warehouse-reporting]] — ETL-driven analytics pipelines
- [[cross-functional-program-management]] — coordinating Product, Data, Engineering, Program Success
- [[partner-specific-dashboards]] — contractual reporting commitments
