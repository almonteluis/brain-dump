---
description: Notes about function scope.
tags: #javascript #scope #functions #frontend #concepts
---

> When a variable is declared inside a function, it is only accessible within that function and cannot be used outside that function.

JavaScript has function scope: Each function creates a new scope. Variables defined inside a function are not accessible (visible) from outside the function. Variables declared with `var`, `let`, `const` are similar when declared inside a function.

```js
function myFunction() {
	var carName = 'Volvo'; // function scope
}
function myFunction() {
	const carName = 'Volvo'; // function scope
}
function myFunction() {
	let carName = 'Volvo'; // function scope
}
```

### Summary
any variables declared inside a variable will not be visible outside that function unless you return the value of that variable.