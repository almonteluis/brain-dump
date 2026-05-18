---
description: In-house SQL style guide with naming conventions, data types, and query formatting standards
tags: [source, sql, database, style-guide, conventions]
sources: ["SQL.md"]
created: 2026-04-09
updated: 2026-04-09
---

# SQL Style Guide

**Source:** `raw/00_inbox/work docs/SQL.md`
**Date ingested:** 2026-04-09
**Type:** Style guide

## Summary

In-house SQL preferences for building maintainable databases. Balances ANSI SQL standards with practical PostgreSQL usage.

## General Guidelines

### Keywords in ALL CAPS

```sql
SELECT student.username, student.first_name,
    section.code, section.staff_id,
    assignment.order
FROM students student
    JOIN student_sections ss ON ss.student_id = student.id
    JOIN sections section ON section.id = ss.section_id
    JOIN assignments assignment ON assignment.student_id = student.id
        AND assignment.code = section.code
WHERE NOT student.is_archived
    AND ss.is_archived
    AND section.name = 'Foo'
    AND (assignment.difficulty > 1 OR assignment.difficulty IS NULL);
```

### Naming: snake_case

- More portable than CamelCase
- Works better across contexts

### Indentation for Readability

No single "correct" style — be consistent with context.

### Avoid Keywords as Identifiers

Don't name columns `order`. Use `lesson_order` instead.

### Avoid Unnecessary Quotes

- No quotes for identifiers (unless keyword conflict)
- No square brackets (SQL Server only)
- Be careful with double-quotes in Postgres (affects capitalization)

### Parenthesize Only as Needed

Reader knows precedence of `AND` and `OR`. Use parentheses when they significantly improve readability.

### Meaningful Names, Not Abbreviations

- Use `student` not `s` (unless no ambiguity)
- Avoid `stud` — use full words
- For long table names, use initials like `ss` for student_sections

### Portable Code

Stick to ANSI SQL standard types and functions where possible. If impossible, consider whether logic belongs in application layer.

---

## Data Types

### Dates and Times

**Use `timestamptz`** for events at specific points in spacetime.

Important caveats:
- `timestamptz` does NOT store a timezone (stores UTC, displays in session TZ)
- Postgres server has default timezone (often UTC)
- Connection has its own timezone (`SET TIME ZONE...`)

### Numbers

- Use `SMALLINT` for small enumerations
- Use check constraints (e.g., book page_count > 0)

### Booleans

**Use `BOOLEAN`** — it's SQL standard. Don't use bits or integers.

### Strings

Postgres recommends `VARCHAR` (no length) or `TEXT` over `VARCHAR(n)`. Both function identically.

**Avoid `VARCHAR(255)` for everything** — it's the worst possible choice.

---

## Naming Conventions

### Tables

- Use **plural** when each row is a single entity (e.g., `skills`)
- Linking tables: `foo_bars` to link `foos` and `bars`
- Special cases: `student_skill_history` (named for entire table content, not individual rows)

### Columns

- Don't add column with same name as table (e.g., avoid `academics.book.book`)

### Views

- **Avoid if at all possible** — do logic in application
- **Never nest views**

### Stored Procedures

- **Don't use for any reason ever**
- If found, bring to team's attention for elimination

### Indexes

Format: `table_column1_column2_idx`

- Balance: not too few, not too many
- Be aware of Postgres 63-byte identifier limit

### Primary Keys

- Every table should have one
- Use ID surrogate key instead of compound keys

### Foreign Keys

Format: `maintable_column_referencedtable_column_fkey`

### Check Constraints and Defaults

Format: `table_column_checkdescription`

Add meaningful constraints supporting business logic.

### Triggers

Format: `table_column_triggertype`

Be really sure you need triggers vs application logic.

---

## Key Concepts

- [[sql-portability]] — ANSI standards
- [[postgres-specifics]] — timestamptz behavior
- [[naming-conventions]] — Consistent database object naming
- [[data-types]] — Choosing appropriate types
