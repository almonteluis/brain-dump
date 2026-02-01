---
description: BigInt enables working with integers larger than 2^53-1 through arbitrary precision integers for cryptography and scientific computations.
tags: ["core", "fundamentals", "javascript", "priority/2", "types"]
---
#javascript #types #fundamentals #core #priority/2

# BigInt
Parent: [[👨‍💻JavaScript Roadmap]]
Related: [[Primitive Types]], [[Number]]

Introduction:
BigInt allows working with integers larger than 2^53-1.

## Key Features
- Arbitrary precision integers
- No decimal point
- Separate type from Number

## Usage Examples
```javascript
// Creating BigInts
const bigNumber = 9007199254740991n;
const alsoHuge = BigInt("9007199254740991");

// Operations
const sum = bigNumber + 1n;
const product = bigNumber * 2n;

// Type checking
typeof 123n === 'bigint' // true
```

> `BigInt` values represent integer values which are too high or too low to be represented by the `number` primitive.

BigInt is a built-in JavaScript object that allows you to work with integers of arbitrary size.

Unlike the Number type, which can accurately represent integers only within the range of ±2^53 , BigInt can handle integers far beyond this limit. This makes it particularly useful for applications requiring high precision with very large numbers, such as cryptography or scientific computations.


A **BigInt value**, also sometimes just called a **BigInt**, is a `bigint` [primitive](https://developer.mozilla.org/en-US/docs/Glossary/Primitive), created by appending `n` to the end of an integer literal, or by calling the [`BigInt()`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/BigInt/BigInt) function (without the `new` operator) and giving it an integer value or string value.

``` jsx
const previouslyMaxSafeInteger = 9007199254740991n;

const alsoHuge = BigInt(9007199254740991);
// 9007199254740991n

const hugeString = BigInt("9007199254740991");
// 9007199254740991n

const hugeHex = BigInt("0x1fffffffffffff");
// 9007199254740991n

const hugeOctal = BigInt("0o377777777777777777");
// 9007199254740991n

const hugeBin = BigInt(
  "0b11111111111111111111111111111111111111111111111111111",
);
// 9007199254740991n
```

BigInt values are similar to Number values in some ways, but also differ in a few key matters: A BigInt value cannot be used with methods in the built-in [`Math`](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Global_Objects/Math) object and cannot be mixed with a Number value in operations; they must be coerced to the same type. Be careful coercing values back and forth, however, as the precision of a BigInt value may be lost when it is coerced to a Number value.

## Related Concepts
- [[Type Coercion]] - BigInt conversion rules
- [[Number]] - Comparison with regular numbers
- [[Performance Optimization]] - BigInt performance implications

## Common Use Cases
```javascript
// Cryptography
const prime = 2n ** 256n - 189n;

// Financial calculations
const cents = BigInt(transaction.amount * 100);

// Performance considerations
function isPowerOfTwo(n) {
  return (n & (n - 1n)) === 0n;
}
```