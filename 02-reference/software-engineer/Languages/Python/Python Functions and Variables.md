---
tags: ["functions", "programming", "python", "scope", "variables"]description: Notes on Python Functions and Variables and key concepts for reference.
---
#python #functions #variables #scope #programming

In Python, understanding the concept of scope is crucial for proper variable management and function development. Scope determines where variables can be accessed from in your code.

## The Four Levels of Scope in Python

Python has four distinct levels of scope, which dictate how and where variables can be accessed:

1. Local scope
2. Enclosing scope
3. Global scope
4. Built-in scope

This sequence is also the order in which Python searches for variables (LEGB rule).

### 1. Local Scope

Local scope refers to variables declared inside a function. These variables are only available within that specific function and cannot be accessed from outside.

```python
def get_total(a, b):
    # local variable declared inside a function
    total = a + b
    return total

print(get_total(5, 2))  # Outputs: 7

# Attempting to access variable outside of the function:
# print(total)  # This would raise: NameError: name 'total' is not defined
```

In this example, `total` is a local variable that exists only within the `get_total()` function. When you try to access it from outside the function, Python raises a `NameError` because the variable is out of scope.

### 2. Enclosing Scope

Enclosing scope comes into play when you have nested functions (functions defined inside other functions). Variables from the outer function are accessible in the inner function.

```python
def get_total(a, b):
    # enclosed variable declared inside a function
    total = a + b

    def double_it():
        # local variable
        double = total * 2  # Can access 'total' from the enclosing function
        print(double)

    double_it()
    # double variable will not be accessible here
    # print(double)  # This would raise: NameError: name 'double' is not defined

    return total
```

In this example:
- `total` is in the enclosing scope for the `double_it()` function
- `double` is a local variable within `double_it()` and cannot be accessed from `get_total()`
- The inner function `double_it()` can access variables from its enclosing function `get_total()`

### 3. Global Scope

Global scope refers to variables declared outside of any function. These variables can be accessed from anywhere in the code, including inside functions.

```python
special = 5  # global variable

def get_total(a, b):
    # enclosed scope variable declared inside a function
    total = a + b
    print(special)  # Can access the global variable

    def double_it():
        # local variable
        double = total * 2
        print(special)  # Can also access the global variable

    double_it()

    return total
```

In this example, `special` is a global variable that can be accessed from both `get_total()` and `double_it()` functions.

### 4. Built-in Scope

Built-in scope includes all the names that are built into Python, like built-in functions and exceptions. These are automatically available in all Python programs.

Examples of built-in functions include:
- `print()`
- `len()`
- `range()`
- `str()`
- `int()`

You don't need to declare or import these functions; they're always available.

## Modifying Variables from Different Scopes

### Modifying Global Variables from Within Functions

To modify a global variable from within a function, you need to use the `global` keyword:

```python
counter = 0  # Global variable

def update_counter():
    global counter  # Declare that we want to use the global variable
    counter += 1  # Now we can modify it
    print(counter)

update_counter()  # Outputs: 1
print(counter)    # Outputs: 1
```

Without the `global` keyword, Python would create a new local variable with the same name instead of modifying the global one.

### Modifying Enclosing Variables from Nested Functions

Similarly, to modify variables from an enclosing scope, you need to use the `nonlocal` keyword:

```python
def outer_function():
    count = 0  # Variable in enclosing scope
    
    def inner_function():
        nonlocal count  # Declare that we want to use the enclosing variable
        count += 1      # Now we can modify it
        print(count)
    
    inner_function()
    print(count)  # The value has been modified by inner_function

outer_function()  # Outputs: 1, 1
```

## Variable Lifetime

Apart from scope, variables also have a lifetime (how long they exist in memory):

- **Local variables**: Exist only while the function is executing
- **Enclosing variables**: Exist while the outer function is executing
- **Global variables**: Exist for the duration of the script
- **Built-in names**: Always available throughout the program

## Best Practices

1. **Minimize global variables**: They can lead to confusing code and unexpected behavior
2. **Use function parameters and return values** instead of relying on enclosing or global scope
3. **Keep functions focused and specific** to make your code more maintainable
4. **Use clear variable names** that indicate their purpose and scope
5. **Be explicit with global and nonlocal** when you need to modify variables from outer scopes

## Common Pitfalls

### Shadowing Variables

When a variable in a local scope has the same name as a variable in an outer scope, it "shadows" the outer variable:

```python
x = 10  # Global variable

def my_function():
    x = 5  # Local variable shadows the global one
    print("Local x:", x)  # Outputs: Local x: 5

my_function()
print("Global x:", x)  # Outputs: Global x: 10
```

### UnboundLocalError

This error occurs when you try to modify a global variable without declaring it with the `global` keyword:

```python
count = 0

def increment():
    count += 1  # This raises UnboundLocalError
    print(count)

# To fix:
def correct_increment():
    global count
    count += 1
    print(count)
```

---
description: React notes and reference about Python Functions and Variables.

**Related Notes:**
- [[Python Functions and Variables]]
- [[Function Declaration in Python]]
- [[Python Variables]]
- [[Python Data Types and Syntax Reference]]

**Back to:** [[Meta Programming in Python]]