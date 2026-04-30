---
description: Angular and TypeScript coding standards and conventions for component design, styling, and testing
tags: [angular, typescript, coding-standards, frontend, testing]
sources: [AngularTypeScript.md]
created: 2026-04-30
updated: 2026-04-30
---

# Angular & TypeScript Coding Standards

**Source:** AngularTypeScript.md
**Date ingested:** 2026-04-30
**Type:** guide

## Summary

Internal coding standards for Angular applications using TypeScript. Covers component generation via Angular CLI, styling conventions using Stylus, TypeScript best practices, component design principles, and unit testing expectations.

## Key Claims

- All components, services, etc. should be generated using the Angular CLI
- Use `ViewEncapsulation.None` only when necessary; prefer it over `!important` or `::ng-deep`
- Bootstrap is only included for NgBootstrap components; do not use Bootstrap classes directly
- Stylesheets use Stylus (indents/spaces, no colons/semicolons/braces)
- Prefer element and class selectors over ID selectors; class names in kebab-case
- Avoid inline templates and inline styles when creating components
- No weak (single) equals; use `!foo` for falsey and `!!foo` for truthy checks
- Take full advantage of TypeScript strong typing; avoid using `any`
- Keep components stateless when possible; use data binding for inter-component communication
- Aim for 90%+ unit test coverage; mock all dependencies unless there is a good reason not to

## Entities Mentioned

- [[Angular]] — frontend framework
- [[TypeScript]] — typed superset of JavaScript
- [[Angular CLI]] — code generation tool
- [[NgBootstrap]] — Bootstrap components for Angular
- [[Stylus]] — CSS preprocessor
- [[Prettier]] — code formatter

## Concepts Covered

- [[angular-component-design]] — stateless components, data binding, avoiding inline styles/templates
- [[angular-styling-conventions]] — Stylus usage, kebab-case, ViewEncapsulation
- [[typescript-strong-typing]] — avoiding `any`, using types and interfaces
- [[unit-test-coverage]] — 90%+ target, mocking dependencies
