---
description: Logging standards for Marvin — structured JSON logs, levels, PII rules, and CloudWatch integration
tags:
  - marvin
  - logging
  - observability
  - json
  - pii
created: 2026-04-30
updated: 2026-04-30
sources:
  - Logging - Marvin.md
---

## Logging Conventions

Logging is critical for understanding current functioning and analyzing past behavior, both in deployed environments and during local development.

### Development Guidelines

- **Use standard logging libraries** (C# `log4net`, Python `logging`)
- **Avoid writing directly to stdout/stderr** in committed code
- Use levels mindfully: **DEBUG, INFO, WARNING, ERROR, FATAL**
- Presume only **INFO and above** will be logged in production and staging
- Use **structured JSON format** (e.g. `log4net.Ext.Json`, `python-json-logger`)
- Log messages must be **concise and self-contained** — never split a single message across multiple log entries
- **Timestamps in ISO-8601 UTC** (`2022-12-02T12:29:28Z`)
- **Delimit variable data** to prevent confusion when blank/null: `"Scheduling complete for school '{school_name}'"`

### Log Levels

| Level | Usage | Examples |
|-------|-------|----------|
| DEBUG | Detailed troubleshooting info | "Database query took 200ms", "GraphQL service returned 11939 bytes" |
| INFO | Ordinary system functioning | "Scheduler running for section 42", "Scheduling complete for section 42" |
| WARNING | Anticipated anomaly, no danger | "Tried to run scheduler for section with zero students", "Retried data layer connection" |
| ERROR | Bad but coherent continuation | "Tried to run scheduler for nonexistent section 123" |
| FATAL | Cannot continue sanely | "Scheduler unable to connect to GraphQL service after 5 retries" |

### JSON Log Schema

| Field | Required | Type | Description |
|-------|----------|------|-------------|
| `timestamp` | yes | string | ISO-8601 UTC (e.g. `2023-02-24T08:38:51Z`) |
| `log_level` | yes | string | DEBUG, INFO, WARNING, ERROR, FATAL |
| `message` | yes | string | Concise description (< 100 chars recommended) |
| `environment` | yes | string | Localhost, Development, Staging, Production |
| `host` | no | string | Hostname or IP |
| `service` | no | string | Originating service (e.g. Scheduler) |
| `category` | no | string | Subsystem or class name |
| `exception` | no | any | Error details (message, code, stack trace) |
| `entity` | no | object | Related data entity: `{"type": "Student", "id": 123}` |

### PII Rules

**Do not log personally identifiable information.**

Prohibited fields:
- `users.first_name`
- `users.last_name`
- `users.email`

Use `users.id` (internal) or `users.public_user_id` (external key) to identify users.

### Infrastructure

- Log to **[[CloudWatch]]** in AWS
- Use **CloudWatch Insights** for structured log querying:

```
fields @timestamp, @logStream, @log, message
| filter log_level == "DEBUG" and entity.id == 234
| sort @timestamp desc
| limit 20
```

### See Also

- [[observability]] — Observability as competitive advantage
- [[marvin-architecture]] — Marvin system architecture
- [[sentry]] — Error tracking platform
- [[cloudwatch]] — AWS CloudWatch logging
