---
description: Comprehensive TOCTOU guide from DeepStrike — attack methods, real-world examples, detection, and mitigation strategies
tags: ["TOCTOU", "security", "race-condition", "penetration-testing"]
sources: ["What Is Time of Check Time of Use (TOCTOU)? Explained.md"]
created: 2026-04-28
updated: 2026-04-28
---

# What Is Time of Check Time of Use (TOCTOU)? Explained

**Source:** `What Is Time of Check Time of Use (TOCTOU)? Explained.md` (DeepStrike)
**Date ingested:** 2026-04-28
**Type:** Security guide
**Author:** Mohammed Khalil (DeepStrike)

## Summary

TOCTOU is a race condition vulnerability where a system checks a condition (file access, credential, resource availability) and later uses the result, leaving a window for an attacker to change the resource in between. Attackers exploit the timing gap to bypass security checks, escalate privileges, or corrupt data.

## How It Works

1. **Time of Check:** Application verifies a resource's state
2. **Pause/Gap:** Brief interval before actual use
3. **Time of Use:** Application acts based on the (now potentially stale) check

## Real-World Examples

### Docker Container Breakout (CVE-2018-15664)

`docker cp` resolved a file path inside the container, then later used that path on the host — non-atomically. Attacker inserted a malicious symlink during the interval, granting read/write access to any host file as root.

### Authentication Race in Web App (2025 Bug Bounty)

Login system checked password, then generated token. Under heavy load, an attacker flooded the server with login attempts. Multiple wrong-password requests got past the check before the system updated login attempt state, issuing tokens for wrong credentials.

### AWS DynamoDB Outage (October 2025)

Automation applied an outdated DNS configuration after a newer one had already been deployed and cleaned up. Outdated plan deleted wrong IP addresses, causing widespread service failure. Not malicious — a TOCTOU bug at cloud scale.

## Common Attack Methods

- **Symlink and file replacement:** Rapidly create/remove symlinks in a tight loop to hit the race window
- **Brute forcing the race:** Run thousands of attempts, or slow down the victim with heavy I/O
- **Abusing async/distributed processes:** Trigger multi-stage operations and interject faster operations between stages

## Detection and Monitoring

- **System call monitoring:** `auditd`, kernel event monitors for unexpected privileged file writes
- **Application telemetry:** Correlating check-state and use-state logs; flagging impossible sequences
- **Static analysis:** Flagging dangerous function pairs like `access` followed by `open`
- **Dynamic race testing:** Parallel threads continuously altering resources while test code runs

## Mitigation Strategies

| Strategy | How |
|----------|-----|
| Atomic operations | `O_CREAT\|O_EXCL`, `SELECT...FOR UPDATE`, database transactions |
| EAFP | Try the action directly; handle errors instead of pre-checking |
| Locking | Mutexes, `flock`, distributed leases |
| Secure temp files | `mkstemp()` — create + open in one call |
| Least privilege | `seteuid()`, sandboxing, narrow permissions |
| Integrity checks | Compare inode/hash at use time; use file descriptors not paths |
| Frameworks | High-level APIs that abstract away check-then-act patterns |

## Key Quote

> "Trust is temporal. A system might validate something at one point in time, but if it acts on that validation later, it must account for the world having changed in the meantime."

## Concepts Covered

- [[toctou]] — Time-of-check to time-of-use race condition
- [[privilege-escalation]] — Primary impact of TOCTOU exploits
- [[container-escape]] — Docker CVE-2018-15664 example
- [[race-condition-detection]] — Monitoring and testing approaches

## Related

- [[toctou-wikipedia]] — Formal definition and academic background
- [[bb-cross-browser-session-lock]] — TOCTOU in React/GraphQL web application
- [[bb-brain-break-session-lock-update]] — Updated implementation notes
- [[cross-browser-toctou-window-analysis]] — Cross-browser TOCTOU window research
- [[lock-it-or-lose-it-race-conditions]] — Distributed locking as mitigation
- [[axios-supply-chain-compromise-postmortem]] — Another security incident
