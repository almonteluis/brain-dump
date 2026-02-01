---
description: Reference types in JavaScript are objects stored by reference including Object, Array, Function, Date, and RegExp with mutable behavior.
tags: ["core", "fundamentals", "javascript", "priority/1", "types"]
---
#javascript #types #fundamentals #core #priority/1

# Reference Types
Parent: [[👨‍💻JavaScript Roadmap]]
Related: [[JavaScript Types]], [[Primitive Types]], [[Memory Management]]

Introduction:
Reference types in JavaScript are objects that store references to their values.

## Core Reference Types
- Object
- Array
- Function
- Date
- RegExp

## Key Characteristics
- Stored by reference
- Mutable
- Passed by reference

## Common Patterns
```javascript
// Object creation
const obj = {
  prop: 'value'
};

// Array methods
const arr = [1, 2, 3];
arr.map(x => x * 2);

// Function as object
function fn() {}
fn.prop = 'value';
```