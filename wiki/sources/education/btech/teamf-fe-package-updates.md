---
description: TEAMF FE package updates work — npm audit fix for 5 high-severity vulnerabilities and deferred NPM-to-PNPM migration. Tracks TEAMF-539 Dependabot ticket.
tags:
  - source
  - teamf
  - security
  - package-manager/npm
  - package-manager/pnpm
  - dependabot
  - work
sources:
  - teamf FE Package updates.md
  - TEAMF-539 Address high-severity front end Dependabot alerts.md
created: 2026-05-03
updated: 2026-05-03
---

# TEAMF FE Package Updates (TEAMF-539)

**Sources:**
- `teamf FE Package updates.md` (voice memo)
- `TEAMF-539 Address high-severity front end Dependabot alerts.md` (Jira clipping)

**Date ingested:** 2026-05-03
**Type:** Work ticket
**Ticket:** [TEAMF-539](https://newclassrooms.atlassian.net/browse/TEAMF-539)
**Sprint:** Sprint 53
**Story Points:** 2
**Priority:** High
**Due:** May 8, 2026

## Summary

Frontend package update work to address Dependabot high-severity alerts. Ran `npm audit fix`, cleared 5 high-severity vulnerabilities, deployed to deer environment, kicked off ~3 frontend tests in pipeline. The originally-scoped follow-on (NPM → PNPM migration) was split into a separate ticket because it's a larger lift and needs broader team buy-in.

## Done

- `npm audit fix` ran, 5 high-severity security vulnerabilities resolved
- Deployed to **deer** environment
- Kicked off 3 frontend tests in pipeline to verify no breakage
- Commit ready

## Deferred to Separate Ticket — NPM → PNPM Migration

Reason for split:
- Larger lift than original ticket scope
- Needs team-wide buy-in before commit
- Requires update to Remi docs + post in `#engineering` channel
- Local stress test needed to surface edge cases

## Key Claims

- `npm audit fix` is sufficient for high-severity Dependabot alerts in this codebase — no manual upgrade path needed
- PNPM migration is a separate concern and should not be folded into the security-patch ticket
- Pipeline regression check (3 tests) is the validation gate before merging audit fixes

## Entities Mentioned

- [[dependabot]] — GitHub-native dependency update bot
- [[pnpm]] — Package manager (target for migration)
- [[npm]] — Current package manager

## Concepts Covered

- [[supply-chain-security]] — npm audit / Dependabot workflow
- [[package-manager-comparison]] — NPM vs PNPM
- [[migrating-npm-to-pnpm]] — Migration playbook

## Related

- [[Backlog]] — Active work tracking
- [[axios-supply-chain-compromise-postmortem]] — Why supply chain matters
- [[migrating-npm-to-pnpm]] — Migration playbook (when picked back up)
- [[pnpm-vs-npm-vs-yarn-vs-bun-2026]] — Package manager comparison
