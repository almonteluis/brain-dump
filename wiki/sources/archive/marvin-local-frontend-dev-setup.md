---
tags: [work, marvin, runbook, frontend, docker, local-dev, testing]
sources: ["Marvin – Local Frontend Dev & Test User Setup.md"]
created: 2026-05-05
updated: 2026-05-05
type: runbook
project: Marvin
audience: frontend
---

# Marvin — Local Frontend Dev & Test User Setup

**Source:** Marvin – Local Frontend Dev & Test User Setup.md
**Date ingested:** 2026-05-05
**Type:** Runbook

## Summary

Runbook for getting a local Marvin instance running with a seeded test user. Optimized for FE iteration: Docker handles everything except the frontend, which runs directly for instant hot-reload.

## When to Use

- Fresh clone setup
- Re-bootstrap after long break
- Onboarding new FE engineer
- Reproduce specific user state
- Docker data stale after switching worktrees

## Prerequisites

- Marvin cloned locally
- Docker Desktop running
- pgAdmin connected to local DB
- Node + npm on PATH
- Skip diagnostic script (built with Team E during onboarding)

## Steps

### 1. Branch + spin up stack

From **repo root** (not `frontend/`):

```bash
git checkout -b your-branch
docker compose up --build -d
```

> First build ~20 minutes. Subsequent runs without `--build` are fast.

### 2. Stop frontend container

In Docker Desktop, stop **only** the frontend container. Leave GraphQL, backend, DB running.

### 3. Run frontend locally

```bash
cd frontend
npm ci
npm run dev:relay
```

`dev:relay` runs Vite dev server + Relay schema compiler concurrently. Both must be running.

### 4. Seed test user in pgAdmin

Open pgAdmin → connect to local DB → open skip diagnostic script. Run each code block with `F5`. Confirm success before next block.

> **Open:** GraphQL-side seeding steps may be missing from script. Confirm and update runbook.

### 5. Verify in browser

Refresh app. Should see:

> "Select your grade — heads up, your school roadmap got a little update"

Pick grade (6th works). Should land on home page.

## Known Issues

### Grade selection hang (as of 2026-05-05)

After picking grade, app should route to home page. Currently hangs. **Real bug, not setup issue.** See [[brainbreak-lts-cooldown-speculative-bugs]] for investigation context.

## Quick Reference

```bash
# from repo root
git checkout -b your-branch
docker compose up --build -d

# stop frontend container in Docker Desktop, then:
cd frontend
npm ci
npm run dev:relay

# pgAdmin → run skip diagnostic script block by block (F5)
# refresh app → select grade → home page
```

## Entities Mentioned

- [[Team E]] — built skip diagnostic script during onboarding

## Concepts Covered

- [[docker]] — Docker compose stack, frontend outside container
- [[vite]] — `dev:relay` script (Vite + Relay compiler)
- [[relay]] — Schema compilation for FE types
- [[pgadmin]] — Database seeding workflow

## Related

- [[qa-fe-automation-local-workflow]] — Personal Playwright + WezTerm test workflow
- [[docker-fe-esbuild-exe-error]] — Cross-platform Docker pitfall
- [[brainbreak-lts-cooldown-speculative-bugs]] — Grade selection hang context
- [[work-status-may-5-2026]] — Related daily status
