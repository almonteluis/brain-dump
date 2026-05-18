---
tags: [work, docker, frontend, esbuild, cross-platform]
sources: ["Docker FE esbuild.exe error.md"]
created: 2026-05-04
updated: 2026-05-04
---

# Docker FE esbuild.exe Error

**Source:** Docker FE esbuild.exe error.md
**Date ingested:** 2026-05-05
**Type:** Technical note / root cause

## Summary

Root cause analysis of a Docker build failure where `npm ci` fails with an I/O error trying to unlink `esbuild.exe`. The issue is cross-platform `node_modules` being mounted into a Linux container from a Windows host.

## Key Claims

- `docker-compose.yml` mounts entire frontend directory into Linux container.
- Windows `node_modules` contains `esbuild.exe` (Windows x64 binary).
- Entrypoint script runs `npm ci` (clean install), which tries to `unlink` the `.exe`.
- Docker Desktop's file sharing layer chokes on Windows→Linux `unlink` of `.exe`.
- Classic Docker-on-Windows pitfall: host `node_modules` leaking into container.

## Fix Direction

- Exclude `node_modules` from volume mount, or use `.dockerignore`.
- Run `npm ci` inside container on Linux-native `node_modules`.

## Concepts Covered

- [[docker]] — volume mounts, cross-platform pitfalls
- [[esbuild]] — platform-specific binaries
- [[docker-compose]] — mount configuration

## Related

- [[work-status-may-5-2026]] — references this error
