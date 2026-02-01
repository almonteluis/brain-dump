---
tags: ["defining-functions", "for-statements", "if-statements"]
---
🔥 Let’s roll! Welcome to **Week 1, Day 1** – Python Edition.

---
description: React notes and reference about Week 1, Day 1 → Python variables, conditionals, loops, functions, scope.

# 📅 Week 1, Day 1: Python — Variables, Conditionals, Loops, Functions, Scope

🧠 **Goal**: Master Python’s core control structures with **readable**, **real-world** examples. You'll reuse these concepts across all seven languages.

---

## 🐍 Python (v3.12.x): Control Flow Core

### 🔹 Variables

```python
# Assigning variables
username = "ChaseUser42"
age = 29
is_logged_in = True
```

> Python is dynamically typed — no need to declare types, but readability is key.

---

### 🔹 Conditionals

```python
if age >= 18:
    print("Welcome, adult user.")
elif age > 13:
    print("You're a teen. Limited access.")
else:
    print("Access denied. Too young.")
```

> Python uses **indentation** instead of braces `{}`.

---

### 🔹 Loops

#### `for` loop

```python
tech_stack = ["Python", "TypeScript", "Go"]

for tech in tech_stack:
    print(f"Now learning: {tech}")
```

#### `while` loop

```python
counter = 3
while counter > 0:
    print(f"Countdown: {counter}")
    counter -= 1
```

---

### 🔹 Functions

```python
def greet_user(name, role="guest"):
    return f"Hello {name}, you are logged in as {role}."

print(greet_user("Jordan", "admin"))
```

> Functions are first-class objects — they can be passed around and assigned like variables.

---

### 🔹 Scope

```python
x = 10  # global

def show_scope():
    x = 5  # local
    print("Inside function:", x)

show_scope()
print("Outside function:", x)
```

> Python has LEGB scope: **Local → Enclosing → Global → Built-in**

---

# 🧪 Exercises

### ✅ Exercise 1: Basic Variable & Conditional

Write a program that takes a user’s age and prints:

- "Minor" if under 18
    
- "Adult" if 18 or older
    

---

### ✅ Exercise 2: Multiple Conditions

Extend the above to include:

- "Teen" for 13–17
    
- "Senior" for 65+
    

---

### ✅ Exercise 3: Loop Over List

Given this list:

```python
languages = ["Python", "Go", "Java", "Rust"]
```

Loop through and print:

- `"{lang} is statically typed"` for all except Python.
    

---

### ✅ Exercise 4: Real-World Function

Write a function `can_access_dashboard(age, is_admin)` that returns:

- `True` if age ≥ 18 or `is_admin == True`
    
- `False` otherwise
    

Then call it with several example values.

---

### ✅ Exercise 5: Challenge

Write a function `filter_even(numbers)` that:

- Accepts a list of integers
    
- Returns a **new list** with only even numbers
    
- Use a loop or list comprehension
    

Example:

```python
filter_even([1, 2, 3, 4])  # returns [2, 4]
```

---

# 🚀 Go Further: Edge Cases & Idioms

### 🔍 1. Ternary in Python

```python
status = "adult" if age >= 18 else "minor"
```

---

### 🔍 2. Inline Function + List Comp

```python
def square(x): return x * x
squares = [square(n) for n in range(5)]
```

---

### 🔍 3. Nested Conditionals (real-world)

```python
def classify_user(age, is_logged_in):
    if is_logged_in:
        if age >= 18:
            return "Adult access"
        else:
            return "Limited access"
    return "Login required"
```

---

# 🔗 Docs for Deep Dive

- [Python if statements](https://docs.python.org/3/tutorial/controlflow.html#if-statements)
    
- [Python loops](https://docs.python.org/3/tutorial/controlflow.html#for-statements)
    
- [Python functions](https://docs.python.org/3/tutorial/controlflow.html#defining-functions)
    

---

## 📩 Submit Your Code

When ready, reply with your completed exercises for grading.  
I'll evaluate them on:

- ✅ Correctness
    
- ✅ Readability (naming, structure)
    
- ✅ Pythonic style
    

---

Would you like me to preload a solution scaffold file for Replit, or are you coding locally?