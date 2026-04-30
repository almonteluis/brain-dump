---
description: Time-of-check to time-of-use race condition — a vulnerability where state checked at one moment is stale by the time it is used
tags: ["TOCTOU", "race-condition", "security", "concurrency"]
sources: ["toctou-wikipedia", "toctou-explained-deepstrike", "bb-cross-browser-session-lock"]
created: 2026-04-28
updated: 2026-04-28
---

# Time-of-Check to Time-of-Use (TOCTOU)

A race condition vulnerability where a system checks a condition at one moment and acts on it later, but the state changes in between. The gap between check and use is the attack window.

## How It Works

1. **Check:** System verifies a resource's state (file exists, user has permission, lock is free)
2. **Gap:** Brief interval where the state can change
3. **Use:** System acts based on the now-potentially-stale check

If an attacker changes the state during the gap, the action operates on false assumptions.

## Classic Example (Unix File Access)

```c
if (access("file", W_OK) != 0) {  // CHECK: can we write?
    exit(1);
}
fd = open("file", O_WRONLY);      // USE: open for writing
write(fd, buffer, sizeof(buffer));
```

Attacker replaces `file` with a symlink to `/etc/passwd` between `access` and `open`. The privileged program overwrites the password file.

## In Web Applications

Not limited to OS/file operations. Any check-then-act pattern is vulnerable:

- **Authentication:** Check password → issue token. Under load, multiple wrong-password requests can slip through before the failure state updates.
- **Inventory check:** Check stock → place order. Concurrent requests can both see stock > 0 and both succeed, resulting in overselling.
- **Session locks:** Check if lock is free → write lock. Two browsers can both read "no lock" and both write. (See [[bb-cross-browser-session-lock]])

## Real-World Incidents

| Incident | Year | Impact |
|----------|------|--------|
| BSD 4.3 mail utility | 1991 | Temp file race allowed mailbox modification |
| Docker `docker cp` (CVE-2018-15664) | 2019 | Container escape to host root |
| Tesla Model 3 at Pwn2Own | 2023 | Gateway compromise via TOCTOU |
| AWS DynamoDB DNS outage | 2025 | Major US-EAST-1 regional outage |

## Prevention Strategies

### 1. Atomic Operations
Do check and use in one step:
- `open(path, O_CREAT | O_EXCL)` — fails if file already exists
- Database transactions with `SELECT...FOR UPDATE`
- `upsert` with conditional write (compare-and-swap)

### 2. EAFP: Easier to Ask Forgiveness than Permission
Instead of:
```python
if can_write(file):
    write(file)
```
Do:
```python
try:
    write(file)
except PermissionError:
    handle_error()
```

### 3. Locking and Synchronization
- Mutexes for in-memory data
- File locks (`flock`, `LockFileEx`) for file access
- Distributed leases for cross-service coordination

### 4. Integrity Checks at Use Time
- Compare inode or hash after opening
- Use file descriptors (handles) instead of paths
- Include version numbers or tokens that validate state hasn't changed

### 5. Fence Tokens
Version numbers incremented on every lock acquisition. Updates include the token; the resource rejects updates with stale tokens. See [[distributed-locking]].

## Key Insight

> "Trust is temporal. A system might validate something at one point in time, but if it acts on that validation later, it must account for the world having changed in the meantime."

2004 impossibility result: No portable, deterministic technique for avoiding TOCTOU when using Unix `access` and `open`. The fundamental challenge is that the filesystem namespace can change between any two system calls.

## Related

- [[distributed-locking]] — Locking patterns for distributed systems
- [[bb-cross-browser-session-lock]] — Real-world TOCTOU in a React/GraphQL app
- [[bb-brain-break-session-lock-update]] — Updated implementation notes
- [[cross-browser-toctou-window-analysis]] — Cross-browser TOCTOU window research
- [[toctou-wikipedia]] — Formal definition and academic references
- [[toctou-explained-deepstrike]] — Practical guide with attack methods and detection
- [[race-condition]] — General concurrency timing issues
