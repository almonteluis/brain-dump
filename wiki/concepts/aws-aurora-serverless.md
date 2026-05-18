---
description: AWS managed serverless relational database with auto-scaling capacity
tags: [aws, database, serverless, postgresql, managed-service]
created: 2026-04-30
updated: 2026-04-30
---

# AWS Aurora Serverless

Imagine [[postgresql]] or MySQL, but instead of guessing how many ACUs you need and either overpaying or throttling, the database scales compute up and down on demand. That's Aurora Serverless — AWS's answer to "what if I don't want to think about database capacity?"

It works well for workloads with spiky traffic (education platforms where 200 kids all log in at 8:15 AM, then nothing for an hour). v2 made scaling near-instant. The catch: read replicas have eventual consistency, typically sub-100ms replication lag but it's not zero. If your app can't tolerate stale reads right after a write, design around it.

## Key Details

- Auto-scaling within specified capacity unit ranges
- Pay-per-use — you're billed for what you actually consume
- Read replicas for read scaling
- v2 offers granular scaling and near-instant capacity changes

## Related

- [[database-postgresql-aurora-guide]] — production architecture
- [[postgresql]] — underlying database engine
- [[read-replica-eventual-consistency]] — replication behavior
