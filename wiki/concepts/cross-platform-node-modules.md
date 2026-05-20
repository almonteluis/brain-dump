---
description: Never share node_modules between a host OS and a container OS — platform-specific binaries break cross-platform file operations
tags: [docker, node, frontend, concept]
created: 2026-05-17
source_capture: "[[Docker FE esbuild.exe error]]"
---

# Cross-platform node_modules — never share between host and container

Mounting your frontend directory into a Linux container is convenient until the mount drags `node_modules/` along with it. Binaries inside it — like `esbuild.exe` — are compiled for the *host* platform. When the container's entrypoint runs `npm ci`, it tries to `unlink` a Windows binary from inside Linux, Docker Desktop's file-sharing layer chokes on the cross-platform unlink, and you get an I/O error.

The cause is a `docker-compose.yml` volume mount that pulls the *entire* frontend directory — `node_modules` included — into a container running a different OS than the host. The Windows-x64 `esbuild.exe` is meaningless to a Linux container, and the cross-platform file operation fails before the build even starts.

The fix: keep `node_modules` out of the container mount via `.dockerignore` or a volume mount override. Let the container run its own `npm ci` and build its own platform-correct binaries. The rule generalizes well beyond esbuild — never share `node_modules` between a host OS and a container OS, because each platform needs its own install.

## Related Concepts
- [[docker]]
- [[docker-worktree-workflow]]
