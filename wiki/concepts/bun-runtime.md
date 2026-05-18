---
description: All-in-one JavaScript/TypeScript runtime built in Zig with package manager, bundler, test runner, and transpiler
tags:
  - package-manager/bun
  - javascript-runtime
  - zig
  - package-manager
  - bundler
  - testing
sources:
  - bun-v1-3-12
  - package-manager-comparison
created: 2026-04-29
updated: 2026-04-29
---

# Bun Runtime

Bun is what happens when someone asks "why do I need four separate tools to run JavaScript?" and builds the answer in Zig. Runtime, package manager, bundler, test runner, transpiler — one binary, no config. Jarred Sumner's bet that the Node.js ecosystem's tool sprawl is unnecessary, and the benchmarks back him up: `bun install` is 18x faster than npm.

Anthropic runs Claude Code on Bun. That's a pretty strong signal.

## What It Does

- **Runtime** — runs TypeScript and JSX natively, no transpilation step
- **Package manager** — `bun install`, binary lockfile (or text `bun.lock`)
- **Bundler** — `bun build` with CSS and HTML support
- **Test runner** — Jest-compatible API, built-in mocking
- **Transpiler** — TypeScript, JSX, TSX out of the box

## Notable Features (v1.3.12+)

- **Bun.WebView** — headless browser automation with WebKit or Chrome backends, OS-level input dispatch, Playwright-style waits
- **In-process cron** — `Bun.cron(schedule, callback)`, no overlap, UTC-aware
- **Performance** — URLPattern 2.3x faster, glob scanning 2x faster, nginx-style TCP_DEFER_ACCEPT

## When to Use vs. Avoid

Use it for new projects, CI pipelines, TypeScript-first codebases. Avoid it for legacy Node.js projects with exotic API dependencies, or if your team needs guaranteed 100% Node compat (~98% API compatible, ~99% npm compatible). The ecosystem isn't caught up yet, but it's close.

## Related

- [[bun-v1-3-12]] — Latest release details
- [[package-manager-comparison]] — How Bun compares to npm/yarn/pnpm
- [[fastest-frontend-tooling]] — Bun in modern frontend stacks
- [[claude-code-source-leak]] — Anthropic uses Bun for Claude Code
