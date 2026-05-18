---
description: Cross-language coding standards hub — ECC language patterns for TypeScript, Go, Kotlin, Python, PHP, Swift
tags:
  - code/standards
  - reference
  - ecc
  - multi-language
sources:
  - raw/02_reference/ecc-language-patterns-archived/
created: 2026-04-15
updated: 2026-04-15
---

# ECC Coding Standards (Multi-Language)

**Source:** `raw/02_reference/ecc-language-patterns-archived/` (40 files)
**Date ingested:** 2026-04-15
**Type:** Language-specific coding rule sets (CLAUDE.md-style)

## Overview

A collection of coding standards and patterns for AI-assisted development, organized by language. Each language has 5 rule files covering core development concerns. These function as `.cursorrules` or `AGENTS.md` equivalents — providing language-specific guidance for AI coding agents.

## Languages Covered (8 categories)

### Common (Language-Agnostic)
Rules that apply across all languages.

| File | Topic |
|------|-------|
| `common-patterns.md` | Repository pattern, API response format, skeleton projects |
| `common-coding-style.md` | Naming conventions, code organization, DRY principles |
| `common-development-workflow.md` | Git workflow, code review process, CI/CD |
| `common-testing.md` | Test pyramid, TDD practices, mocking strategies |
| `common-security.md` | OWASP top 10, input validation, authentication patterns |
| `common-hooks.md` | Pre/post-commit hooks, linting rules |
| `common-performance.md` | Caching, optimization strategies, profiling |

### TypeScript
| File | Topic |
|------|-------|
| `typescript-patterns.md` | Type design, generics, discriminated unions |
| `typescript-coding-style.md` | ESLint config, import organization, module patterns |
| `typescript-testing.md` | Vitest/Jest patterns, mocking, coverage |
| `typescript-security.md` | XSS prevention, dependency auditing, CSP |
| `typescript-hooks.md` | Pre-commit hooks, Husky config |

### Go
| File | Topic |
|------|-------|
| `golang-patterns.md` | Error handling, interfaces, goroutines |
| `golang-coding-style.md` | gofmt, naming conventions, package layout |
| `golang-testing.md` | Table-driven tests, testify, mocks |
| `golang-security.md` | SQL injection, input sanitization |
| `golang-hooks.md` | Pre-commit, golangci-lint |

### Kotlin
| File | Topic |
|------|-------|
| `kotlin-patterns.md` | Coroutines, sealed classes, extension functions |
| `kotlin-coding-style.md` | Ktlint, coding conventions |
| `kotlin-testing.md` | JUnit5, MockK, coroutine testing |
| `kotlin-security.md` | Input validation, dependency management |
| `kotlin-hooks.md` | Detekt, pre-commit config |

### Python
| File | Topic |
|------|-------|
| `python-patterns.md` | Type hints, dataclasses, async patterns |
| `python-coding-style.md` | PEP 8, Black formatter, import sorting |
| `python-testing.md` | pytest, fixtures, parameterized tests |
| `python-security.md` | Bandit, dependency scanning |
| `python-hooks.md` | Pre-commit, Ruff, mypy |

### PHP
| File | Topic |
|------|-------|
| `php-patterns.md` | PSR standards, design patterns |
| `php-coding-style.md` | PHP-CS-Fixer, Laravel conventions |
| `php-testing.md` | PHPUnit, Pest, feature tests |
| `php-security.md` | SQL injection, CSRF, XSS prevention |
| `php-hooks.php` | Pre-commit, static analysis |

### Swift
| File | Topic |
|------|-------|
| `swift-patterns.md` | Protocol-oriented, value types, async/await |
| `swift-coding-style.md` | SwiftLint, naming conventions |
| `swift-testing.md` | XCTest, Swift Testing framework |
| `swift-security.md` | Keychain, secure storage |
| `swift-hooks.md` | Pre-commit, SwiftFormat |

## Common Patterns Across Languages

From `common-patterns.md`:

### Repository Pattern
Encapsulate data access behind a consistent interface — standard operations (findAll, findById, create, update, delete) with concrete implementations handling storage details.

### API Response Format
Consistent envelope: success indicator + data payload + error message + metadata for pagination.

### Skeleton Projects
Search for battle-tested skeletons before implementing from scratch. Use parallel agents to evaluate security, extensibility, and relevance.

## Usage

These files are archived reference materials. To use with a specific language:
1. Copy relevant files to project root as `AGENTS.md` or `.cursorrules`
2. Customize for project-specific conventions
3. Add to project's `CLAUDE.md` references

## Related

- [[writing-good-claude-md]] — How to write effective project instruction files
- [[context-engineering]] — Designing context windows for AI agents
