---
description: AWS managed serverless relational database with auto-scaling capacity
tags: [aws, database, serverless, postgresql, managed-service]
created: 2026-04-30
updated: 2026-04-30
---

# AWS Aurora Serverless

AWS's serverless relational database service that automatically scales compute capacity based on demand. Available for both MySQL and PostgreSQL-compatible editions.

## Key Characteristics

- Auto-scaling within specified capacity unit ranges
- Pay-per-use pricing model
- Read replicas for read scaling
- Eventual consistency between writer and reader instances
- Typically sub-100ms replication lag
- v2 version offers more granular scaling and instant scaling

## Related

- [[database-postgresql-aurora-guide]] — production architecture
- [[PostgreSQL]] — underlying database engine
- [[read-replica-eventual-consistency]] — replication behavior
