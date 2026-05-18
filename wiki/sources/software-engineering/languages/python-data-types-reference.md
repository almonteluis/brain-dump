---
description: Python data types and syntax reference covering basic types, flow control, indentation, comments, and built-in functions
tags:
  - source
  - python
  - data/types
  - syntax
  - reference
sources:
  - Python Data Types and Syntax Reference.md
created: 2026-04-09
updated: 2026-04-09
---

# Python Data Types and Syntax Reference

**Source:** raw/02_reference/software-engineer/Languages/Python/Python Data Types and Syntax Reference.md
**Date ingested:** 2026-04-09
**Type:** reference

## Summary

Quick reference for common Python data types and syntax elements including basic types, comparison operators, indentation rules, comments, and built-in functions.

## Basic Data Types

| Data Type | Meaning | Example |
|-----------|---------|---------|
| string | Text | 'Hello', 'Testing 123' |
| integer | Numbers | -5, 4, 3, 2, 0 |
| float | Decimals | 2.4, 5.2, 1000.00 |

## Comparison Operators

| Operator | Meaning |
|----------|---------|
| == | Equals |
| != | Not Equal |
| < | Less than |
| > | Greater than |
| <= | Less than or Equal |
| >= | Greater than or Equal |

## Indentation

Python uses indentation (not braces) to define code blocks:

```python
if x > 0:  # Colon starts the block
    print("Positive")  # Indented
else:
    print("Non-positive")
```

## Comments

```python
# Single line comment
x = 1  # Inline comment
```

## Built-in Functions

| Function | Purpose |
|----------|---------|
| `print()` | Display output |
| `input()` | Capture user input |
| `len()` | Return length/count |
| `str()` | Convert to string |
| `int()` | Convert to integer |
| `float()` | Convert to float |

## Creating Functions

```python
def say_hello():
    return "Hello there!"

# With parameters
def say_hello(you):
    return "Hello " + you
```

## Concepts Covered

- [[Python]] — Programming language
- [[Data Types]] — String, integer, float
- [[Indentation]] — Python's block structure
- [[Functions]] — Defining and calling functions
- [[Built-in Functions]] — Core Python functions
