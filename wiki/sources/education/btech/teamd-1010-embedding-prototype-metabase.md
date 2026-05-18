---
description: Metabase embedding prototype — SSO, row/column security, and in-product dashboard feasibility
tags: [source, teamd, metabase, embedding, dashboard, sso, work]
created: 2026-04-30
updated: 2026-04-30
sources: ["TEAMD-1010 Embedding prototype for metabase.md"]
---

# TEAMD-1010: Embedding Prototype for Metabase

Source: [Jira — TEAMD-1010](https://newclassrooms.atlassian.net/browse/TEAMD-1010)

## Summary

Prototype embedding a Metabase dashboard into Teach to One (TTO) with user authentication and row/column security filtering.

## Details

| Field | Value |
|-------|-------|
| **Assignee** | Luis Almonte |
| **Reporter** | Joseph Levine |
| **Priority** | Medium |
| **Story Points** | 7 |
| **Created** | February 24, 2026 |

## Goal

Determine whether Metabase can serve as a viable vehicle for delivering in-product dashboards before the start of the next school year. Address:

- Performance concerns
- Site- or network-admin-specific views
- Authentication model feasibility

## Discussion

- **Sam Martin**: Goal is to embed a dashboard from Metabase in TTO, leveraging user auth and row/column security to filter data.
- **Luis Almonte**: Confirmed scope — prototype modular embedding with SSO and row/column security. Asked about real data vs dummy embed.
- **Garima Sharma**: Asked about passing site IDs from FE to Metabase query as inputs for filtering.
- **Sam Martin**: Not a blocker for Metabase contract, but still valuable for understanding feasibility and timeline for future dashboard changes (teachers, site admins, district admins).

## Related

- [[metabase]] — Metabase concept overview
- [[metabase-admin-dashboard-initiative]] — Cross-functional dashboard program
- [[metabase-full-app-embedding]] — JWT SSO iframe guide
- [[metabase-modular-sdk-quickstart]] — SDK evaluation setup
