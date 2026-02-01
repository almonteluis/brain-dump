---
tags: ["data-types", "python", "reference", "syntax"]description: Notes on Python Data Types and Syntax Reference and key concepts for reference.
---
#python #data-types #reference #syntax

This note provides a quick reference for common Python data types and syntax elements.

## Basic Data Types

| Data type | Meaning | Example |
|-----------|---------|---------|
| string | Text | 'Hello', 'Testing 123' |
| integer | Numbers | -5, 4, 3, 2, 0 |
| float | Decimals | 2.4, 5.2, 1000.00 |

## Flow Control

### Comparison Operators

| Operator | Meaning | Example |
|----------|---------|---------|
| == | Equals | a == b |
| != | Not Equal | a != b |
| < | Less than | a < b |
| > | Greater than | a > b |
| <= | Less than or Equal to | a <= b |
| >= | Greater than or Equal to | a >= b |

## Indentation

Indentation is used to define code blocks in Python. Unlike many programming languages that use braces `{}` to group code, Python uses indentation.

Indentation is mandatory in Python and is used to indicate which statements belong to loops, functions, conditionals, and other structures.

```python
if x > 0:  # Colon indicates the start of the block
    print("Positive")  # Indented 
else:
    print("Non-positive")  # Indented
```

## Comments

### Single-line Comments

Placing a `#` symbol in front of the text you want to be a comment causes Python to ignore everything from that point until the end of the current line.

```python
# Single Line comment
```

### Multi-line Comments

Triple Quotes (`'''` or `"""`): Python uses triple single or double quotes to create multi-line comments. These are typically used for docstrings or comments spanning multiple lines.

```python
# This is a multiline comment
# which can be used for long comments
```

### Inline/Code Comments

The `#` symbol will cause Python to ignore everything from that point until the end of the current line, so inline comments can be created in this way.

```python
x = 1  # assigns value of 1 to x
```

Colon (`:`): Used to indicate the start of a code block, such as in loops, conditionals, and function definitions.

```python
if x > 0:  # Colon starts the block
    print("Positive")
```

## Built-in Functions

### print()

This function looks for the default output device, your terminal, and displays the value passed to it.

```python
print("Hello")
```

### input()

This function looks for the default input device, your keyboard, and captures the value. This value can then be assigned or used.

```python
print("Where do you live?")
location = input()
print("So you live in " + location)
```

Note: The code block above will create a prompt for the user asking "Where do you live?". The user will then enter the response and press the Return key to continue execution of the remaining code. The response entered by the user is stored, returned as an output, or can be assigned to some variable depending on the context of usage.

### len()

This function returns the length or the count of the elements contained within the structure it is applied on. This may be a string, array, list, tuple, dictionary or any sequence.

```python
len("Hello")  # Returns 5
```

### str()

This function can be used to convert the provided value into a String.

```python
str(55)  # Returns '55'
```

### int()

This function can be used to convert the provided value into an int.

```python
int('75')  # Returns 75
```

### float()

This function can be used to convert the provided value into a float.

```python
some_int = 10
float(some_int)  # Returns 10.0
```

## Creating Functions

Functions in Python require a keyword to define them: `def` followed by an identifier (a name). This forms the function signature. The body of the function contains the code to run when the function is called.

```python
def say_hello():
    return "Hello there!"

# With parameters
def say_hello(you):
    return "Hello " + you
```

---
description: React notes and reference about Python Data Types and Syntax Reference.

**Related Notes:**
- [[Python Syntax Basics]]
- [[Python Variables]]
- [[Control Flow in Python]]
- [[Python Functions and Variables]]

**Back to:** [[Meta's Programming in Python Course - Map of Content]]