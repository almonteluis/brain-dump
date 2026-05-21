---
description: Sharing one running Docker container and database across git worktrees to skip rebuilds when switching branches
tags: [docker, git-worktrees, workflow, concept]
created: 2026-05-17
source: "[[Captain's log, 5-6-26.]]"
---

# Docker worktree workflow — share the container, skip the rebuild

You don't need to rebuild your Docker container for every git worktree. For short fixes across branches, any active worktree can connect to the same database that Docker spins up — just keep the container running and point your code at it.

The pattern: hard reset to main, update the env var and docker-compose.yml if needed, then `docker-compose down` / `docker-compose up`. Your worktrees share the database. The frontend container can stay off entirely — your local dev server in any worktree connects to the DB independently. This matters because rebuilding the Docker instance is the slowest part of switching contexts, and for most short fixes you don't need a fresh instance at all.

The gotcha: when someone else's changes land on main and pull in new GraphQL schema shifts, your local frontend might get stuck in a loop pulling from the dev instance. The fix is the same — hard reset, rebuild env, fresh `docker-compose up`. But you only need that dance when the schema actually changed, not every time you switch worktrees.

This is [[docker]] in practice but the real concept is *shared infrastructure across parallel workstreams* — the same idea behind [[git-rebase-hygiene]] where you keep your branches clean but don't recreate the environment from scratch each time.

## Related Concepts
- [[docker]]
- [[git-rebase-hygiene]]
- [[cross-platform-node-modules]]
