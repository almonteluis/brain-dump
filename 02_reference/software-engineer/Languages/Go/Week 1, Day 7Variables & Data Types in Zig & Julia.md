---
description: Notes about Week 1, Day 7Variables & Data Types in Zig & Julia.
tags: #zig #julia #languages #programming #learning
---

Today, we'll explore **two modern languages**:

- **🔹 Zig** → A low-level, performance-focused systems language (like Rust but simpler).
- **🔹 Julia** → A high-performance language designed for scientific computing & data analysis.

---
description: React notes and reference about Week 1, Day 7Variables & Data Types in Zig & Julia.

## **📌 Concept Overview: Zig**

- **Statically typed** (like Rust & Go).
- **Manual memory management** (similar to C).
- Uses **`var` for mutable** and **`const` for immutable** variables.

### **✅ Declaring Variables in Zig**

```zig
const std = @import("std");

pub fn main() void {
    const name: []const u8 = "Luis";  // Immutable string
    var age: i32 = 33;  // Mutable integer
    std.debug.print("{} is {} years old.\n", .{ name, age });
}
```

✔ **`const` for constants, `var` for mutable variables.**  
✔ **Uses `std.debug.print()` for printing.**

---

## **📌 Concept Overview: Julia**

- **Dynamically typed** (like Python, unlike Zig).
- Uses **multiple dispatch** (functions behave differently based on argument types).
- **Simple syntax** with **high performance (JIT compilation)**.

### **✅ Declaring Variables in Julia**

```julia
name = "Luis"
age = 33
println("$name is $age years old.")
```

✔ **No need to specify types (but you can if needed).**  
✔ **`println()` for printing (string interpolation uses `$`).**

---

## **🛠 5 Exercises to Practice (Both Languages!)**

### **✅ Exercise 1: Declare Basic Variables**

- **Zig:** Declare a **`const` name** and a **`var` age**.
- **Julia:** Declare a **`name` and `age`** and print them.

---

### **✅ Exercise 2: Type Checking**

- **Zig:** Declare a `f32` floating-point variable and print its type.
- **Julia:** Use `typeof()` to check a variable’s type.

---

### **✅ Exercise 3: Type Conversion**

- **Zig:** Convert an `i32` to `f64`.
- **Julia:** Convert a string `"42"` to an integer using `parse(Int, "42")`.

---

### **✅ Exercise 4: Constants & Immutability**

- **Zig:** Declare a `const` and try modifying it (observe the error).
- **Julia:** Declare a `const` and print it.

---

### **✅ Exercise 5: Function with Parameters & Return Value**

- **Zig:** Write a function **`yearsUntil100(age: i32) i32`** that calculates years until 100.
- **Julia:** Write a function **`years_until_100(age)`** that does the same.

---

### **📩 Submit Your Work**

Once you complete the exercises, send me your solutions! I'll review for **correctness, readability, and efficiency**.

🚀 **Ready? Start coding!** 🔥