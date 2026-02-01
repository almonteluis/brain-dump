---
description: Arrow functions provide concise syntax with lexical this binding, implicit return, and limitations as constructors or object methods.
tags: ["core", "functions", "fundamentals", "javascript", "priority/1", "todo"]
---
#javascript #functions #fundamentals #core #priority/1 #todo 

# Arrow Functions

Parent: [[👨‍💻JavaScript Roadmap]]
Related: [[Function Patterns]], [[This Binding]]

Introduction: #todo 
Arrow functions provide a concise syntax for writing function expressions, with lexical this binding.

## Key Features

- Lexical `this` binding
- Implicit return
- Cannot be used as constructors

## Syntax Examples

```javascript
// Basic syntax
const add = (a, b) => a + b;

// With block body
const compute = (x) => {
  const result = x * 2;
  return result;
};

// Object methods (careful with this!)
const obj = {
  value: 42,
  getValue: () => this.value, // won't work!
  getValue2() {
    return this.value;
  }, // correct
};
```

## Related Concepts

- [[This Binding]] - Lexical scope behavior
- [[Function Patterns]] - Different function syntaxes
- [[Memory Management]] - Closure implications
- [[Performance Optimization]] - Function optimization

## Common Pitfalls

```javascript
// ❌ Don't use for methods
const badObject = {
  value: 42,
  getValue: () => this.value, // 'this' refers to outer scope!
};

// ✅ Do use for callbacks
const goodArray = [1, 2, 3].map((x) => x * 2);

// ✅ Do use for short functions
const sum = (a, b) => a + b;
```
