---
description: Browser technologies cover DOM manipulation, storage APIs, rendering engines, and web platform capabilities.
tags: ["browser", "core", "fundamentals", "performance", "priority/1", "rendering", "web-apis"]
---

#browser #performance #rendering #fundamentals #core #priority/1 #web-apis

# Browser Rendering Pipeline
Parent: [[👨‍💻JavaScript Roadmap]]

Introduction:
Understanding how browsers render content is crucial for optimizing web applications. The rendering pipeline consists of several key stages that transform HTML, CSS, and JavaScript into pixels on the screen.

Knowledge Points:
- [[Critical Rendering Path]]
  - DOM Construction
  - CSSOM Creation
  - Render Tree Building

## Notes

- [[Layout and Paint]]
  - Reflow Process
  - Paint Operations
  - Compositing 

## Related Concepts
- [[Performance Optimization]] - Optimizing rendering performance
- [[event loop]] - How rendering fits into event loop
- [[Memory Management]] - Memory impact of rendering
- [[Code splitting]] - Impact on initial render

## Performance Considerations
- Minimize layout thrashing
- Optimize paint operations
- Use appropriate triggers for reflow 