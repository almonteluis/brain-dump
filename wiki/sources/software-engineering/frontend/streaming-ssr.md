---
description: Streaming Server-Side Rendering with React 18+ and Suspense
tags: ["source", "react", "ssr", "streaming", "performance", "suspense"]
sources: ["Streaming SSR.md"]
created: 2026-04-09
updated: 2026-04-09
---

# Streaming SSR

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Streaming SSR.md
**Date ingested:** 2026-04-09
**Type:** technical guide

## Summary

Streaming Server-Side Rendering (Streaming SSR) is a technique in React that allows progressive rendering and sending HTML from server to client, enabling faster initial page loads and improved user experience through gradual content delivery.

## Key Claims

- Progressive HTML streaming improves Time to First Byte (TTFB) by 30-50%
- Works with Suspense boundaries for selective hydration
- Improves First Contentful Paint (FCP) by ~40% and Time to Interactive (TTI) by ~25%
- Uses `renderToPipeableStream` from React 18+
- SEO-friendly while providing better performance

## Key Implementation Points

1. Use `renderToPipeableStream` instead of `renderToString`
2. Structure Suspense boundaries strategically
3. Handle errors with `onError` callback
4. Implement proper loading states
5. Consider hydration order

## Concepts Covered

- [[streaming-ssr]] — Progressive server-side rendering
- [[Suspense]] — React component for loading states
- [[Selective Hydration]] — Hydrating components as they load
- [[TTFB]] — Time to First Byte metric
- [[FCP]] — First Contentful Paint
- [[TTI]] — Time to Interactive
