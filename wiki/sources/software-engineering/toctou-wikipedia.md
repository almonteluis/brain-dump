---
description: Wikipedia article on time-of-check to time-of-use (TOCTOU) race conditions in software development
tags: ["TOCTOU", "race-condition", "security", "concurrency"]
sources: ["Time-of-check to time-of-use.md"]
created: 2026-04-28
updated: 2026-04-28
---

# Time-of-Check to Time-of-Use (TOCTOU) — Wikipedia

**Source:** `Time-of-check to time-of-use.md` (Wikipedia)
**Date ingested:** 2026-04-28
**Type:** Reference article

## Summary

TOCTOU is a class of software bugs caused by a race condition involving the checking of the state of a part of a system and the use of the results of that check. Common in Unix file system operations but also occurs in sockets, database transactions, web applications, and cloud systems.

## Definition

A program is vulnerable to TOCTOU if:
1. Checks some property or validates some data
2. Takes action based on this information

And:
1. **Non-atomic:** Other programs can execute between steps 1 and 2
2. **Outside control:** Other programs can change the property or data

## Classic Unix Example

```c
if (access("file", W_OK) != 0) {
    exit(1);
}
fd = open("file", O_WRONLY);
write(fd, buffer, sizeof(buffer));
```

Attacker replaces `file` with symlink to `/etc/passwd` between `access` and `open`.

## Real-World Consequences

| Incident | Year | Impact |
|----------|------|--------|
| BSD 4.3 mail utility | 1991 | Exploitable temp file race |
| OpenSSH Unix domain sockets | 1999 | Privilege escalation |
| Docker `docker cp` (CVE-2018-15664) | 2019 | Root access to host filesystem |
| Tesla Model 3 at Pwn2Own | 2023 | Gateway compromise |
| AWS DynamoDB DNS management | 2025 | Major US-EAST-1 outage |

## Prevention Strategies

- **Atomic operations:** Use `O_CREAT|O_EXCL`, database transactions, `SELECT...FOR UPDATE`
- **EAFP philosophy:** "Easier to ask forgiveness than permission" — try the action, handle failure
- **Locking and synchronization:** Mutexes, file locks, distributed leases
- **Secure temp files:** `mkstemp()` which creates and opens in one call
- **Least privilege:** Drop privileges before sensitive operations
- **Integrity checks:** Compare inode/hash at use time vs check time

## Key Insight

2004 impossibility result: No portable, deterministic technique for avoiding TOCTOU when using Unix `access` and `open` calls. The fundamental challenge is ensuring the file system cannot change between two system calls.

## Concepts Covered

- [[toctou]] — Time-of-check to time-of-use race condition
- [[race-condition]] — General concurrency timing issues
- [[privilege-escalation]] — Common outcome of TOCTOU exploits
- [[atomic-operations]] — Primary prevention strategy

## Related

- [[toctou-explained-deepstrike]] — Practical TOCTOU guide with detection and mitigation
- [[bb-cross-browser-session-lock]] — Real-world TOCTOU in React/GraphQL context
- [[lock-it-or-lose-it-race-conditions]] — Distributed locking patterns
