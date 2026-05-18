---
description: Full DOOM game rendered entirely in CSS without Canvas or WebGL using 3D transforms and math functions
tags:
  - css
  - doom
  - browser/capabilities
  - 3d
sources:
  - CSS is DOOMed!.md
created: 2026-04-29
updated: 2026-04-29
---

# CSS is DOOMed!

**Source:** [[CSS is DOOMed!]]
**Date ingested:** 2026-04-29
**Type:** article

## Summary

Full DOOM (1993) game rendered entirely in CSS — no Canvas, no WebGL. Every wall, floor, barrel, and enemy is a `<div>`. Built by [[Niels Leenheer]] to push CSS boundaries. Game logic in JavaScript, rendering entirely CSS-driven.

## Key Claims

1. CSS 3D transforms + math functions (`hypot()`, `atan2()`) can compute wall geometry from raw DOOM WAD data in the browser's CSS engine.
2. `@property` enables animating custom properties (smooth falling, door lifts, flickering lights).
3. `clip-path` with `polygon()` and `path()` + `evenodd` handles irregular DOOM sectors and holes.
4. Anchor positioning anchors HUD elements (weapon to status bar) responsively.
5. Browser compositors are not optimized for 3D scenes — culling must be done manually. Experimental pure-CSS culling uses "type grinding" (paused animation with negative delay).
6. CSS `random()` (when shipped) will replace JavaScript for enemy animation-delay randomization.

## Entities Mentioned

- [[Niels Leenheer]] — Author, built cssDOOM
- [[Keith Clark]] — Prior CSS FPS demo (2013)
- [[Lyra Rebane]] — Built x86 CPU in CSS

## Concepts Covered

- [[css-3d-transforms]] — `translate3d`, `rotateX/Y`, perspective
- [[css-math-functions]] — `hypot()`, `atan2()`, `sin()`, `cos()`
- [[css-custom-properties]] — `@property` for typed animatable custom properties
- [[css-clip-path]] — `polygon()`, `path()`, `shape()`, `evenodd`
- [[css-anchor-positioning]] — `anchor-name`, `position-anchor`
- [[browser-compositor]] — Performance bottleneck for 3D CSS scenes