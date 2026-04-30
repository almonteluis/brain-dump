---
description: Backend for Frontend pattern — a dedicated backend layer tailored to a specific frontend's needs, often handling aggregation, auth, and third-party API proxying
tags: [architecture, bff, api-gateway, frontend, backend, concept]
created: 2026-04-30
updated: 2026-04-30
sources: ["bff-learnosity-bridge"]
---

# Backend for Frontend (BFF)

A dedicated backend service tailored to the needs of a specific frontend application. The BFF pattern sits between the frontend and downstream services, handling aggregation, authentication, and third-party API proxying.

## When to Use

- Frontend needs data from multiple backend services
- Third-party API keys must be kept server-side
- Frontend requires specialized data shapes different from raw API responses
- Mobile and web clients have different data needs

## Benefits

| Benefit | Description |
|---------|-------------|
| Security | Private API keys and secrets stay server-side |
| Aggregation | Combines multiple backend calls into one frontend request |
| Specialization | Data shapes optimized for specific frontend needs |
| Decoupling | Frontend changes don't cascade to core backend APIs |

## Example: Learnosity Bridge

The [[bff-learnosity-bridge]] stores private Learnosity API keys and proxies assessment session initialization requests from the frontend.

## Related

- [[bff-learnosity-bridge]] — NC's BFF for Learnosity API access
- [[api-gateway]] — Broader pattern for API aggregation
- [[graphql-service]] — Alternative approach: single GraphQL endpoint serving multiple frontends
