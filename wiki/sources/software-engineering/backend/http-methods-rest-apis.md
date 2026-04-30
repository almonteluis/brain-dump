---
description: HTTP methods and REST API guidelines including status codes, URL formats, and best practices
tags: ["source", "http", "rest", "api", "methods", "status-codes"]
sources: ["HTTP Methods and REST APIs.md"]
created: 2026-04-09
updated: 2026-04-09
---

# HTTP Methods and REST APIs

**Source:** raw/02_reference/software-engineer/Backend/APIs/HTTP Methods and REST APIs.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Comprehensive guide to HTTP methods and REST API guidelines including status codes, URL formatting, and RESTful principles.

## Key Claims

- REST is a set of architectural guidelines for client-server communication
- HTTP methods (GET, POST, PUT, DELETE, PATCH) define resource operations
- PUT and DELETE are idempotent (multiple calls have same effect)
- URLs should use nouns, lowercase, hyphens, and no trailing slashes

## HTTP Methods

| Method | Purpose | Idempotent |
|--------|---------|------------|
| GET | Retrieve resource | Yes |
| POST | Create resource | No |
| PUT | Update/replace resource | Yes |
| DELETE | Remove resource | Yes |
| PATCH | Partial modification | No |

## Status Code Ranges

| Range | Meaning |
|-------|---------|
| 200-299 | Success |
| 300-399 | Redirect |
| 400-499 | Client error |
| 500-599 | Server error |

## URL Format Guidelines

- Use hyphens not camelCase: `/my-resource` not `/myResource`
- Use lowercase
- No trailing slashes
- No underscores
- Use nouns not verbs

## REST Requirements

1. Client-server architecture
2. Stateless communication
3. Cacheable responses
4. Uniform interface
5. Layered system

## Concepts Covered

- [[HTTP Methods]] — GET, POST, PUT, DELETE, PATCH
- [[RESTful APIs]] — Architectural guidelines
- [[Status Codes]] — HTTP response codes
- [[Idempotent]] — Same result on multiple calls
- [[Stateless]] — No client state on server
