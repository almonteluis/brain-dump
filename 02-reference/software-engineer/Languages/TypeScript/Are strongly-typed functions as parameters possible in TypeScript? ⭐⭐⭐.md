---
description: Notes about Are strongly-typed functions as parameters possible in TypeScript? ⭐⭐⭐.
---

# TypeScript Function Types

## Overview

## Examples


### Are strongly-typed functions as parameters possible in TypeScript? ⭐⭐⭐

**Questions Details:**

Consider the code:

```js
class Foo {
    save(callback: Function) : void {
        //Do the save
        var result : number = 42; //We get a number from the save operation
        //Can I at compile-time ensure the callback accepts a single parameter of type number somehow?
        callback(result);
    }
}

var foo = new Foo();
var callback = (result: string) : void => {
    alert(result);
}
foo.save(callback);
```
Can you make the result parameter in `save` a type-safe function? Rewrite the code to demonstrate.


 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**

