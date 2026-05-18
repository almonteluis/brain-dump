---
description: Platform for developing, shipping, and running applications in containers
tags: [docker, containers, devops, virtualization, concept]
created: 2026-04-30
updated: 2026-05-05
---

# Docker

Platform for developing, shipping, and running applications in containers. Containers package code with all its dependencies so applications run consistently across environments.

## Key Characteristics

- Container-based virtualization (shares host OS kernel)
- Dockerfile defines build instructions
- Image layers enable efficient caching and reuse
- Docker Compose for multi-container orchestration
- Docker Hub for image distribution

## Best Practices

- One concern per container
- Multi-stage builds to minimize final image size
- Order instructions by change frequency
- Use non-root users
- Combine apt-get update and install in same RUN

## Cross-Platform Pitfall: node_modules in Volume Mounts

From [[docker-fe-esbuild-exe-error]] — mounting host `node_modules` into Linux container from Windows host causes `npm ci` to fail.

**Problem:** Windows `node_modules` contains `.exe` binaries (e.g., `esbuild.exe`). Linux container's `npm ci` tries to `unlink` these — Docker Desktop file sharing chokes.

**Fix:** Exclude `node_modules` from volume mount. Run `npm ci` inside container to install Linux-native binaries.

```yaml
# docker-compose.yml
volumes:
  - .:/app
  - /app/node_modules  # anonymous volume shadows host node_modules
```

Or use `.dockerignore` + build-time install.

## Related

- [[docker-best-practices]] — detailed guidelines
- [[docker-fe-esbuild-exe-error]] — Full root cause analysis
- [[Docker Compose]] — multi-container orchestration
- [[BuildKit]] — advanced build engine
