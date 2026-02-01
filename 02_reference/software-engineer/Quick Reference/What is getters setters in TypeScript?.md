---
description: Notes about What is getters setters in TypeScript?.
---

# TypeScript Getters and Setters

## Overview



**Answer:**
TypeScript supports **getters/setters** as a way of intercepting accesses to a member of an object. This gives you a way of having finer-grained control over how a member is accessed on each object.

```js
class foo {
  private _bar:boolean = false;

  get bar():boolean {
    return this._bar;
  }
  set bar(theBar:boolean) {
    this._bar = theBar;
  }
}

var myBar = myFoo.bar;  // correct (get)
myFoo.bar = true;  // correct (set)
```

🔗 **Source:** [typescriptlang.org](http://www.typescriptlang.org/docs/handbook/classes.html)

