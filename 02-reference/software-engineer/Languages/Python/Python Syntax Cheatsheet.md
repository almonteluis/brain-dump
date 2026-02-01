---
description: Python syntax quick reference covering spacing rules, indentation for code blocks, function definition with def keyword, and proper syntax patterns.
tags: ["any"]
---
This cheat sheet provides quick reference for Python syntax rules.

## Spacing

### Correct
```python
#any amount of whitespace on a single line is ok
x     =        1        +        2
```

### Incorrect
```python
x = 1
+ 2
```

## Indentation

Indentation is crucial in Python as it defines code blocks.

## Functions

Functions allow you to group code into reusable blocks.

**def keyword**: In Python, the `def` keyword defines a function. 

### Syntax

```python
def function_name(parameters):
    # This is inside the function body
    return result
```

### Understanding the terminology:

- **function_name**: The name you give to the function.
- **return**: Optional statement to send back a result from the function.
- **parameters**: Optional values passed to the function. It can be one or more.

Note: Python doesn't use curly or round brackets to define the scope of the function.

### Correct
```python
def say_hello():
    print("Hello there!")

print(say_hello())
```

```python
def say_hello(): print("Hello there!")

print(say_hello())
```

### Incorrect
```python
def say_hello():
print("Hello there!")
```

```python
    def say_hello():
print("Hello there")
```