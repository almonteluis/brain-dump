---
description: All-in-one JavaScript/TypeScript runtime built in Zig with package manager, bundler, test runner, and transpiler
tags: [bun, javascript-runtime, zig, package-manager, bundler, testing]
sources: ["bun-v1-3-12", "package-manager-comparison"]
created: 2026-04-29
updated: 2026-04-29
---

# Bun Runtime

All-in-one JavaScript/TypeScript runtime built in Zig by Jarred Sumner. Includes package manager, bundler, test runner, and transpiler. Designed for speed.

## Core Components

- **Runtime** — Native TypeScript/JSX execution without transpilation
- **Package Manager** — `bun install`, 18x faster than npm
- **Bundler** — `bun build`, includes CSS and HTML bundling
- **Test Runner** — Jest-compatible, built-in mocking
- **Transpiler** — TypeScript, JSX, TSX out of the box

## Key Features

### Bun.WebView (v1.3.12)
Headless browser automation built into runtime:
- WebKit (macOS default) and Chrome backends
- OS-level input dispatch (`isTrusted: true`)
- Playwright-style actionability waiting
- CDP access on Chrome backend

### In-Process Cron
- `Bun.cron(schedule, callback)` — callback-based scheduler
- No overlap, UTC scheduling, `--hot` safe
- Complements OS-level persistent crons

### Performance
- URLPattern 2.3x faster (direct regex engine calls)
- Bun.Glob.scan 2x faster (deduplicated directory reads)
- cgroup-aware parallelism on Linux
- TCP_DEFER_ACCEPT for Bun.serve() (nginx-style optimization)

## Compatibility

- ~99% npm compatible
- ~98% Node.js API compatible
- Used in production by Anthropic (Claude Code)
- Binary lockfile (`bun.lockb`) not human-readable; text `bun.lock` available

## When to Use

- New projects where speed matters
- CI/CD pipelines (dramatic time savings)
- TypeScript-first codebases
- Teams wanting unified runtime + package manager + bundler

## When to Avoid

- Legacy projects with specific Node.js API dependencies
- Environments requiring guaranteed 100% Node compatibility
- Teams not ready to adopt new runtime

## Related

- [[bun-v1-3-12]] — Latest release details
- [[package-manager-comparison]] — How Bun compares to npm/yarn/pnpm
- [[fastest-frontend-tooling]] — Bun in modern frontend stacks
- [[claude-code-source-leak]] — Anthropic uses Bun for Claude Code