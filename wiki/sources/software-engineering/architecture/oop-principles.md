---
description: The four pillars of object-oriented programming explained with Python examples
tags: ["source", "oop", "object-oriented", "programming", "python", "encapsulation", "polymorphism", "inheritance", "abstraction"]
sources: ["OOP Principles.md"]
created: 2026-04-09
updated: 2026-04-09
---

# OOP Principles

**Source:** raw/02_reference/software-engineer/Architecture/Patterns/OOP Principles.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

The four main pillars of object-oriented programming introduced by Alan Kay in the 1960s: Encapsulation, Polymorphism, Inheritance, and Abstraction.

## The Four Pillars

### 1. Encapsulation
- Methods and variables within bounds of a class
- Establishes scope (global vs local)
- Information hiding using access modifiers
- Python uses single `_` for protected, double `__` for private

### 2. Polymorphism
- Something that can have many forms
- Same operator/function behaves differently based on context
- Example: `*` operator works on strings, integers, and lists

### 3. Inheritance
- Child classes inherit from parent classes
- Python uses `class Child(Parent)` syntax
- Method Resolution Order (MRO) determines execution flow

### 4. Abstraction
- Hiding important and unnecessary information
- Abstract classes and methods from `abc` module
- Provides blueprint for other classes

## Code Example

```python
class Alpha:
    def __init__(self):
        self._a = 2.   # Protected member
        self.__b = 2.  # Private member

# Abstract class
from abc import ABC
class ClassName(ABC):
    pass
```

## Concepts Covered

- [[Encapsulation]] — Data hiding and scope management
- [[Polymorphism]] — Multiple forms of objects/operators
- [[Inheritance]] — Class hierarchy and code reuse
- [[Abstraction]] — Blueprint patterns via abstract classes
- [[MRO]] — Method Resolution Order in Python
