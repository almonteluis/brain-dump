---
description: Notes about Hoisting.
tags: #javascript #hoisting #scope #frontend #concepts
---

## Definition
>Hoisting is a JavaScript behavior where variable, function, and class declarations are moved to the top of their containing scope during the compilation phase, before code execution.

## Key Points
- Applies to: `var` variables, [[Function Declarations]], and class declarations
- Does **not** apply to: `let`/`const` variables (but they're still hoisted in a different way)
- Only declarations are hoisted, not initializations
- Function expressions follow variable hoisting rules
- Classes are hoisted but not initialized

## How Hoisting Works
### 1. Variable Hoisting
```javascript
console.log(a); // undefined (var is hoisted)
var a = 5;

console.log(b); // ReferenceError (let/const in TDZ)
let b = 10;
```

### 2. Function Hoisting
```javascript
sayHello(); // Works (function declaration)
function sayHello() {
  console.log("Hello!");
}

sayGoodbye(); // TypeError (function expression)
var sayGoodbye = function() {
  console.log("Goodbye!");
}
```

### 3. Class Hoisting
```javascript
const p = new Person(); // ReferenceError
class Person {}
```

## Temporal Dead Zone (TDZ)
- Area where variables exist but can't be accessed
- Applies to `let` and `const` variables
- Starts at beginning of scope and ends at declaration

## Best Practices
1. Declare variables at the top of their scope
2. Use `let`/`const` instead of `var`
3. Initialize variables when declaring
4. Declare functions before using them
5. Use [[Function Declarations]] instead of expressions when hoisting is needed

## Common Pitfalls
```javascript
// Example 1: Unexpected undefined
var x = 1;
function example() {
  console.log(x); // undefined
  var x = 2;
}

// Example 2: TDZ error
function tdzExample() {
  console.log(y); // ReferenceError
  let y = 5;
}
```

## Hoisting Comparison Table
| Declaration Type | Hoisted | Initial Value | Scope     |
|------------------|---------|---------------|-----------|
| `var`            | Yes     | `undefined`   | Function  |
| `let`            | Yes     | Not set (TDZ) | Block     |
| `const`          | Yes     | Not set (TDZ) | Block     |
| Function         | Yes     | Function      | Block*    |
| Class            | Yes     | Not set (TDZ) | Block     |

## Visual Diagrams

### 1. Variable Hoisting Process
```javascript
// Original Code
console.log(a);
var a = 5;

// How JavaScript Sees It (conceptual)
var a;          // Declaration hoisted
console.log(a); // undefined
a = 5;          // Initialization remains
```

### 2. Function Hoisting Timeline
```
[Compilation Phase]           [Execution Phase]
1. Hoist [[function declarations]] 3. Execute code
2. Hoist var declarations
```
```javascript
// Works because function is fully hoisted
sayHello();
function sayHello() { /* ... */ }
```

### 3. TDZ Visualization (let/const)
```
{ // Block starts
  │
  │ Temporal Dead Zone
  │ (variable exists but inaccessible)
  ▼
  let y = 5; // TDZ ends
  // Variable can now be used
}
```

### 4. Hoisting Hierarchy
```
┌─────────────┐
│  Functions  │ (Highest priority)
├─────────────┤
│   Variables │ (var declarations)
├─────────────┤
│    Classes   │ (Hoisted but not initialized)
└─────────────┘
```

## Personal Notes Section

### My Understanding (Write your thoughts here)
[Add your own explanation using these prompts:]
- What mental analogy helps me remember hoisting?
  (e.g., "It's like JavaScript taking all declarations and putting them in a 'to-do' list at the top")
  
- How I differentiate between var/let/const hoisting:
	`var` get move to the top and because a global variable
	`const` and `let` get move to the top of their block or function scope so another function can't access variable inside another one.
  
- My trick to avoid hoisting issues:
	- always declare your
  
- Diagram I imagine when thinking about hoisting:
  [Describe or sketch your mental model]
  
- Common mistakes I want to avoid:
  1. 
  2. 
  
- Example from my own code:
```javascript
// [Add your own example where hoisting affected your code]
```

### Practice Area
```javascript
// Test your understanding - predict outputs
console.log(name); // ?
var name = "Alice";

function test() {
  console.log(age); // ?
  let age = 30;
}
test();
```

[Write your predictions here]
1. 
2. 

[Actual Output:]
1. 
2. 

## Summary
- Hoisting moves declarations to the top of their scope
- `var` declarations are initialized with `undefined`
- `let`/`const` declarations remain uninitialized (TDZ)
- [[Function Declarations]] are fully hoisted
- Class declarations are hoisted but not initialized

## Resources
- [MDN Web Docs - Hoisting](https://developer.mozilla.org/en-US/docs/Glossary/Hoisting)
- [JavaScript.info - Hoisting](https://javascript.info/var)
- [W3Schools - JavaScript Hoisting](https://www.w3schools.com/js/js_hoisting.asp)
- [freeCodeCamp - What is Hoisting](https://www.freecodecamp.org/news/what-is-hoisting-in-javascript/)
- [DigitalOcean - Understanding Hoisting](https://www.digitalocean.com/community/tutorials/understanding-hoisting-in-javascript)