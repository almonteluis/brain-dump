---
description: Node.js fundamentals including runtime environment, module system, Express.js framework, and asynchronous patterns
tags: ["source", "nodejs", "javascript", "backend", "express", "async"]
sources: ["Node.js.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Node.js Fundamentals

**Source:** raw/02_reference/software-engineer/Backend/Node.js/Node.js.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Node.js is a JavaScript runtime environment for building scalable backend applications with event-driven, non-blocking I/O.

## Key Claims

- Node.js enables full-stack JavaScript with unified language for frontend/backend
- Event loop architecture handles thousands of concurrent connections
- Module system supports CommonJS and ES Modules
- Express.js is the most popular web framework

## Core Concepts

| Term | Definition |
|------|------------|
| Runtime Environment | Infrastructure supporting code execution |
| Event-Driven | Program flow determined by events |
| Asynchronous | Processes run independently without blocking |
| Non-Blocking | Task failures don't affect others |
| Single-Threaded | One command at a time with async I/O |

## Module Systems

```javascript
// CommonJS
const http = require('http');
module.exports = createServer;

// ES Modules
import http from 'http';
export default createServer;
```

## Core Modules

| Module | Use Case |
|--------|----------|
| `http` | HTTP servers and clients |
| `fs` | File system operations |
| `path` | Path manipulation |
| `os` | OS information |

## Best Practices

1. Modularize code into focused modules
2. Use middleware for centralized error handling
3. Prefer async/await over callbacks
4. Implement security (helmet, CORS, rate limiting)
5. Use environment variables for configuration

## Concepts Covered

- [[Node.js]] — JavaScript runtime
- [[Express.js]] — Web framework
- [[Event Loop]] — Concurrency model
- [[CommonJS]] — Module system
- [[ES Modules]] — Modern module system
- [[Middleware]] — Request/response processing
