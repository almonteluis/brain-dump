---
description: Using CSS transforms, math functions, and modern features to render 3D scenes without Canvas or WebGL
tags: [css, 3d, rendering, browser-capabilities, transforms]
sources: ["css-is-doomed"]
created: 2026-04-29
updated: 2026-04-29
---

# CSS 3D Rendering

Using CSS transforms, math functions, and modern features to render 3D scenes without Canvas or WebGL. Demonstrated by cssDOOM — a full DOOM game where every element is a `<div>`.

## Key Techniques

### 3D Transforms
- `translate3d(x, y, z)` for positioning
- `rotateX/Y/Z` for orientation
- `perspective` for depth
- `preserve-3d` for nested 3D space

### CSS Math Functions
- `hypot(dx, dy)` — Pythagorean distance (wall width)
- `atan2(dy, dx)` — Inverse tangent (wall rotation)
- `sin()`, `cos()` — Camera offset calculations

### Custom Properties + @property
- Raw DOOM coordinates stored as `--start-x`, `--start-y`, etc.
- `@property` registers types for animation (e.g., `<number>`)
- Enables smooth transitions for falling, doors, lights

### Clip-Path
- `polygon()` for irregular sector shapes
- `path()` + `evenodd` for sectors with holes (pillars, platforms)
- `shape()` (newer) for natural-language paths with percentages

### Anchor Positioning
- `anchor-name` on trigger element
- `position-anchor` + `anchor(top)` for responsive positioning
- Used for HUD weapon sprite anchored to status bar

## Performance Limitations

- Browser compositors optimized for layered UI, not 3D scenes
- Thousands of 3D-transformed elements overwhelm compositor
- Safari on iOS crashes on large maps
- Manual culling required (hide off-screen elements)
- Experimental pure-CSS culling uses "type grinding" (paused animation tricks)

## Related

- [[css-is-doomed]] — Full DOOM in CSS case study
- [[browser-compositor]] — How browser rendering works
- [[css-math-functions]] — `hypot()`, `atan2()`, etc.