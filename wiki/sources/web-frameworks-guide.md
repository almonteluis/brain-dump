---
description: "Node.js web frameworks comparison and guide"
tags: [software-engineering, nodejs, frameworks, backend, mvc, rest]
sources: [Introduction to Web Frameworks.md]
created: 2026-04-09
updated: 2026-04-09
---

# Node.js Web Frameworks: MVC & REST Architectures

**Source:** raw/02_reference/software-engineer/frontend/Introduction to Web Frameworks.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Overview of Node.js web frameworks, comparing runtime vs frameworks, MVC and REST architectures, and framework selection guidance.

## Key Claims

- Node.js is a runtime; frameworks provide application structure
- MVC separates concerns: Model (data), View (UI), Controller (logic)
- REST APIs enable stateless, resource-based communication
- Framework selection depends on project complexity, team experience, performance needs, and security requirements

## Framework Comparison

| Framework | Best For | Key Features | Learning Curve |
|-----------|----------|--------------|----------------|
| **Express** | General-purpose web apps | Minimalist, routing & middleware | Low |
| **Koa** | Complex high-performance apps | Async/await, error handling | Medium |
| **Socket.io** | Real-time applications | WebSockets, bidirectional communication | Medium |
| **Hapi.js** | Secure APIs & proxies | Built-in security, official plugins | Medium |
| **NestJS** | Enterprise scalable apps | TypeScript, dependency injection, modular | High |

## Framework Selection Decision Tree

1. Real-time needed? → Socket.io
2. Enterprise scale? → NestJS
3. Maximum security? → Hapi.js
4. Modern syntax preferred? → Koa
5. Default/General purpose → Express

## Key Takeaways

- Express is the bedrock of Node.js web development
- NestJS represents enterprise evolution
- Koa eliminates callback hell with async/await
- Hapi.js provides built-in security features
- Socket.io enables real-time bidirectional communication

## Concepts Covered

- [[nodejs]]
- [[express]]
- [[nestjs]]
- [[mvc-architecture]]
- [[rest-api]]
