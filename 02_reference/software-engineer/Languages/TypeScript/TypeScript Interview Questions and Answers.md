---
description: Notes about TypeScript Interview Questions and Answers.
---

TypeScript starts from the same syntax and semantics that millions of JavaScript developers know today. Don't miss that advanced ==list== of TypeScript interview questions and answers and nail your next web developer tech interview in style.

> You could also find all the answers here 👉 https://www.fullstack.cafe/TypeScript.

![[List the built-in types in Typescript]]
![[What are Modules in Typescript? ⭐]]
### What is Typescript and why one should use it? ⭐

**Answer:**

TypeScript is a free and open-source programming language developed and maintained by Microsoft. It is a strict syntactical superset of JavaScript, and adds optional static typing and class-based object-oriented programming to the language.

🔗 **Source:** [FullStack.Cafe](https://www.fullstack.cafe)


### Explain generics in TypeScript ⭐

**Answer:**

Generics are able to create a component or function to work over a variety of types rather than a single one.

```js
/** A class definition with a generic parameter */
class Queue<T> {
  private data = [];
  push = (item: T) => this.data.push(item);
  pop = (): T => this.data.shift();
}

const queue = new Queue<number>();
queue.push(0);
queue.push("1"); // ERROR : cannot push a string. Only numbers allowed

```


🔗 **Source:** [basarat.gitbooks.io](https://basarat.gitbooks.io/typescript/docs/types/generics.html)


### What is TypeScript and why would I use it in place of JavaScript? ⭐

**Questions Details:**





**Answer:**

**TypeScript** is a superset of JavaScript which primarily provides optional static typing, classes and interfaces. One of the big benefits is to enable IDEs to provide a richer environment for spotting common errors as *you type the code*. For a large JavaScript project, adopting TypeScript might result in more robust software, while still being deployable where a regular JavaScript application would run.

In details:
* TypeScript supports new ECMAScript standards and compiles them to (older) ECMAScript targets of your choosing. This means that you can use features of ES2015 and beyond, like modules, lambda functions, classes, the spread operator, destructuring, today. 
* JavaScript code is valid TypeScript code; TypeScript is a superset of JavaScript. 
* TypeScript adds type support to JavaScript. The type system of TypeScript is relatively rich and includes: interfaces, enums, hybrid types, generics, union and intersection types, access modifiers and much more. TypeScript makes typing a bit easier and a lot less explicit by the usage of type inference.
* The development experience with TypeScript is a great improvement over JavaScript. The IDE is informed in real-time by the TypeScript compiler on its rich type information. 
* With strict null checks enabled (`--strictNullChecks` compiler flag) the TypeScript compiler will not allow undefined to be assigned to a variable unless you explicitly declare it to be of nullable type. 
* To use TypeScript you need a build process to compile to JavaScript code. The TypeScript compiler can inline source map information in the generated .js files or create separate .map files. This makes it possible for you to set breakpoints and inspect variables during runtime directly on your TypeScript code. 
* TypeScript is open source (Apache 2 licensed, see github) and backed by Microsoft. *Anders Hejlsberg*, the lead architect of C# is spearheading the project.

🔗 **Source:** [stackoverflow.com](https://stackoverflow.com/questions/12694530/what-is-typescript-and-why-would-i-use-it-in-place-of-javascript)


[[What is TypeScript and why do we need it? ⭐]]
[[What are the benefits of TypeScript? ⭐]]
[[Do we need to compile TypeScript files and why? ⭐]]
[[How to call base class constructor from child class in TypeScript? ⭐]]
[[What are the difference between Typescript and JavaScript? ⭐⭐]]
[[What is Interface in TypeScript? ⭐⭐]]
[[When to use interfaces and when to use classes in TypeScript? ⭐⭐]]
[[What is the difference between Classes and Interfaces in Typescript? ⭐⭐]]
[[What is "Decorators" in TypeScript? ⭐⭐]]
[[What is getters setters in TypeScript?]]
### Q16: How could you check null and undefined in TypeScript? ⭐⭐

**Answer:**

Just use:
```js
if (value) {
}
```
It will evaluate to `true` if `value` is not:

* `null`
* `undefined`
* `NaN`
* empty string `''`
* `0`
* `false`

TypesScript includes JavaScript rules.


🔗 **Source:** [stackoverflow.com](https://stackoverflow.com/questions/28975896/is-there-a-dedicated-function-to-check-null-and-undefined-in-typescript)


### Q17: How to implement class constants in TypeScript? ⭐⭐

**Answer:**

In TypeScript, the `const` keyword cannot be used to declare class properties. Doing so causes the compiler to an error with "A class member cannot have the 'const' keyword." TypeScript 2.0 has the `readonly` modifier:

```js
class MyClass {
    readonly myReadonlyProperty = 1;

    myMethod() {
        console.log(this.myReadonlyProperty);
    }
}

new MyClass().myReadonlyProperty = 5; // error, readonly
```

🔗 **Source:** [stackoverflow.com](https://stackoverflow.com/questions/37265275/how-to-implement-class-constants-in-typescript)


### Q18: Could we use TypeScript on backend and how? ⭐⭐

**Answer:**

Typescript doesn’t only work for browser or frontend code, you can also choose to write your backend applications. For example you could choose Node.js and have some additional type safety and the other abstraction that the language brings.

1. Install the default Typescript compiler  

```sh
npm i -g typescript
```
2. The TypeScript compiler takes options in the shape of a tsconfig.json file that determines where to put built files and in general is pretty similar to a babel or webpack config.

```sh
{
  "compilerOptions": {
    "target": "es5",
    "module": "commonjs",
    "declaration": true,
    "outDir": "build"
  }
}
```
3. Compile ts files

```sh
tsc
```
4. Run

```js
node build/index.js
```

🔗 **Source:** [jonathanmh.com](https://jonathanmh.com/typescript-node-js-tutorial-backend-beginner/)


### Q19: Does TypeScript support all object oriented principles? ⭐⭐

**Answer:**

The answer is **YES**. There are 4 main principles to Object Oriented Programming: 

* Encapsulation, 
* Inheritance, 
* Abstraction, and 
* Polymorphism. 

TypeScript can implement all four of them with its smaller and cleaner syntax.

🔗 **Source:** [jonathanmh.com](https://jonathanmh.com/typescript-node-js-tutorial-backend-beginner/)


### Q20: Which object oriented terms are supported by TypeScript? ⭐⭐

**Answer:**

TypeScript supports following object oriented terms:

*   Modules
*   Classes
*   Interfaces
*   Data Types
*   Member functions

🔗 **Source:** [http://www.talkingdotnet.com](http://www.talkingdotnet.com/typescript-interview-questions/)


### Q21: What is a TypeScript Map file? ⭐⭐

**Answer:**

`.map` files are source map files that let tools map between the emitted JavaScript code and the TypeScript source files that created it. Many debuggers (e.g. Visual Studio or Chrome's dev tools) can consume these files so you can debug the TypeScript file instead of the JavaScript file.

🔗 **Source:** [stackoverflow.com](https://stackoverflow.com/questions/17493738/what-is-a-typescript-map-file)


### Q22: Explain how and why we could use property decorators in TS? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


[[Are strongly-typed functions as parameters possible in TypeScript? ⭐⭐⭐]]
### Q24: Is that TypeScript code valid? Explain why. ⭐⭐⭐

**Questions Details:**

Consider:
```js
class Point {
    x: number;
    y: number;
}

interface Point3d extends Point {
    z: number;
}

let point3d: Point3d = {x: 1, y: 2, z: 3};
```


 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q25: What are different components of TypeScript? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q26: How TypeScript is optionally statically typed language? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q27: What is the default access modifier for members of a class in TypeScript? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q28: How can you allow classes defined in a module to accessible outside of the module? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q29: What's wrong with that code? ⭐⭐⭐

**Questions Details:**

```js
// something is wrong
function reverse(s: String): String;
```


 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q30: Does TypeScript supports function overloading? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q31: How To Use external plain JavaScript Libraries in TypeScript? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q32: What is Typings in Typescript? ⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q33: What is the difference between "interface vs type" statements? ⭐⭐⭐⭐

**Questions Details:**

```js
interface X {
    a: number
    b: string
}

type X = {
    a: number
    b: string
};
```


 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q34: How would you overload a class constructor in TypeScript? ⭐⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q35: Explain why that code is marked as WRONG? ⭐⭐⭐⭐

**Questions Details:**

```js
/* WRONG */
interface Fetcher {
    getObject(done: (data: any, elapsedTime?: number) => void): void;
}
```


 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q36: What is one thing you would change about TypeScript? ⭐⭐⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q37: Explain when to use "declare" keyword in TypeScript ⭐⭐⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q38: What are Ambients in TypeScripts and when to use them? ⭐⭐⭐⭐⭐

 See 👉 **[Answer](https://www.fullstack.cafe/TypeScript)**


### Q39: Is it possible to generate TypeScript declaration files from JS library? ⭐⭐⭐⭐⭐