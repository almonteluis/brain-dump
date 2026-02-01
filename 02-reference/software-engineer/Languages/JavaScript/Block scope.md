---
description: Block scope in JavaScript restricts variable access to the block where they are declared using let and const, unlike var which has function scope.
tags: ["component-hierarchy", "es6", "flashcards/javascript/scope", "javascript"]
---

# Block Scope in JavaScript

## Overview

## Examples

>This scope restricts the variable that is declared inside a specific block, from access by the outside of the block. The let & const keyword facilitates the variables to be block scoped. In order to access the variables of that specific block, we need to create an object for it. Variables declared with the var keyword, do not have block scope.

ES6 introduced 2 new Javascript keywords into the world: `let` and `const`

These two keywords provide Block Scope in Javascript. Variables declared inside a { } block cannot be accessed from outside the block:

``` js
{
	let x = 2;
}
// x can NOT be used here
```

Variables declared with the `var` keyword can NOT have block scope.
``` js
{
	var x = 2;
}
// x CAN be used here
```

### Summary:
If I want to reference a `let` or `const` outside of the { } it cannot be accessed but if it's `var` then I can access that variable outside the { }. 

So block scope are only accessed within the block where they are declared and any nested blocks. This prevents unintended access outside their scope.

`var` is used for global scope and it isn't bound to any block scope but this can have unintended side effects.


### Flashcards:
#flashcards/javascript/scope
? What is block scope in JavaScript?
?? Block scope restricts a variable declared inside a specific block from being ==accessed outside of that block==. Variables declared with `let` and `const` have block scope.
<!--SR:!2025-04-01,3,250-->

? Which JavaScript keywords provide block scope?
?? The ES6 keywords ==`let` and `const`== provide block scope in JavaScript.
<!--SR:!2025-04-01,3,250-->

? Can variables declared with `var` have block scope?
?? No. Variables declared with ==`var` cannot have block scope== and can be accessed outside the block where they were declared.
<!--SR:!2025-04-01,3,250-->
Example:
```js
{
  var x = 2;
}
console.log(x); // x CAN be used here (outputs 2)
````

? What happens when you try to access a `let` variable outside its block? ?? Variables declared with `let` ==cannot be accessed outside the block== where they are declared.
<!--SR:!2025-03-25,1,230-->

<!--SR:!2025-04-02,4,270-->

Example:

```js
{
  let x = 2;
}
console.log(x); // Error: x is not defined
```

? What is a potential issue with using `var` for variable declarations? ?? Using `var` for variable declarations can lead to ==unintended side effects== because `var` variables are not bound to block scope and can be accessed globally.
<!--SR:!2025-03-25,1,230-->

<!--SR:!2025-04-01,3,250-->

? How do block-scoped variables behave in nested blocks? ?? Block-scoped variables (`let` and `const`) can be ==accessed within the block where they are declared and any nested blocks==, but not outside their containing block.

<!--SR:!2025-04-02,4,270-->

Example:

```js
{
  let outer = "I'm outer";
  {
    let inner = "I'm inner";
    console.log(outer); // Can access outer variable
  }
  console.log(inner); // Error: inner is not defined
}
```

**tags:**
#javascript #component-hierarchy #es6 