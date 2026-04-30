---
description: Model-View-Controller architecture pattern for separating concerns in applications
tags: ["source", "mvc", "architecture", "patterns", "backend", "design"]
sources: ["MVC Architecture.md"]
created: 2026-04-09
updated: 2026-04-09
---

# MVC Architecture

**Source:** raw/02_reference/software-engineer/Architecture/MVC Architecture.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

MVC (Model-View-Controller) is an architectural pattern that separates an application into three main logical components: Model, View, and Controller.

## Components

| Component | Responsibility |
|-----------|---------------|
| **Model** | Manages data, business logic, and database interactions |
| **View** | Handles data presentation (UI) |
| **Controller** | Processes user input and coordinates Model/View |

## Flow

```
User → Controller → Model → Database
              ↓
           View → User
```

## Frameworks

- **Express** — Node.js web framework
- **Koa** — Next-generation Node.js framework
- **Django** — Python web framework
- **NestJS** — Progressive Node.js framework

## Concepts Covered

- [[MVC]] — Model-View-Controller pattern
- [[Model]] — Data and business logic layer
- [[View]] — Presentation layer
- [[Controller]] — Input handling and coordination
- [[Separation of Concerns]] — Architectural principle
