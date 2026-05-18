---
description: Step-by-step guide for running Unleash locally in Docker, importing flag JSON, and wiring marvin frontend .env to local server
tags: [source, feature-flags, unleash, docker, local-development, work, marvin]
sources: ["Local Development with Unleash.md"]
created: 2026-05-03
updated: 2026-05-03
---

# Unleash Local Development Setup

**Source:** `Local Development with Unleash.md`
**Date ingested:** 2026-05-03
**Type:** Tool guide

## Summary

Tutorial for running an Unleash server locally in Docker so feature-flagged code can be developed without touching the Enterprise instance. Covers cloning the Unleash repo, importing flag JSON exported by the Product Owner, and connecting the marvin frontend `.env` to `localhost:4242`.

## Setup Steps

### 1. Run Unleash Server in Docker

```bash
git clone git@github.com:Unleash/unleash.git
cd unleash
docker compose up -d
```

Browse to `localhost:4242`. Login: `admin` / `unleash4all`.

### 2. Get Flag Export from Product Owner

Product Owner exports a flag from the Enterprise server:

1. Default project page → check the flag(s) to export
2. Click **export** in the modal that appears
3. Pick the environment where the strategy is set up
4. Hit export → downloads JSON

### 3. Import Flag Locally

1. Local Unleash → **Projects → default**
2. Click **Import**
3. Pick environment (`development` or `production` — does not matter locally)
4. **Validate** → **Import Configuration**

### 4. Wire marvin Frontend `.env`

Add two lines to `marvin/frontend/.env`:

```
VITE_UNLEASH_URL=http://localhost:4242/api/
VITE_UNLEASH_CLIENT_KEY=YOUR_KEY
```

Get `YOUR_KEY` from local Unleash → **Admin Settings → Access control → API access** → copy the **frontend API token**.

## Key Claims

- Local Unleash server lets devs force flags on/off and toggle variants without touching shared Enterprise state
- PO-driven workflow: PO creates the flag in Enterprise, exports JSON, devs import locally
- Frontend connection requires API token with `frontend` scope (not the default token)

## Entities Mentioned

- [[unleash]] — Feature flag platform
- [[docker]] — Container runtime
- [[vite]] — Build tool reading `.env`

## Concepts Covered

- [[feature-flag-hierarchy]] — Projects → Environments → Flags → Variants

## Related

- [[unleash-feature-flags]] — Full Unleash guide (hierarchy, naming, lifecycle)
- [[unleash-one-pager-product]] — Team-facing one-pager (CR/QA checklist)
- [[feature-flagging-quick-reference]] — Quick reference card
- [[unleash-release-flag-management-ab-lts]] — A/B vs LTS comparison
