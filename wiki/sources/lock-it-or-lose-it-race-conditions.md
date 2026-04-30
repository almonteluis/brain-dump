---
description: Distributed locking patterns — pessimistic locking, timeouts, and fence tokens for preventing race conditions
tags: ["distributed-systems", "locking", "race-conditions", "consistency"]
sources: ["Lock It or Lose It Avoiding Race Conditions in Distributed Systems.md"]
created: 2026-04-28
updated: 2026-04-28
---

# Lock It or Lose It: Avoiding Race Conditions in Distributed Systems

**Source:** `Lock It or Lose It Avoiding Race Conditions in Distributed Systems.md`
**Date ingested:** 2026-04-28
**Type:** Technical guide
**Author:** Shubham Lad

## Summary

Clear explanation of race conditions in distributed systems and how pessimistic locking prevents them. Covers lock acquisition, timeout handling for crashed nodes, and fence tokens for preventing stale updates after node pauses.

## Pessimistic Locking

Assumes the worst: "If I don't block access to this data now, someone else will mess it up." The system locks the resource upfront, preventing anyone else from touching it until the first process finishes.

**Three steps:**
1. **Lock the resource** — Node A acquires lock before any operation
2. **Exclusive access** — Other nodes wait until lock is released
3. **Release the lock** — Node A finishes, others can proceed

## Timeout Handling

Without timeouts, a crashed node leaves the lock hanging indefinitely.

- When Node A acquires the lock, assign a timeout (e.g., 10 seconds)
- If Node A crashes, the system auto-releases the lock after timeout
- Dynamically adjustable timeouts: longer for intensive tasks, shorter for quick ones

## Fence Tokens: Preventing Stale Updates

**Problem:** Node A acquires lock, gets paused (network glitch, GC). Node B sees lock expired, acquires it, updates the resource. Node A resumes, thinks it still owns the lock, and overwrites Node B's changes.

**Solution:** Fence token = version number that increments with every lock acquisition.

| Step | Token | Action |
|------|-------|--------|
| Node A acquires lock | 1 | Gets Token = 1 |
| Node B acquires lock | 2 | Gets Token = 2 |
| Node A resumes, tries update | 1 | Sends Token = 1 |
| Resource rejects | — | Resource knows latest token is 2, rejects stale update |

## Key Insight

> "Using fence tokens ensures that even if a node resumes after being paused, it can't overwrite more recent changes. This prevents stale data from creeping into the system, keeping the data consistent and reliable."

Fence tokens are commonly used in distributed databases and systems to maintain strong consistency, especially in environments prone to delays or unpredictable pauses.

## Concepts Covered

- [[distributed-locking]] — Pessimistic locking in distributed systems
- [[fence-tokens]] — Version numbers for stale update prevention
- [[timeout-handling]] — Preventing indefinite locks from crashed nodes
- [[race-conditions]] — General concurrency issues in distributed systems

## Related

- [[bb-cross-browser-session-lock]] — Client-side locking without backend CAS support
- [[toctou-wikipedia]] — TOCTOU as a specific race condition type
- [[toctou-explained-deepstrike]] — Practical TOCTOU guide
