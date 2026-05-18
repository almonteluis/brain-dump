---
description: AWS CloudWatch Logs Insights query reference for BFF, GraphQL Service, and Inference Engine log groups with example queries and field discovery tips
tags:
  - source
  - aws
  - observability
  - logging
  - marvin
  - marvin/bff
  - graphql
  - inference-engine
  - work
sources:
  - Using CloudWatch Logs Insights - Marvin.md
created: 2026-05-03
updated: 2026-05-03
---

# [[CloudWatch]] Logs Insights Queries — Marvin

**Source:** `Using CloudWatch Logs Insights - Marvin.md`
**Date ingested:** 2026-05-03
**Type:** Tool reference

## Summary

CloudWatch Logs Insights query reference for Marvin's three primary backend log groups: **BFF Lambda**, **GraphQL Service ECS task**, and **Inference Engine Lambda**. Queries cost money — be specific on log group + time range. Logs Insights "discovers" JSON fields lazily; expect blank results on fresh fields until discovery completes.

Console: [us-east-2 Logs Insights](https://us-east-2.console.aws.amazon.com/cloudwatch/home?region=us-east-2#logsV2:logs-insights)

## Example Queries

### BFF — Recent messages

Log group: `/aws/lambda/backend-for-frontend`

```
fields @timestamp, @message
| sort @timestamp desc
| limit 20
```

### GraphQL Service — EF Core database commands

Log group: `/ecs/tto-{env_type}-use2-{env_name}-graphql-service`

```
fields @timestamp, State.elapsed, State.commandText
| filter Category == 'Microsoft.EntityFrameworkCore.Database.Command'
| sort @timestamp desc
| limit 20
```

### Inference Engine — Basic log levels

Log group: `/aws/lambda/inference-engine`

```
fields @timestamp, log_level, category, message
| filter ispresent(log_level)
| sort @timestamp desc
| limit 20
```

## Tips

- **Discovered fields lag**: Logs Insights surfaces JSON fields in the right-edge drawer. New fields can take a while to be discovered — query may return blank until then. Wait or retry.
- **Cost control**: queries scan log data and bill on bytes scanned. Narrow log groups + tight time ranges are essential.
- Queries can be **saved** for reuse, **exported to CSV**, and **added to dashboards**.

## Key Claims

- Three primary log groups cover most observability surface area: BFF Lambda, GraphQL Service ECS, Inference Engine Lambda
- EF Core's `Microsoft.EntityFrameworkCore.Database.Command` Category filter isolates SQL queries from GraphQL service logs
- Logs Insights cost discipline matters — queries that scan unbounded ranges can be expensive

## Entities Mentioned

- [[bff-learnosity-bridge]] — Lambda BFF log group
- [[graphql-service]] — .NET ECS service log group
- [[inference-engine]] — Lambda inference log group

## Concepts Covered

- [[cloudwatch-logs-insights]] — AWS log query interface
- [[observability]] — Logs as observability pillar
- [[telemetry]] — Application logging patterns

## Related

- [[lambda-service-pattern]] — Lambda logging conventions
- [[logging-conventions]] — General logging conventions
