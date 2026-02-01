---
description: Notes about 🛠 Why Use `.expect()` Instead of `.unwrap().
---


Both `.unwrap()` and `.expect()` are used to **extract a value** from a `Result<T, E>` type in Rust, but **`.expect()` is safer and provides better debugging information**.

---
description: React notes and reference about 🛠 Why Use `.expect()` Instead of `.unwrap().

### **✅ First, Let's See `.unwrap()` in Action**

#### **Example: Using `.unwrap()` (Risky)**

```rust
fn main() {
    let string_num: &str = "74";
    let stringy = string_num.parse::<i32>().unwrap(); // ✅ Works fine for valid input

    println!("Converted number: {}", stringy);
}
```

✔ **If `"74"` is a valid number, it works fine.**  
❌ **But what if we pass `"hello"` instead?**

```rust
fn main() {
    let string_num: &str = "hello"; // ❌ Invalid number
    let stringy = string_num.parse::<i32>().unwrap(); // ❌ This will panic!

    println!("Converted number: {}", stringy);
}
```

**Output (Panic Message):**

```
thread 'main' panicked at 'called `Result::unwrap()` on an `Err` value: ParseIntError { kind: InvalidDigit }'
```

✔ **Rust tells us something went wrong, but the message is generic and doesn't say why.**

---

### **✅ Now, Let's See `.expect()` (Safer Alternative)**

#### **Example: Using `.expect()`**

```rust
fn main() {
    let string_num: &str = "74";
    let stringy = string_num.parse::<i32>().expect("Invalid number provided!");

    println!("Converted number: {}", stringy);
}
```

✔ **Works fine for valid input** ✅

🔹 **Now, let's try with an invalid input (`"hello"`)**:

```rust
fn main() {
    let string_num: &str = "hello"; // ❌ Invalid input
    let stringy = string_num.parse::<i32>().expect("Invalid number provided!"); 

    println!("Converted number: {}", stringy);
}
```

**Output (Better Panic Message):**

```
thread 'main' panicked at 'Invalid number provided!: ParseIntError { kind: InvalidDigit }'
```

✔ **The error message clearly tells us what went wrong!**

---

### **💡 Key Differences: `.unwrap()` vs. `.expect()`**

|Method|Behavior|Debugging Info|
|---|---|---|
|`.unwrap()`|Crashes if there's an error|Generic error message|
|`.expect("Custom message")`|Crashes if there's an error|**Custom error message (better for debugging!)**|

---

### **🚀 Best Practice:**

- Use `.unwrap()` **only when you're 100% sure** the value will be valid.
- Use `.expect("Custom message")` **to provide useful debugging information**.

---

### **✅ Final Code (Best Practice)**

```rust
fn main() {
    let string_num: &str = "hello";  // Simulate an invalid input
    let stringy = string_num
        .parse::<i32>()
        .expect("Invalid number provided! Please enter a valid integer.");

    println!("Converted number: {}", stringy);
}
```

🚀 **Now, if the user enters invalid data, they'll get a clear, useful error message!**

---

### **💬 What Do You Think?**

- Does this explanation make sense?
- Would you like to try modifying your code to use `.expect()` instead of `.unwrap()`? 🚀