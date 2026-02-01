---
description: JavaScript function patterns including declarations, arrow functions, generators, IIFE, currying, and memoization for clean code.
tags: ["best-practices", "core", "es6", "functions", "fundamentals", "javascript", "patterns", "priority/1"]
---
#javascript #functions #patterns #fundamentals #core #priority/1 #es6 #best-practices

**Parent**: [[👨‍💻JavaScript Roadmap]]

Introduction:
JavaScript functions are first-class citizens and can be used in various patterns. Understanding these patterns is essential for writing clean and maintainable code.

Knowledge Points:

- [[Function Declarations]]

  - Hoisting behavior
  - Named vs anonymous
  - IIFE pattern

- [[Arrow functions]]

  - Lexical this
  - Implicit return
  - Use cases

- [[Generator Functions]]
  - Iteration protocols
  - Async generators
  - State management

## Personal Notes Section

### My Understanding

[Write your thoughts using these prompts:]

- How I would explain function patterns to a beginner:
  Function patterns are different ways to write functions in JavaScript. Think of them like different tools in a toolbox - each has its own special use case.

- Mental model/analogy that helps me remember:
  - [[Function Declarations]] are like formal definitions (like in a dictionary)
  - [[Arrow functions]] are like shorthand notes
  - [[Generator functions]] are like pause-and-play buttons
- Key differences between patterns:
  1. [[Function Declarations]] are hoisted, function expressions aren't
  2. [[Arrow functions]] don't have their own 'this', regular functions do
  3. [[Generator functions]] can pause execution, regular functions run to completion
- Visual representation:

```javascript
// Function Declaration (like a formal definition)
function add(a, b) {
  return a + b;
}

// Arrow Function (like a quick note)
const add = (a, b) => a + b;

// Generator Function (like a pause-play button)
function* counter() {
  yield 1;
  yield 2;
}
```

- Common pitfalls I want to avoid:

  1. Using arrow functions as methods in objects (this binding issues)
  2. Forgetting to return values in arrow functions with blocks
  3. Mixing regular and generator functions incorrectly

- Real-world example from my code:

```javascript
// Example of different function patterns in use
const UserProfile = {
  // Method shorthand
  getData() {
    /* ... */
  },

  // Arrow function for preserved this
  fetchDetails: async () => {
    /* ... */
  },

  // Generator for pagination
  *pageItems() {
    /* ... */
  },
};
```

### Practice Area

```javascript
// Test your understanding
// 1. What's the output?
const obj = {
  name: "Test",
  sayHi: () => console.log(this.name),
  sayHello() {
    console.log(this.name);
  },
};

obj.sayHi();
obj.sayHello();
```

[Your predictions]

1. sayHi: undefined (arrow function this)
2. sayHello: "Test" (method this)

[Actual results]

1. undefined
2. "Test"

### Key Takeaways

- Function declarations are hoisted and create their own this context
- Arrow functions are great for callbacks but not for methods
- Generator functions excel at handling sequences and iteration
- Choose the right pattern based on use case and context

### Resources I Found Helpful

- [MDN - Functions Guide](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Guide/Functions)
- [JavaScript.info - Arrow Functions](https://javascript.info/arrow-functions-basics)
- [MDN - Generator Functions](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Statements/function*)

The backlinks help create a connected knowledge graph where:

1. Related concepts are easily discoverable
2. Implementation patterns are connected
3. Performance implications are clear
4. Best practices are shared across topics

Would you like me to continue with more files and backlinks?

## Related Concepts
- [[Memory Management]] - Closure memory patterns
- [[event loop]] - Function execution context
- [[This Binding]] - Function context behavior
- [[Performance Optimization]] - Function optimization

## Advanced Patterns
```javascript
// Currying
const curry = (fn) => {
  const arity = fn.length;
  return function curried(...args) {
    if (args.length >= arity) return fn(...args);
    return (...more) => curried(...args, ...more);
  };
};

// Memoization
const memoize = (fn) => {
  const cache = new Map();
  return (...args) => {
    const key = JSON.stringify(args);
    if (!cache.has(key)) cache.set(key, fn(...args));
    return cache.get(key);
  };
};
```
