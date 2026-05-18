---
description: Docker best practices for Dockerfile design, multi-stage builds, caching, and container security
tags: [docker, containers, devops, security, caching]
sources: [Docker.md]
created: 2026-04-30
updated: 2026-04-30
---

# Docker Best Practices

**Source:** Docker.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Dockerfile guidelines and best practices covering single-concern containers, multi-stage builds, layer caching optimization, and security hardening. Includes specific recommendations on COPY vs ADD, ENV vs ARG, and apt-get cache management.

## Key Claims

- Each container should have only one concern
- Use multi-stage builds; only copy needed artifacts into final image
- Order Dockerfile instructions by change frequency (least frequent first)
- Sort multi-line arguments alphanumerically
- Create non-root users in containers
- Use COPY unless URL fetching is needed; avoid EXPOSE
- Use ARG for build-time variables; ENV only for persistent runtime variables
- Combine `RUN apt-get update` with `apt-get install` in same RUN statement (cache busting)
- Docker cache invalidates on checksum changes for COPY/ADD, command string for RUN
- Once cache is invalidated, all subsequent commands generate new images

## Dockerfile Instruction Notes

| Instruction | Behavior |
|-------------|----------|
| **COPY** | Copies files/directories from build context |
| **ADD** | Can also copy from remote URLs |
| **ENV** | Persists in final image; available to runtime |
| **ARG** | Build-time only; does not persist in final image |
| **EXPOSE** | Documentation only; does not publish ports |
| **CMD** | Preferred form: `["executable", "param1", "param2"]` |
| **ENTRYPOINT** | Configures container as executable |

## Security Notes

- Do not use build-time variables (ARG) for secrets — visible via `docker history`
- Use BuildKit secrets for secure secret handling during build
- Create non-root user for running applications

## Entities Mentioned

- [[Docker]] — containerization platform
- [[BuildKit]] — advanced Docker build system
- [[Docker Compose]] — multi-container orchestration

## Concepts Covered

- [[docker-layer-caching]] — how Docker leverages cache per instruction type
- [[multi-stage-builds]] — separating build and runtime artifacts
- [[container-security]] — non-root users, secret handling
- [[dockerfile-optimization]] — ordering, cache busting, argument sorting
