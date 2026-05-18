---
description: Database migration tool for version-controlled schema changes
tags: [flyway, database, migrations, schema, devops, concept]
created: 2026-04-30
updated: 2026-04-30
---

# Flyway

Open-source database migration tool that favors simplicity and convention over configuration. Version-controlled schema changes via SQL or Java-based migrations.

## Key Characteristics

- Versioned migrations (V1__description.sql)
- Repeatable migrations (R__description.sql)
- Baseline for existing databases
- Repair and clean commands
- Multiple database support
- Command-line, Maven, Gradle, and Java API integration

## Gotcha: Missing Migration Files After Rebase

From [[worktree-rebase-missed-flyway-migrations]] — `git rebase origin/main` without `git fetch` first can leave worktree with stale remote state. If a teammate pushed new migration files to `main` after your last fetch, those commits aren't on your machine. Rebase operates against cached `origin/main`, so new migration files never appear.

**Symptom:** Flyway fails on local stack startup — "migration files missing."

**Fix:** Always `git fetch origin` before `git rebase origin/main`.

## Related

- [[database-postgresql-aurora-guide]] — Flyway for schema updates and initial data
- [[database-migrations]] — migration best practices
