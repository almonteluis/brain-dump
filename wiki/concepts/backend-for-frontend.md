---
description: Backend for Frontend (BFF) — a dedicated backend service tailored to one specific frontend. Aggregation, auth proxying, data shaping — all in one place.
tags:
  - architecture
  - marvin/bff
  - api/gateway
  - frontend
  - backend
  - concept
created: 2026-04-30
updated: 2026-05-17
sources:
  - bff-learnosity-bridge
---

# Backend for Frontend (BFF)

A BFF is a backend service that exists for exactly one frontend. Not a shared API that every client hits — a dedicated layer that aggregates, reshapes, and proxies specifically for *your* app's needs. If your mobile app and web app need different data shapes, they get different BFFs.

## When You Need One

- Frontend needs data from multiple backend services
- Third-party API keys must stay server-side (never in the bundle)
- Frontend requires specialized data shapes different from raw API responses
- Mobile and web clients have different data needs

## What It Gets You

| Benefit | What it means |
|---------|---------------|
| Security | Private API keys stay server-side |
| Aggregation | Multiple backend calls → one frontend request |
| Specialization | Data shapes optimized for specific frontend needs |
| Decoupling | Frontend changes don't cascade to core backend APIs |

## Example: Learnosity Bridge

The [[bff-learnosity-bridge]] stores private Learnosity API keys and proxies assessment session initialization requests from the frontend. Without it, those keys would end up in the browser bundle where anyone could grab them.

BFFs are the backend cousin of [[atomic-design]] — both are about building specialized interfaces for specific consumers instead of one giant thing that tries to serve everyone.

## Related

- [[bff-learnosity-bridge]] — NC's BFF for Learnosity API access
- [[api-gateway]] — Broader pattern for API aggregation
- [[graphql-service]] — Alternative approach: single GraphQL endpoint serving multiple frontends
