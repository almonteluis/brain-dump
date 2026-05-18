---
description: "Plan: Fix BrainBreak Cross-Tab Session Lock"
tags: ['research']
raw_file: "recursive-tickling-kahn.md"
created: 2026-05-17
---

# Plan: Fix BrainBreak Cross-Tab Session Lock

## Context

Two browser tabs on the same PC both open the BrainBreak modal. The server-side lock via speculative-data mutations doesn't prevent this because:

1. **Stale read**: `brainBreakContext.tsx:191` reads lock state from `speculativeQueryDataRef.current` — a ref set once during hydration, never refreshed. Tab A writes lock to server, Tab B's stale ref still shows "no lock".
2. **Race condition**: Even with fresh data, both tabs can check "no lock" simultaneously before either finishes writing. The server mutation is a blind upsert with no compare-and-swap.

Fix: add a synchronous `localStorage` mutex as a first gate before the server mutation. `localStorage.setItem` is single-threaded across tabs — no race possible.

## Files to Modify

### 1. `src/businessLogicService/brainBreakSessionLock.ts` — Add localStorage lock helpers

Add at bottom of file:

- `BRAIN_BREAK_LOCK_KEY = 'brain_break_active_lock'` — localStorage key
- `LocalLockEntry` interface — `{ tabId: string; claimedAt: number }`
- `tryAcquireLocalLock(tabId, ttlMs?)` — synchronous claim. Returns `false` if another tab holds active lock
- `releaseLocalLock(tabId)` — removes lock only if this tab owns it
- `readLocalLock()` (private) — reads/parses localStorage entry
- `isLocalLockActive(entry, ttlMs)` (private) — TTL check using existing `LOCK_TTL_MS`

All wrapped in try/catch that **fails open** (returns `true`) if localStorage unavailable.

### 2. `src/custom-hooks/useBrainBreakSessionLock.ts` — Integrate localStorage gate

**Import additions**: `tryAcquireLocalLock`, `releaseLocalLock` from business logic

**`acquireLock()` (line 77)** — gate on local lock first:
```
1. tryAcquireLocalLock(tabSessionId) → false? return false
2. await upsertLock(tabSessionId) → failed? releaseLocalLock + return false
3. isHoldingLockRef = true, startHeartbeat, return true
```

**`releaseLock()` (line 87)** — add `releaseLocalLock(tabSessionIdRef.current)`

**`beforeunload` handler (line 110)** — add `releaseLocalLock(tabSessionIdRef.current)` before server write

**`startHeartbeat` (line 66)** — after successful `upsertLock`, call `tryAcquireLocalLock(sessionId)` to refresh TTL

### 3. `src/contexts/brainBreakContext.tsx` — Remove stale ref check

**Delete lines 190-195** in `showBrainBreak`:
```typescript
// DELETE: speculativeQueryDataRef-based lock check
const lockData = extractLockData(speculativeQueryDataRef.current);
if (isLockActive(lockData)) { ... }
```

Lock checking now happens entirely inside `acquireLock()`.

**Remove imports**: `extractLockData`, `isLockActive` from `brainBreakSessionLock`

## Edge Cases

| Case | Handling |
|------|----------|
| Tab crash (no beforeunload) | localStorage entry has TTL — `tryAcquireLocalLock` treats stale entries (>60s) as expired |
| Browser close | beforeunload releases localStorage + server |
| Same tab double-click | `tryAcquireLocalLock` is idempotent when `tabId` matches |
| localStorage unavailable | try/catch fails open, server lock still provides some protection |
| Heartbeat renewal | `startHeartbeat` refreshes localStorage TTL alongside server lock |

## Verification

1. Open two tabs as same user → click trigger in both → only one modal appears
2. Close Tab A (with lock) → Tab B can immediately acquire lock (localStorage cleared)
3. Kill Tab A (no beforeunload) → wait 61s → Tab B acquires lock (TTL expired)
4. Check Network tab — `recordExperimentSpeculativeData` mutation still fires (server lock still active)
5. Run existing tests: `npm test`

