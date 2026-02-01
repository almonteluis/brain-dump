---
description: Notes about 🚀 Week 1, Day 6 Variables & Data Types in R** 🐍📊.
---

Now that you've mastered **Go (Golang) variables**, let's dive into **R**, a language designed for **data science and statistics**.

---
description: React notes and reference about 🚀 Week 1, Day 6 Variables & Data Types in R** 🐍📊.

## **📌 Concept Overview**

- R is **dynamically typed** (like Python, unlike Go/Rust).
- **Everything is a vector**—even single values!
- Variables are typically assigned with `<-` instead of `=` (but `=` also works).

---

## **🔹 Declaring Variables in R**

### **✅ 1. Using `<-` for Variable Assignment**

```r
name <- "Luis"
age <- 33
likes_R <- TRUE
print(name)
print(age)
print(likes_R)
```

✔ **R convention uses `<-` instead of `=` for assignment.**  
✔ **`TRUE` is uppercase (not `true` like Python/Go).**

---

### **✅ 2. Checking Variable Types (`class()`)**

```r
x <- 42
y <- "Hello"
z <- TRUE
print(class(x))  # "numeric"
print(class(y))  # "character"
print(class(z))  # "logical"
```

✔ **Use `class(variable)` to check the type.**

---

### **✅ 3. Numeric Data Types in R**

```r
num1 <- 10L  # Integer (use L for explicit integer)
num2 <- 3.14  # Numeric (default type for numbers in R)
print(class(num1))  # "integer"
print(class(num2))  # "numeric"
```

✔ **R treats numbers as `numeric` by default (floating-point).**

---

### **✅ 4. Vectors (Lists of Values)**

```r
numbers <- c(1, 2, 3, 4, 5)
print(numbers)
print(class(numbers))  # "numeric"
```

✔ **`c()` creates a vector (list of values).**

---

### **🛠 5 Exercises to Practice**

### **✅ Exercise 1: Declare Basic Variables**

- Create variables for **your name, age, and whether you like R**.
- Print them to the console.

---

### **✅ Exercise 2: Checking Data Types**

- Assign an **integer, a string, and a boolean** to variables.
- Print their **data types using `class()`**.

---

### **✅ Exercise 3: Numeric Data Type Conversion**

- Convert an **integer to numeric** (`as.numeric()`).
- Convert a **string to numeric** (`as.numeric("42")`).

---

### **✅ Exercise 4: Create & Print a Vector**

- Create a **vector of your favorite numbers**.
- Print the vector and its type.

---

### **✅ Exercise 5: Function with Parameters & Return Value**

- Write a function **`years_until_100(age)`** that:
    - Takes an integer `age`.
    - Returns **how many years until 100**.
- Call the function and print the result.

---

### **📩 Submit Your Work**

Once you complete the exercises, send me your solutions! I'll review for **correctness, readability, and efficiency**.

🚀 **Ready? Start coding!** 🐍📊