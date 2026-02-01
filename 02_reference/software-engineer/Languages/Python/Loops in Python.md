---
tags: ["control-flow", "loops", "programming", "python"]description: Notes on Loops in Python and key concepts for reference.
---
#python #programming #loops #control-flow

Loops allow you to execute a block of code repeatedly. Python provides two main types of loops: `for` loops and `while` loops. Each has its own specific use cases and advantages.

## For Loops vs. While Loops: Key Differences

Both loops share several characteristics:

- Both can be used with a variety of data types
- Both can be nested
- Both can be used with the keywords `break` and `continue`

However, there are important differences:

- **For loops** iterate over a sequence of elements, executing the body of the loop for each element in the sequence
- **While loops** execute a segment of code repeatedly while a condition is true

An important distinction is that for loops are suited for objects that have iterable structures (lists, strings, ranges of integers). Individual integers are not iterable, but can be looped over by using the `range()` function. While loops do not iterate per se, rather they watch a truth condition.

## For Loops

A `for` loop in Python is used to iterate over a sequence (such as a list, tuple, dictionary, set, or string) or other iterable objects.

### Basic Syntax

```python
for variable in sequence:
    # body of loop
```

### How For Loops Work

1. The `for` loop takes each item from the sequence and assigns it to the specified variable
2. The code block is executed once for each item in the sequence
3. The loop automatically stops when all items have been processed
4. The number of iterations is known in advance, based on the length of the sequence

### For Loop with range()

The `in` keyword with the `range()` function generates a sequence of integer numbers, which can be used with a for loop to configure the iterations of the code.

The `range()` function can take up to three parameters:

- **Start** (x): Starting index position of the range
    
    - Default is 0
    - The starting index position is included in the range
    - Example: `range(2, y, z)` or `range(x+3, y, z)`
- **Stop** (y): Ending index position of range
    
    - No default value; must be specified
    - The value of the ending index position is excluded from the range
    - To include the ending index number, use `y+1`
    - Example: `range(y)` or `range(x, y+1, z)`
- **Step** (z): Incremental value
    
    - Default is 1
    - Example: `range(x, y, 2)` increments by 2

#### Example of range() Usage

```python
# This loop iterates on the value of "number" in a range
# of 1 to 7 (the upper range limit of 6 is excluded, so +1 has
# been added to include 6 in the range). The incremental value
# is 2. The print() function outputs the value of "number" multiplied by 3.

for number in range(1, 6+1, 2):
    print(number * 3)
# Output: 3, 9, 15
```

#### Common Patterns with range()

```python
# Basic counting from 0 to 4
for i in range(5):  # 0, 1, 2, 3, 4
    print(i)

# Iterating through a list using indexes
fruits = ['apple', 'banana', 'cherry']
for i in range(len(fruits)):
    print(f"Index {i}: {fruits[i]}")
```

#### Common Pitfalls with range()

- Forgetting that the upper limit isn't included in the range
- Iterating over non-sequences (strings are iterable letter by letter, but not word by word)

### Enumerating Items

```python
fruits = ['apple', 'banana', 'cherry']
for index, fruit in enumerate(fruits):
    print(f"Index {index}: {fruit}")
```

## While Loops

A `while` loop executes a block of code as long as a specified condition is `True`.

### Basic Syntax

```python
while condition:
    # Code to execute while condition is True
```

### How While Loops Work

1. The `while` loop evaluates the condition
2. If the condition is `True`, the code inside the loop is executed
3. After executing the code block, the condition is checked again
4. This process continues until the condition becomes `False`
5. The loop may never execute if the condition is initially `False`

### Example: Iterating Through a List with While Loop

```python
favorites = ['Creme Brulee', 'Apple Pie', 'Churros', 'Tiramisú', 'Chocolate Cake']
count = 0

while count < len(favorites):
    print('One of my favorite desserts is', favorites[count])
    count += 1
```

### Important Note

Always ensure that the condition in a `while` loop will eventually become `False`, otherwise you'll create an infinite loop that will never terminate.

## Choosing Between For and While Loops

### Use a For Loop When:

- You need to iterate over a sequence of items
- You know in advance how many times the loop should run
- You want a cleaner, more concise syntax for iteration

### Use a While Loop When:

- You need to repeat based on a condition, not a sequence
- You don't know in advance how many iterations are needed
- You need to implement a loop that might never execute (check condition first)

## Nested Loops

You can place one loop inside another. This is useful for working with multi-dimensional data structures.

### Syntax of Nested For Loops

```python
for x in sequence:
    # start of the outer loop body
    for y in sequence:
        # start of the inner loop body
        # end of the inner loop body
    # continue body of the outer loop
    # end of the outer loop body
```

### Example of Nested For Loops

```python
# This code demonstrates outer and inner loop iterations
# The outer loop runs for range positions [0, 1]
# The inner loop runs for range positions [0, 1, 2, 3] each time the outer loop runs
# So the inner loop executes 8 times in total

for x in range(2):
    print("This is the outer loop iteration number " + str(x))
    for y in range(4):
        print("Inner loop iteration number " + str(y))
```

```python
# Another example for clarity:
for i in range(3):
    for j in range(3):
        print(f"({i}, {j})", end=" ")
    print()  # New line after each row
```

## Loop Control Statements

### Breaking Out of Loops

The `break` statement allows you to exit a loop prematurely:

```python
for i in range(10):
    if i == 5:
        break  # Exit the loop when i equals 5
    print(i)
```

### Skipping Iterations

The `continue` statement allows you to skip the current iteration and proceed to the next one:

```python
for i in range(10):
    if i % 2 == 0:
        continue  # Skip even numbers
    print(i)  # Only prints odd numbers
```

## For Loop with Nested If Statement

### Syntax

```python
for x in sequence:
    # start of body of for loop
    if condition is true:
        # start of body of if-statement
        # end of body of if-statement
    # continue body of for loop
    # end of body of for loop
```

### Example

```python
# This loop iterates through numbers 0 to 6
# The if statement checks if "x" is divisible by 2
# If True, it prints the value of "x"

for x in range(7):
    if x % 2 == 0:
        print(x)
# Output: 0, 2, 4, 6
```

## Loop with Else Clause

Python allows an `else` clause with loops that executes when the loop completes normally (not through a `break`):

```python
for i in range(5):
    print(i)
else:
    print("Loop completed normally")
```

## List Comprehensions

List comprehensions provide a concise way to create lists based on existing lists or sequences, often eliminating the need for explicit loops.

### Traditional For Loop vs. List Comprehension

Using a traditional for loop:

```python
sequence = range(10)
new_list = []
for x in sequence:
    if x % 2 == 0:
        new_list.append(x)
```

Using a list comprehension:

```python
sequence = range(10)
new_list = [x for x in sequence if x % 2 == 0]
```

Both examples create a list of even numbers from 0 to 10: `[0, 2, 4, 6, 8]`. The list comprehension version does this in a single, compact line.

### Syntax for List Comprehension with Conditional

```python
[x for x in sequence if condition]
```

### One-Liner Examples

List comprehensions and certain operations in Python can greatly reduce code complexity.

For example:

```python
print("*" * 8)  # Prints "********"
```

This prints "*" 8 times. The number can be replaced by an integer variable, and to do this with a loop would require several lines of code and run more slowly.

---
description: React notes and reference about Loops in Python.

**Related Notes:**
- [[Control Flow in Python]]
- [[Conditional Statements in Python]]
- [[Python Lists]]
- [[Python Data Structures]]

**Back to:** [[Meta Programming in Python]]