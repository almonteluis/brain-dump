---
description: Notes about Symbol.
---

> Symbols are a unique and immutable primitive data type in JavaScript, introduced in ECMAScript 6 (ES6). They are often used to create unique property keys for objects, ensuring no property key collisions occur. Each Symbol value is distinct, even when multiple are created with the same description. Symbols can be created using the Symbol() function, and their primary use case is to add hidden or special properties to objects that won't interfere with other properties or methods.

Here's a structured Markdown guide to JavaScript Symbols:

```markdown
# Understanding JavaScript Symbols

## What is a Symbol?
A **Symbol** is a unique, immutable primitive value used to create distinct identifiers. Unlike other primitives, Symbols don't have literal forms and are created using the `Symbol()` function.

```javascript
const id = Symbol('uniqueId'); // 'uniqueId' is an optional description
```

### Key Features:
- **Uniqueness**: Symbols are always unique.
  ```javascript
  Symbol() === Symbol(); // false
  ```
- **Description**: Adds clarity (accessible via `.description`).
  ```javascript
  const sym = Symbol('desc');
  console.log(sym.description); // 'desc'
  ```
- **Type**: Returns `'symbol'` with `typeof`.
  ```javascript
  typeof Symbol(); // 'symbol'
  ```
- **No `new` Keyword**: Cannot use `new Symbol()` (throws error).

---
description: React notes and reference about Symbol.

## Sharing Symbols Globally
Use `Symbol.for()` to create/reuse symbols in a global registry.

```javascript
// Create or retrieve a global symbol
const globalSym = Symbol.for('sharedKey');
const sameSym = Symbol.for('sharedKey');
console.log(globalSym === sameSym); // true

// Get key of a global symbol
console.log(Symbol.keyFor(globalSym)); // 'sharedKey'
```

---

## Symbol Use Cases
### 1. Unique Object Properties
Avoid property name collisions in objects:
```javascript
const STATUS = {
  PENDING: Symbol('pending'),
  COMPLETE: Symbol('complete')
};

const task = {
  [STATUS.PENDING]: 'Task is pending'
};
```

### 2. Hidden Object Properties
Symbols don't appear in standard property enumeration:
```javascript
const user = {
  name: 'Alice',
  [Symbol('id')]: 123
};

console.log(Object.keys(user)); // ['name']
console.log(Object.getOwnPropertySymbols(user)); // [Symbol(id)]
```

---

## Well-Known Symbols
Built-in symbols that modify object behavior.

| Symbol                 | Purpose                                      |
|------------------------|----------------------------------------------|
| `Symbol.hasInstance`   | Customize `instanceof` behavior              |
| `Symbol.iterator`      | Define iteration logic (used in `for..of`)   |
| `Symbol.isConcatSpreadable` | Control array concat behavior        |
| `Symbol.toPrimitive`   | Customize object-to-primitive conversion     |

### Example 1: `Symbol.hasInstance`
Customize `instanceof` checks:
```javascript
class MyArray {
  static [Symbol.hasInstance](obj) {
    return Array.isArray(obj);
  }
}
console.log([] instanceof MyArray); // true
```

### Example 2: `Symbol.iterator`
Make objects iterable:
```javascript
const range = {
  start: 1,
  end: 3,
  *[Symbol.iterator]() {
    for (let i = this.start; i <= this.end; i++) yield i;
  }
};

for (const num of range) console.log(num); // 1, 2, 3
```

### Example 3: `Symbol.isConcatSpreadable`
Control array concatenation:
```javascript
const list = {
  0: 'A',
  1: 'B',
  length: 2,
  [Symbol.isConcatSpreadable]: true
};
console.log(['Start'].concat(list)); // ['Start', 'A', 'B']
```

### Example 4: `Symbol.toPrimitive`
Customize primitive conversion:
```javascript
const price = {
  value: 99,
  currency: 'USD',
  [Symbol.toPrimitive](hint) {
    return hint === 'string' ? `${this.value}${this.currency}` : this.value;
  }
};
console.log(+price); // 99
console.log(`${price}`); // '99USD'
```

---

## When to Use Symbols
- **Unique Keys**: Prevent property name collisions.
- **Metadata**: Attach hidden data to objects.
- **Built-in Protocols**: Customize object behavior (e.g., iteration).

## Related Concepts
- [[Type Coercion]] - Symbol conversion rules
- [[Object Properties]] - Using Symbols as property keys
- [[Iterators and Generators]] - Symbol.iterator implementation
- [[Memory Management]] - Symbol garbage collection

## Common Patterns
```javascript
// Private fields implementation
const _private = Symbol('private');

class Example {
  constructor() {
    this[_private] = {};
  }

  accessPrivate() {
    return this[_private];
  }
}
```

---

## Key Takeaways
- Symbols are **unique** and **immutable**.
- Use `Symbol.for()` for global registry access.
- Well-known symbols let you **customize object behavior**.
- Symbols are **not enumerable** in property lists.

```mermaid
flowchart TD
    A[Create Symbol] --> B{Global?}
    B -->|Yes| C[Symbol.for('key')]
    B -->|No| D[Symbol('desc')]
    C --> E[Reusable]
    D --> F[Unique]
    E --> G[Object Properties]
    F --> G
    G --> H[Hidden/Unique Keys]
```