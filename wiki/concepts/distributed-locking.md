---
description: Patterns for achieving mutual exclusion in distributed systems — pessimistic locking, timeouts, and fence tokens
tags: ["distributed-systems", "locking", "consistency", "race-conditions"]
sources: ["lock-it-or-lose-it-race-conditions", "bb-cross-browser-session-lock"]
created: 2026-04-28
updated: 2026-04-28
---

# Distributed Locking

Patterns for achieving mutual exclusion when multiple nodes or processes compete for shared resources in distributed systems.

## Pessimistic Locking

Assume conflict: lock the resource before any operation.

**Three steps:**
1. **Acquire lock** — Claim exclusive access to the resource
2. **Perform operation** — While holding the lock, no other node can interfere
3. **Release lock** — Allow others to proceed

## Timeout Handling

A node may crash after acquiring a lock, leaving it held indefinitely.

**Solution:** Time-bounded locks (leases).
- Assign TTL when acquiring (e.g., 60 seconds)
- Heartbeat renewal by the holder (e.g., every 30 seconds)
- If holder crashes, lock expires automatically after TTL

**Trade-off:** Too short = frequent renewals, overhead. Too long = long waits after crashes.

## Fence Tokens

**Problem:** Node A acquires lock, gets paused (GC, network glitch). Lock expires. Node B acquires lock, updates resource. Node A resumes, thinks it still holds the lock, overwrites Node B's changes.

**Solution:** Monotonically increasing version number (fence token) with every lock acquisition.

```
Node A acquires lock → Token = 1
Node A gets paused
Lock expires
Node B acquires lock → Token = 2
Node B updates resource (token = 2 accepted)
Node A resumes, tries update with Token = 1
Resource rejects: "Latest token is 2, not 1"
```

Fence tokens ensure stale updates are rejected even if a node resumes with an expired lock.

## Client-Side Locking Without Backend Support

When the backend only provides blind upserts (no CAS):

**Approach:** Two-layer lock with three-phase handshake.

1. **Local layer:** `localStorage` mutex for same-browser tabs (fast, synchronous)
2. **Server layer:** Blind upsert with verify-read for cross-browser

**Three-phase handshake:**
1. Preflight read — check current state
2. Blind upsert — write our claim
3. Verify-read — confirm we won the race

This narrows the [[toctou]] window but cannot eliminate it without backend CAS support.

## Comparison

| Approach | Coordination | Crash Safety | Stale Update Prevention | Complexity |
|----------|-------------|--------------|------------------------|------------|
| Single mutex (in-process) | None | Poor | No | Low |
| Distributed lock (Redis/ZK) | Lock service | TTL + heartbeat | Fence tokens | Medium |
| Database CAS | DB | Built-in | Version/check | Medium |
| Client-side two-layer | localStorage + server | TTL only | Partial (verify-read) | High |

## Related

- [[toctou]] — Race condition that distributed locking prevents
- [[bb-cross-browser-session-lock]] — Client-side two-layer lock implementation
- [[bb-brain-break-session-lock-update]] — Updated implementation with 30s heartbeat
- [[lock-it-or-lose-it-race-conditions]] — Article on pessimistic locking patterns
