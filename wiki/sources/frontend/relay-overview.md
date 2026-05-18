---
description: Relay GraphQL framework overview and core concepts
tags:
  - source
  - relay
  - graphql
  - overview
  - data/fetching
sources:
  - relay-main.md
created: 2026-04-09
updated: 2026-04-09
---

# Relay Overview

**Source:** raw/02_reference/relay/relay-main.md
**Date ingested:** 2026-04-09
**Type:** Documentation overview

## Summary

Relay is Meta's GraphQL client designed for scale — declarative data fetching, automatic optimizations, data consistency, and ahead-of-time safety through fragments and compile-time validation.

## Key Claims

- Relay designed for high performance at any scale
- Components declare data dependencies without worrying about fetching
- Compiler aggregates and optimizes data requirements
- Automatic updates when data changes
- Supports mutations with optimistic updates

## Core Principles

### Built for Scale
- Works with tens, hundreds, or thousands of components
- Incremental compiler keeps iteration speed fast

### Declarative Data Fetching
- Components declare dependencies
- Relay guarantees data is fetched and available
- Components stay decoupled and reusable

### Automatic Optimizations
- Aggregates data requirements
- Fetches efficiently in single GraphQL request
- Deduplicates identical fields

### Data Consistency
- Automatic updates when data changes
- Only re-renders affected components
- Supports optimistic updates

## Key Features

### Fragments
Reusable selections of fields tied to GraphQL types.

### Connections
Model for paginated lists with first-class Relay support.

### Global Object Identification
Globally unique IDs for reliable caching and refetching.

### Mutations
Flexible mutations with automatic updates.

### Subscriptions
Real-time data updates via WebSocket connections.

### Ahead-of-Time Safety
- Compiler ensures consistency against schema
- Generates TypeScript/Flow types
- Optimizes runtime performance

## Adoption

- Used at Facebook/Meta scale (tens of thousands of components)
- Works with Create React App and Next.js
- Can adopt incrementally

## Entities Mentioned

- [[Meta]] — Facebook, Instagram, WhatsApp
- [[react-patterns]] — UI library
- [[GraphQL]] — Query language

## Concepts Covered

- [[relay]] — GraphQL client framework
- [[fragments]] — Reusable field selections
- [[connections]] — Paginated list model
- [[optimistic-updates]] — Immediate UI feedback
- [[ahead-of-time-compilation]] — Build-time optimization
