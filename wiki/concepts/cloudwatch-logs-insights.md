---
description: AWS CloudWatch Logs Insights — flexible query interface for CloudWatch logs supporting fields, filters, sort, and aggregation with cost-aware querying
tags:
  - aws
  - observability
  - logging
  - query
  - concept
sources:
  - cloudwatch-logs-insights-queries.md
created: 2026-05-03
updated: 2026-05-03
---

# CloudWatch Logs Insights

AWS [[CloudWatch]] Logs Insights is a flexible query interface for CloudWatch logs. Queries select log groups + time ranges, then chain pipe-style operations: `fields`, `filter`, `sort`, `limit`, `stats`, `parse`.

## Why Use It

- Single query across multiple log groups
- Field discovery from JSON-formatted logs (auto-extracted)
- Save queries, export to CSV, embed in CloudWatch dashboards
- Better than `grep`-equivalent log scanning for complex investigations

## Basic Query Pattern

```
fields @timestamp, @message
| sort @timestamp desc
| limit 20
```

Standard built-in fields: `@timestamp`, `@message`, `@log`, `@logStream`, `@ingestionTime`, `@duration`.

## Filtering

```
fields @timestamp, log_level, message
| filter ispresent(log_level)
| filter log_level = 'ERROR'
| sort @timestamp desc
```

Filter operators: `=`, `!=`, `>`, `<`, `like`, `ispresent()`, `strcontains()`.

## Aggregation

```
stats count(*) by bin(5m)
```

`stats` operations: `count`, `sum`, `avg`, `min`, `max`, `pct(field, p)`.

## Cost Discipline

Queries scan log data — billed on bytes scanned.

- **Narrow time range** — minutes/hours, not days
- **Specific log group** — never `*` across account
- **Use `limit`** when exploring
- **Avoid unbounded `stats`** without time bins

## Discovered Fields

Logs Insights surfaces JSON fields in the right-edge drawer after parsing log entries. Newer fields can take time to appear; expect blank results on a query that targets a freshly-introduced field. Wait or retry.

## Marvin Use Cases

- **BFF Lambda**: `/aws/lambda/backend-for-frontend` — recent messages, error rates
- **GraphQL Service ECS**: `/ecs/tto-{env}-graphql-service` — EF Core SQL queries via `Category == 'Microsoft.EntityFrameworkCore.Database.Command'`
- **Inference Engine Lambda**: `/aws/lambda/inference-engine` — log_level filtered, basic message text

## Related

- [[cloudwatch-logs-insights-queries]] — Marvin-specific query reference
- [[observability]] — Logs as observability pillar
- [[telemetry]] — Application logging
- [[lambda-service-pattern]] — Lambda log group conventions
- [[bff-learnosity-bridge]], [[graphql-service]], [[inference-engine]] — Marvin services with primary log groups
