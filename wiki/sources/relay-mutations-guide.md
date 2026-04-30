---
description: "Relay mutations with optimistic updates and store management"
tags: ["source", "relay", "graphql", "mutations", "optimistic-updates"]
sources: ["relay-mutations-guide.md"]
created: 2026-04-08
updated: 2026-04-08
---

# Relay Mutations Guide

**Source:** raw/02_reference/approaches/relay-mutations-guide.md
**Date ingested:** 2026-04-08
**Type:** Technical guide

## Summary

Complete guide to GraphQL mutations in Relay covering mutation structure, `useMutation` hook, optimistic updates, connection manipulation via declarative directives, and imperative store updaters.

## Key Claims

- Mutations are read-write operations that modify backend data and query results in same request
- `useMutation` returns tuple: `[commitMutation, isMutationInFlight]`
- Fragment spreading in mutations is recommended over manual field selection
- Declarative directives (`@appendNode`, `@prependNode`, `@deleteRecord`) handle connection updates automatically
- Optimistic updates require careful handling — use `optimisticUpdater` when values depend on store

## Entities Mentioned

- [[relay]] — GraphQL client framework
- [[react-patterns]] — UI component library

## Concepts Covered

- [[useMutation]] — Hook for executing mutations
- [[optimistic-updates]] — Immediate UI feedback before server response
- [[declarative-directives]] — `@appendNode`, `@prependNode`, `@deleteRecord`, `@prependEdge`
- [[store-updaters]] — Imperative cache manipulation
- [[connection-handling]] — Managing list data in Relay

## Declarative Directives

| Directive | Purpose |
|-----------|---------|
| `@appendNode` | Add to end of connection |
| `@prependNode` | Add to front of connection |
| `@deleteRecord` | Remove item from store |
| `@prependEdge` | Add edge with cursor |

## Execution Order

1. Optimistic response (if provided)
2. Optimistic updater (if provided)
3. Declarative directives on optimistic data
4. Mutation succeeds → roll back optimistic, write server response
5. Updater with server payload
6. Declarative directives on server data
7. `onCompleted` callback
