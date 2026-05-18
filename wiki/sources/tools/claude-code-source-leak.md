---
description: Analysis of the accidentally leaked Claude Code source code covering anti-distillation, KAIROS mode, and client attestation
tags:
  - claude/code
  - claude
  - security
  - source-leak
  - ai/tools
sources:
  - The Claude Code Source Leak fake tools, frustration regexes, undercover mode, and more.md
created: 2026-04-29
updated: 2026-04-29
---

# Claude Code Source Leak

**Source:** [[The Claude Code Source Leak fake tools, frustration regexes, undercover mode, and more]]
**Date ingested:** 2026-04-29
**Type:** security analysis

## Summary

Analysis of the accidentally leaked Claude Code source code (shipped via source map in npm package). Covers anti-distillation measures, frustration detection, native client attestation, KAIROS autonomous mode, and architectural details.

## Key Claims

1. **Anti-distillation**: `ANTI_DISTILLATION_CC` flag injects fake tools into API requests. Server-side connector-text summarization with cryptographic signatures. Both easily bypassed by determined actors.
2. **Undercover mode**: Strips Anthropic codenames ("Capybara", "Tengu") from model output in external repos. No force-OFF option. AI-authored commits have no AI indication.
3. **Frustration detection**: Regex matching swear words and frustration phrases (`wtf`, `fucking broken`, `this sucks`). Faster than LLM inference for sentiment check.
4. **Native client attestation**: Bun's Zig HTTP stack computes hash replacing `cch=00000` placeholder. DRM for API calls at transport level. Gated behind compile-time flag, bypassable.
5. **KAIROS**: Unreleased autonomous agent mode. Includes `/dream` skill (nightly memory distillation), GitHub webhooks, background daemon, 5-minute cron refresh.
6. **250K wasted API calls/day**: Fixed with `MAX_CONSECUTIVE_AUTOCOMPACT_FAILURES = 3`.
7. **Source map leak**: Likely caused by Bun bug (#28001) — source maps served in production mode.

## Entities Mentioned

- [[Alex Kim]] — Author who analyzed leak
- [[Anthropic]] — Claude Code developer
- [[Bun]] — Runtime Claude Code is built on
- [[Chaofan Shou]] — Discovered source map leak
- [[OpenCode]] — Third-party tool Anthropic sent legal threats to

## Concepts Covered

- [[anti-distillation]] — Poisoning training data for competitors
- [[client-attestation]] — Cryptographic proof of genuine client
- [[frustration-detection]] — Regex-based user sentiment detection
- [[kairos-mode]] — Unreleased autonomous agent feature
- [[source-map-security]] — Risks of shipping source maps