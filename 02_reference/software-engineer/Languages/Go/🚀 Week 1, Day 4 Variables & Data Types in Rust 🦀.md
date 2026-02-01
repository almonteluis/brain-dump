---
tags: ["datatypes", "learning", "programming", "rust", "variables"]
---

tags: #rust #programming #variables #datatypes #learning

Now that you've mastered Python, TypeScript, and SQL variables, let's dive into Rust, a statically typed, memory-safe systems language.

---
description: React notes and reference about 🚀 Week 1, Day 4 Variables & Data Types in Rust 🦀.

## 📌 Concept Overview

Rust requires you to explicitly declare variable types (like TypeScript) and enforces immutability by default (unlike Python).

---

## 🔹 Declaring Variables in Rust

```rust
fn main() {
    let name: &str = "Luis";  // Immutable variable
    let mut age: i32 = 33;    // `mut` makes it mutable
    println!("{} is {} years old.", name, age);
}
```

- **let** → Declares a variable (immutable by default).
- **mut** → Allows the variable to be changed.
- **i32** → Integer type (32-bit).

---

## 🔹 Basic Data Types in Rust

| Rust Type | Description | Example |
|-----------|-------------|---------|
| i32 | 32-bit integer | `let x: i32 = 10;` |
| f64 | 64-bit float | `let y: f64 = 3.14;` |
| bool | Boolean values | `let is_active: bool = true;` |
| char | Single character | `let letter: char = 'A';` |
| &str | String slice | `let name: &str = "Luis";` |

---

## 🔹 Mutable vs. Immutable Variables

```rust
fn main() {
    let mut count = 10;  // `mut` allows modification
    count += 5;          // Works
    println!("Count: {}", count);

    let x = 42;          // Immutable by default
    // x += 1;  // ❌ Error: Cannot modify immutable variable
}
```

- Immutability prevents accidental modifications (good for safety).

---

## 🔹 Constants in Rust (const)

```rust
const PI: f64 = 3.14159;
```

- Constants (const) must be all uppercase and typed explicitly.

---

## 🛠 5 Exercises to Practice

### ✅ Exercise 1: Declare Basic Variables
- Create variables for your name, age, and whether you like Rust.
- Print them to the console.

``` rust
fn main() {
    let name: &str = “Luis”;
    let age: i32 = 33;
    println!("{} is {} years old.", name, age);

}
```

---

### ✅ Exercise 2: Mutable vs. Immutable Variables
- Create a mutable integer variable and modify it.
- Try modifying an immutable variable (and see the error).

``` rust
let mut c: i32 = 2;
let d: i32 = 5
c = 88
d = 54

```

---

### ✅ Exercise 3: Data Type Conversion
- Convert an i32 number to a f64 float.
- [[🛠 Why Use `.expect()` Instead of `.unwrap()| Convert a String into an interger]]  using `.parse::<i32>()`.
``` rust
let number: i32 = 33;
let floaty = number as f64
let string_num: string = “74”
let int_string = string_num.parse::<i32>()

```

---

### ✅ Exercise 4: Constants in Rust
- Declare a constant for the speed of light (299_792_458 m/s).
- Print it.

---

### ✅ Exercise 5: Function with Parameters & Return Value
- Write a function `calculate_years_until_100(age: i32) -> i32`.
- It should return how many years until 100.
- Call the function with your age.

---

## 📩 Submit Your Work

Once you complete the exercises, send me your solutions! I'll review for correctness, readability, and efficiency.

🚀 Ready? Start coding! 🦀