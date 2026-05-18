---
description: "Marvin – Local Frontend Dev & Test User Setup"
tags: ['research', 'marvin', 'new-classrooms']
raw_file: "Marvin – Local Frontend Dev & Test User Setup.md"
created: 2026-05-17
---

A runbook for getting a local Marvin instance running with a seeded test user. Optimized for FE iteration: Docker handles everything except the frontend, which we run directly so changes are instant.

## When to use this

- Setting up Marvin on a fresh clone
- Coming back after a long break and need to re-bootstrap
- Onboarding a new FE engineer
- Need to reproduce something that requires a specific user state
- Or when Docker container data becomes stale after switching between work trees.

## Prerequisites

- Marvin cloned locally
- Docker Desktop installed and running
- pgAdmin set up and connected to the local DB
- Node + npm available on your PATH
- The skip diagnostic script (built with team E during onboarding)

---

## Steps

### 1. Branch + spin up the stack

From the **repo root** (not `frontend/`):

```bash
git checkout -b your-branch
docker compose up --build -d
```

> [!warning] First build is slow A full `--build` takes ~20 minutes. Subsequent runs without `--build` are fast. Get coffee.

### 2. Stop the frontend container

Open Docker Desktop and stop **only** the frontend container. Leave GraphQL, backend, DB, and everything else running.

We'll run the frontend outside Docker so changes hot-reload instantly. Minimize Docker once you've confirmed the rest of the services are up.

### 3. Run the frontend locally

```bash
cd frontend
npm ci
npm run dev:relay
```

> [!info] What `dev:relay` does Runs two scripts concurrently:
> 
> - **Dev server** (Vite)
> - **Relay schema compile** — generates the GraphQL types the FE needs to build
> 
> Both need to be running. If you only see one, something stalled.

> [!tip] Sanity check If you see `npm` errors about missing scripts or weird module resolution, you probably skipped `cd frontend`. Easy mistake when bouncing between terminals.

### 4. Seed the test user in pgAdmin

Open pgAdmin → connect to the local DB → open the **skip diagnostic script**.

Select each code block in turn and hit `F5` to run it. Confirm each one succeeds before moving to the next.

> [!question] Open: GraphQL-side seeding Are there additional steps now for GraphQL-side state that the script doesn't cover? Worth confirming next time this is touched and updating this runbook.

### 5. Verify in the browser

Refresh the app. You should see:

> "Select your grade — heads up, your school roadmap got a little update"

Pick a grade (6th works). You should land on the home page.

---

## Known Issues

> [!bug] Stuck after grade selection (as of 2026-05-05) After picking a grade, the app should route to the home page. Currently it hangs. **This is a real bug, not a setup issue** — don't waste time re-running the script or rebuilding Docker. See [[2026-05-05 BrainBreak Cooldown & Speculative Data Bugs]] for the day's investigation context.

---

## Quick reference

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

## Related

- [[QA FE automation local workflow]]
- Skip diagnostic script (location: _add path_)
- [[Setup Mac Mini for development]]
