---
description: PostgreSQL database architecture using AWS Aurora Serverless v2 with Flyway migrations and replication
tags: [database, postgresql, aws, aurora, flyway, replication]
sources: [Database.md]
created: 2026-04-30
updated: 2026-04-30
---

# Database PostgreSQL Aurora Guide

**Source:** Database.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Documentation of a PostgreSQL 13 database architecture using AWS Aurora Serverless v2 for production and Docker Compose for local development. Uses Flyway for schema migrations and initial data injection. Covers Postgres terminology hierarchy, Aurora capacity units, read replica replication with eventual consistency, and a separate reporting database for analytics.

## Key Claims

- PostgreSQL 13 via Aurora Serverless v2 in AWS; true Postgres in local Docker Compose
- Flyway handles schema updates and initial data injection
- GraphQL Service talks directly to the database; QA Data Generator inserts test data
- Postgres hierarchy: cluster (server) → catalog (database) → schema → tables
- Aurora Serverless auto-scales within specified capacity unit ranges
- Read replicas provide eventual consistency (lag typically < 100ms)
- Production has a separate reporting database replica for analytics/Quicksight only
- Services should NOT connect to the reporting database

## Postgres Terminology Hierarchy

```
Computer → Cluster (Database Server) → Catalog (Database) → Schema → Tables
```

In this context:
- "qa-clam database" conceptually targets the Aurora cluster
- Literally connected to a specific instance (possibly the read-only replica)
- Using the `postgres` catalog (DBNAME)
- Presumably in the `public` schema

## Entities Mentioned

- [[PostgreSQL]] — database engine (v13)
- [[AWS Aurora Serverless]] — managed serverless database
- [[Flyway]] — database migration tool
- [[GraphQL Service]] — direct database consumer
- [[Learnosity]] — external data storage
- [[Auth0]] — external identity/data storage
- [[S3]] — external object storage
- [[Quicksight]] — analytics/visualization tool

## Concepts Covered

- [[database-migrations]] — Flyway-based schema management
- [[aurora-serverless]] — auto-scaling capacity units, replication
- [[read-replica-eventual-consistency]] — replication lag considerations
- [[postgres-terminology]] — cluster vs catalog vs schema distinctions
- [[reporting-database-separation]] — analytics isolation from production workloads
