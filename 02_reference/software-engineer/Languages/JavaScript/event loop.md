---
tags: ["async", "core", "event-loop", "flashcards", "fundamentals", "javascript", "priority/1", "runtime"]description: Notes on event loop and key concepts for reference.
---
#javascript #runtime #event-loop #fundamentals #core #priority/1 #async

# Event Loop
Parent: [[👨‍💻JavaScript Roadmap]]

Introduction:
The JavaScript event loop is a core mechanism that handles asynchronous operations and callback execution...

The event loop is a process that continuously monitors both the call stack and the event queue and checks whether or not the call stack is empty. If the call stack is empty and there are pending events in the event queue, the event loop dequeues the event from the event queue and pushes it to the call stack. The call stack executes the event, and any additional events generated during the execution are added to the end of the event queue.

---
description: React notes and reference about event loop.

**Note:** The event loop allows Node.js to perform non-blocking I/O operations, even though JavaScript is single-threaded, by offloading operations to the system kernel whenever possible. Since most modern kernels are multi-threaded, they can handle multiple operations executing in the background.

## Key Concepts

- [[Call Stack]]
  - Function execution
  - Stack frames
  - Execution context

- [[Event Queue]]
  - Macrotasks
  - Microtasks
  - Priority handling

- [[Task Processing]]
  - Event handling
  - Timer execution
  - Promise resolution

### Tag
#flashcards #javascript 

