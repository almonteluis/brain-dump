---
description: TEAME-218 cross-browser session lock — two-layer client-side mutex with three-phase handshake to prevent duplicate brain break submissions across browsers
tags:
  - TEAME-218
  - marvin/frontend/brain-break
  - session/lock
  - TOCTOU
  - react
  - race-condition
sources:
  - Cross-Browser Session Lock (TEAME-218).md
  - BB being open in 2 sessions via different browser.md
  - cross-browser TOCTOU window.md
created: 2026-04-28
updated: 2026-04-28
---

# Cross-Browser Session Lock (TEAME-218)

**Source:** `Cross-Browser Session Lock (TEAME-218).md`, `BB being open in 2 sessions via different browser.md`, `cross-browser TOCTOU window.md`
**Date ingested:** 2026-04-28
**Type:** Implementation documentation / bug fix
**Ticket:** TEAME-218

## Summary

Users logged into the same account across multiple browsers generated separate brain break sessions. Both sessions recorded survey responses, corrupting experiment data. The fix implements client-side mutual exclusion via a two-layer lock with a three-phase handshake to narrow the [[toctou]] window. Learned the term "TOCTOU" while googling the race condition during implementation.

## The Problem

- **Bug:** Brain break modal open and could be submitted same day via 2 different browser tabs (found by QA)
- **Backend constraint:** Single GraphQL mutation `upsertExperimentsSpeculativeData` is a blind upsert — no compare-and-swap, no conditional write, no atomicity guarantees
- **Result:** Two clients can write different session IDs at the same time, both succeed. Last writer wins.
- **Implication:** Mutual exclusion must be enforced entirely on the client side

## The Solution: Two-Layer Lock with Verify-Read

### Layer 1: localStorage (Same-Browser)

A synchronous mutex stored at key `brain_break_active_lock`. Each tab generates a UUID on mount. Before showing the modal, a tab checks localStorage for an active lock from a different tab. If one exists and is within TTL (60 seconds), the tab backs off.

localStorage operations are fast and synchronous but only work within a single browser. Two different browsers have separate localStorage domains.

### Layer 2: Server-Side Speculative Data (Cross-Browser)

Each tab writes its session ID and a timestamp to `experimentsSpeculativeData` via GraphQL upsert. Other tabs read this data before acquiring the lock.

The critical insight: since the upsert is blind, reading and writing in separate steps creates a [[toctou]] (time-of-check/time-of-use) race. Two browsers can both read "no lock," both write, and both believe they hold it.

### Three-Phase Handshake

The fix narrows the TOCTOU window to the gap between phases 2 and 3:

1. **Preflight read.** Fetch current lock state from the server. If another session holds an active lock, stop here.
2. **Blind upsert.** Write our session ID and a fresh timestamp.
3. **Verify-read.** Fetch the lock state again. If our session ID is there, we won. If someone else's ID is there, we lost the race — release and back off.

Both clients must complete their upsert before either starts the verify-read for both to believe they won.

### Heartbeat

- Lock expires after 60 seconds (`LOCK_TTL_MS`)
- Lock-holding tab renews every 30 seconds (`LOCK_HEARTBEAT_INTERVAL_MS`) — half the TTL
- Gives 30 seconds of margin for network latency, JS thread blocking, or GC pauses
- Heartbeats only fire when tab is visible; when hidden, heartbeat stops and lock expires naturally

### Visibility Recovery

When a hidden tab becomes visible again, it re-validates the server lock before re-acquiring. If another browser grabbed the lock during the hidden period, the tab steps down instead of blindly overwriting the new holder.

## Bugs Found During Code Review

### Bug 1: Stale Closure in Heartbeat setTimeout

`setTimeout` captured `renewLock` and `startHeartbeat` by closure. If upstream dependencies changed during the 30-second wait, the timeout fired with stale function references.

**Fix:** Ref-based pattern. `renewLockRef` and `startHeartbeatRef` update every render. The setTimeout reads from refs instead of closures.

```typescript
const renewLockRef = useRef(renewLock);
renewLockRef.current = renewLock;

const startHeartbeat = useCallback((sessionId: string) => {
  clearHeartbeat();
  heartbeatTimeoutRef.current = setTimeout(async () => {
    const success = await renewLockRef.current(sessionId);
    if (success) startHeartbeatRef.current(sessionId);
  }, LOCK_HEARTBEAT_INTERVAL_MS);
}, [clearHeartbeat]); // stable — no renewLock dependency
```

### Bug 2: Concurrent renewLock Race

The heartbeat timeout and the visibility change handler both called `renewLock` with no mutual exclusion. Since `renewLock` is async (three network round-trips), both could be in-flight simultaneously.

**Fix:** `renewalInFlightRef` mutex. Both paths check the flag before entering, set it before the async operation, and clear it after.

### Bug 3: Dead Code

`releaseLocalLockOnly` was returned from the hook but never called by any consumer. Removed.

## What Remains

The blind upsert prevents true mutual exclusion. Under extreme timing conditions (two browsers completing the full three-phase handshake in the same millisecond), both could see their own session ID in the verify-read. Full elimination requires backend support — compare-and-swap semantics or a dedicated lock endpoint.

The client-side approach is a pragmatic mitigation. It closes the most common race windows (sequential triggers, hidden tab recovery, slow heartbeats) and degrades gracefully when it cannot guarantee exclusion (the lock expires via TTL in 60 seconds).

## Files Changed

| File | Purpose |
|---|---|
| `src/businessLogicService/brainBreakSessionLock.ts` | Pure functions: lock data parsing, TTL checks, localStorage mutex, ownership helpers |
| `src/custom-hooks/useBrainBreakSessionLock.ts` | React hook: acquire/release/renew with three-phase handshake, heartbeat, visibility guard |
| `src/contexts/brainBreakContext.tsx` | Consumer: simplified `showBrainBreak` flow, removed inline network logic |
| `src/custom-hooks/useBrainBreakSessionLock.test.tsx` | Tests: preflight rejection, post-write verification, visibility guard, heartbeat cadence |

## Testing

- Cross-browser (Chrome + Firefox, same user): one modal shown, second browser blocked
- Same browser, two tabs: localStorage mutex blocks second tab immediately
- Tab hidden 60+ seconds, other browser acquires lock: hidden tab steps down on re-visible
- Tab close: lock released, another tab acquires within seconds

## Concepts Covered

- [[toctou]] — Time-of-check to time-of-use race condition
- [[distributed-locking]] — Client-side mutual exclusion without backend CAS
- [[stale-closure]] — React ref pattern for avoiding stale callback references
- [[react-useeffect-patterns]] — Heartbeat pattern with cleanup and visibility guard

## Related

- [[teame-218-brainbreak-postmortem]] — Main TEAME-218 post-mortem
- [[BB being open in 2 sessions via different browser]] — Updated implementation with 30s heartbeat and ownership verification
- [[brainbreak-knowledge-graph-analysis]] — Graph analysis showing useBrainBreakSessionLock at intersection of state and lock communities
- [[lock-it-or-lose-it-race-conditions]] — Distributed locking patterns from external source
- [[toctou-explained-deepstrike]] — Comprehensive TOCTOU explainer
