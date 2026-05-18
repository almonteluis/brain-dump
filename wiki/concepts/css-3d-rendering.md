---
description: CSS 3D Rendering — building 3D scenes with CSS transforms, math functions, and custom properties. No Canvas, no WebGL. cssDOOM proved it's possible. Performance is the limiting factor.
tags:
  - css
  - 3d
  - rendering
  - transforms
  - browser/capabilities
sources:
  - css-is-doomed
created: 2026-04-29
updated: 2026-05-17
---

# CSS 3D Rendering

You can render 3D scenes using nothing but CSS transforms and math functions. No Canvas, no WebGL, no JavaScript graphics library — just `<div>` elements positioned in 3D space. cssDOOM proved it by building a playable DOOM clone where every wall, door, and enemy is a styled `<div>`. It's technically impressive. It's also a performance cautionary tale.

## The Toolkit

### 3D Transforms
- `translate3d(x, y, z)` for positioning
- `rotateX/Y/Z` for orientation
- `perspective` for depth
- `preserve-3d` for nested 3D space

### CSS Math Functions
- `hypot(dx, dy)` — Pythagorean distance (wall width)
- `atan2(dy, dx)` — inverse tangent (wall rotation)
- `sin()`, `cos()` — camera offset calculations

These are the same math you'd use in any 3D engine. The difference: CSS runs it in the browser's style system instead of a JavaScript render loop.

### Custom Properties + @property
- Raw DOOM coordinates stored as `--start-x`, `--start-y`, etc.
- `@property` registers types for animation (`<number>`)
- Enables smooth transitions for falling, doors, lights

### Clip-Path
- `polygon()` for irregular sector shapes
- `path()` + `evenodd` for sectors with holes (pillars, platforms)
- `shape()` (newer) for natural-language paths with percentages

### Anchor Positioning
- `anchor-name` on trigger element
- `position-anchor` + `anchor(top)` for responsive positioning
- Used for HUD weapon sprite anchored to status bar

## Why It Falls Over

Browser compositors are optimized for layered UI — buttons, menus, cards. Not 3D scenes with thousands of elements in perspective. Safari on iOS crashes on large maps. Manual culling (hiding off-screen elements) is required. There's experimental pure-CSS culling using "type grinding" (paused animation tricks), but it's a hack.

The takeaway: CSS 3D is a proof of concept, not a production rendering engine. For a single cool demo or a small scene, it works. For anything resembling a real game or data visualization with thousands of elements, use WebGL. The browser compositor isn't built for this.

The open thread: CSS keeps acquiring features that blur the line between styling and programming — math functions, anchor positioning, container queries. At some point the question flips from "can CSS do this?" to "should CSS do this?" cssDOOM is the answer to the first question. The second is still open.

## Related

- [[css-is-doomed]] — Full DOOM in CSS case study
- [[browser-compositor]] — How browser rendering works
- [[css-math-functions]] — `hypot()`, `atan2()`, etc.
