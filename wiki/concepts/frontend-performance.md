---
description: Frontend performance optimization — identifying bottlenecks, reducing payload sizes, and improving perceived load times
tags: ["performance", "frontend", "optimization", "graphql", "react", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["classesroster-graphql-performance-issue", "teamf-296-vite-upgrade"]
---

# Frontend Performance

Patterns and techniques for optimizing web application performance, from build tooling to runtime data fetching.

## Common Bottlenecks

### Over-Fetching

Requesting more data than the UI needs. Example: fetching 15,000 nested user records for a dropdown that only needs class names.

**Fix:** Create purpose-built light queries. See [[graphql-over-fetching]].

### Sequential Round-Trips

Paginating 100 records at a time when a single request of 5000 would suffice.

**Fix:** Increase page size, use backend-supported max (e.g., `first: 5000`).

### Missing Filters

Fetching all records and filtering client-side when backend already supports scoped queries.

**Fix:** Pass filter parameters (e.g., `siteIds`) to backend queries.

### Network-Only Fetch Policies

Disabling cache means re-fetching on every visit, even when data hasn't changed.

**Fix:** Use `store-or-network` for data that changes infrequently.

### Build Tool Performance

Slow build times during development reduce iteration speed.

**Fix:** Upgrade build tools (e.g., Vite 4 to 5 gave 55% build improvement).

## Measurement

- **Build time** — Time from `npm run build` to completion
- **Time to interactive** — When the page becomes responsive
- **Payload size** — Network bytes transferred
- **Query execution time** — Backend resolver performance

## Related

- [[graphql-over-fetching]] — Query optimization case study
- [[vite]] — Build tool performance
- [[relay]] — Efficient data fetching patterns
- [[classesroster-graphql-performance-issue]] — Real-world performance analysis
- [[teamf-296-vite-upgrade]] — Build performance improvement case study
