---
tags: [claude-code, ai-tools, architecture, clippings]
sources: ["How Claude Code is built.md"]
created: 2026-04-29
updated: 2026-04-29
---

# How Claude Code is Built

**Source:** How Claude Code is built.md
**Date ingested:** 2026-04-29
**Type:** Architecture deep-dive

## Summary

Pragmatic Engineer deep-dive into Claude Code's development at Anthropic. Covers origin story, tech stack, shipping velocity, terminal UX innovations, and what "AI-first" engineering looks like.

## Key Claims

- **Origin:** Boris Cherny's prototype started as AppleScript music controller. Gave it filesystem access → "product overhang" — model could already do this, no product captured it
- **Dogfooding:** 20% of engineering team day 1, 50% by day 5. 80%+ of Anthropic engineers now use it daily
- **Tech stack:** TypeScript + React + Ink + Yoga + Bun. Chosen to be "on distribution" for Claude model
- **~90% of code written by Claude Code itself**
- **Shipping velocity:** ~60-100 internal releases/day, ~5 PRs/engineer/day, 1 external release/day
- **67% increase in PR throughput** as engineering team doubled

### Architecture Philosophy

- Minimal business logic. Let model do the work. Delete code with each new model release
- "We want people to feel the model as raw as possible"
- Runs locally (no virtualization) — simplest possible option
- Permissions system is most complex part: multi-tiered (project/user/company), static analysis on commands

### Prototyping Culture

- Boris prototyped todo lists ~20 times in 2 days using AI agents
- Prompt → tweak → share for feedback → new prompt if off
- Final design: todo list in spinner UI, toggle with Ctrl+T

### AI-First Engineering Practices

- AI agents for code review and tests
- TDD renaissance
- Automating incident response
- Cautious use of feature flags
- Subagents built in 3 days (2 days' work thrown away)

## Entities Mentioned

- [[boris-cherny|Boris Cherny]] — Claude Code founding engineer
- [[sid-bidasaria|Sid Bidasaria]] — Engineer #2, subagents creator
- [[cat-wu|Cat Wu]] — Founding product manager
- [[gergely-orosz|Gergely Orosz]] — Author, The Pragmatic Engineer

## Concepts Covered

- [[claude-code-architecture]] — TypeScript/React/Ink/Yoga/Bun stack
- [[ai-first-engineering]] — Using AI agents for reviews, tests, incident response
- [[product-overhang]] — Model capability exists but product doesn't capture it
- [[on-distribution-stack]] — Tech stack model is already good at
- [[rapid-prototyping]] — 20 prototypes in 2 days with AI agents
