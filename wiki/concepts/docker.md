---
description: Platform for developing, shipping, and running applications in containers
tags: [docker, containers, devops, virtualization, concept]
created: 2026-04-30
updated: 2026-04-30
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

## Related

- [[docker-best-practices]] — detailed guidelines
- [[Docker Compose]] — multi-container orchestration
- [[BuildKit]] — advanced build engine
