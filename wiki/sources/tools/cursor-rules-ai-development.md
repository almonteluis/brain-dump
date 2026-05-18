---
description: Matt Pocock's TypeScript cursor rules for AI-assisted development covering language features, documentation, and code structure
tags:
  - typescript
  - cursor
  - ai/development
  - tooling
sources:
  - Cursor Rules for Better AI Development.md
created: 2026-04-16
updated: 2026-04-16
---

# Cursor Rules for Better AI Development

**Source:** [[Cursor Rules for Better AI Development]]
**Author:** [[Matt Pocock]] (TotalTypeScript)
**Date ingested:** 2026-04-16
**Type:** article

## Summary

Matt Pocock shares his TypeScript-specific `.cursor/rules` after finding community alternatives low-quality and underwritten. The rules are framework-agnostic, focused purely on TypeScript language best practices. He distinguishes between workspace rules (checked into Git, project-specific) and global rules (personal IDE preferences, not versioned). The goal is to establish community consensus on what makes a good cursor rule.

## Key Claims

- Community cursor rule directories are low-quality, underwritten, and lack code examples
- Good rules separate workspace rules (project structure, package versions, framework advice) from global rules (personal style, workflow commands)
- TypeScript-specific rules should cover: `as const` over enums, `import type` over `import { type }`, `readonly` properties, JSDoc documentation, `Result` over `try/catch`, discriminated unions, explicit return types on top-level functions
- AI assistants benefit from explicit return type declarations on module-level functions (except JSX components)

## Concepts Covered

- [[cursor-rules]] — Workspace vs global rules for AI-assisted coding
- [[typescript-best-practices]] — Language-level patterns: `as const`, `readonly`, `import type`, discriminated unions
- [[ai-coding-conventions]] — Structured instructions for AI code generation
- [[jsdoc]] — Using JSDoc comments to improve AI-generated code quality
- [[result-pattern]] — Preferring `Result` types over `try/catch` for error handling

## Resources

- Original: https://www.totaltypescript.com/cursor-rules-for-better-ai-development
- Downloadable rules: https://res.cloudinary.com/total-typescript/raw/upload/v1745426569/articles/cursor-rules-for-better-ai-development/cursor-rules.zip
