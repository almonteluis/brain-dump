---
description: REST API architecture constraints and data formats
tags: ["source", "rest", "api", "architecture", "http", "backend"]
sources: ["REST API Architecture.md"]
created: 2026-04-09
updated: 2026-04-09
---

# REST API Architecture

**Source:** raw/02_reference/software-engineer/Backend/APIs/REST API Architecture.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

REST API architecture defines constraints for creating scalable web services using standard HTTP methods and resource-based operations.

## Key Claims

- REST APIs use client-server independence with stateless communication
- Operations are resource-based with uniform interface
- Common data formats: JSON (most common), HTML, XML, Plain Text

## REST Constraints

1. Client-server independence
2. Stateless communication
3. Resource-based operations
4. Uniform interface

## Data Flow

```
Client → HTTP Request (GET/POST/PUT/DELETE) → Server
Server → JSON/XML/Text Response → Client
```

## Concepts Covered

- [[REST API]] — Representational State Transfer
- [[Client-Server]] — Architectural separation
- [[Stateless]] — No client state stored on server
- [[JSON]] — JavaScript Object Notation
- [[HTTP Methods]] — GET, POST, PUT, DELETE
