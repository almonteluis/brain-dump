---
description: Python lists are dynamic arrays that store references, support mixed types, and provide methods for adding, removing, and iterating elements.
tags: ["data-structures", "programming", "python"]
---
#python #data-structures #programming

>In Python, a list is a built-in dynamic sized array (automatically grows and shrinks). We can store all types of items (including another list) in a list. A list may contain mixed type of items, this is possible because a list mainly stores references at contiguous locations and actual items maybe stored at different locations.

## Key Characteristics of Lists

- List can contain duplicate items.
- Lists in Python are **Mutable**. Hence, we can modify, replace or delete the items.
- Lists are **ordered**. They maintain the order of elements based on how they are added.
- Accessing items in List can be done directly using their position (index), starting from 0.

## Example

```python
# Creating a Python list with different data types
a = [10, 20, "GfG", 40, True]

print(a)

# Accessing elements using indexing
print(a[0])  # 10
print(a[1])  # 20
print(a[2])  # "GfG"
print(a[3])  # 40
print(a[4])  # True

# Checking types of elements
print(type(a[2]))  # str
print(type(a[4]))  # bool
```

**Explanation:**

- The list contains a mix of integers (10, 20, 40), a string ("GfG") and a boolean (True).
- The list is printed and individual elements are accessed using their indexes (starting from 0).
- `type(a[2])` confirms "GfG" is a str.
- `type(a[4])` confirms True is a bool.

## Note: Lists Store References, Not Values

Each element in a list is not stored directly inside the list structure. Instead, the list stores references (pointers) to the actual objects in memory.

- The list itself is a container with references (addresses) to the actual values.
- Python internally creates separate objects for values, then stores their memory addresses inside the list.
- This means that modifying an element doesn't affect other elements but can affect the referenced object if it is mutable.

## Creating a List

Here are some common methods to create a list:

### Using Square Brackets

```python
# List of integers
a = [1, 2, 3, 4, 5]

# List of strings
b = ['apple', 'banana', 'cherry']

# Mixed data types
c = [1, 'hello', 3.14, True]

print(a)
print(b)
print(c)
```

**Output:**

```
[1, 2, 3, 4, 5]
['apple', 'banana', 'cherry']
[1, 'hello', 3.14, True]
```

### Using list() Constructor

We can also create a list by passing an iterable (like a string, tuple or another list) to list() function.

```python
# From a tuple
a = list((1, 2, 3, 'apple', 4.5))  

print(a)
```

**Output:**

```
[1, 2, 3, 'apple', 4.5]
```

### Creating List with Repeated Elements

We can create a list with repeated elements using the multiplication operator.

```python
# Create a list [2, 2, 2, 2, 2]
a = [2] * 5

# Create a list [0, 0, 0, 0, 0, 0, 0]
b = [0] * 7

print(a)
print(b)
```

**Output:**

```
[2, 2, 2, 2, 2]
[0, 0, 0, 0, 0, 0, 0]
```

## Accessing List Elements

Elements in a list can be accessed using indexing. Python indexes start at 0, so a[0] will access the first element, while negative indexing allows us to access elements from the end of the list. Like index -1 represents the last elements of list.

```python
a = [10, 20, 30, 40, 50]

# Access first element
print(a[0])    

# Access last element
print(a[-1])
```

**Output:**

```
10
50
```

## Adding Elements into List

We can add elements to a list using the following methods:

- `append()`: Adds an element at the end of the list.
- `extend()`: Adds multiple elements to the end of the list.
- `insert()`: Adds an element at a specific position.

```python
# Initialize an empty list
a = []

# Adding 10 to end of list
a.append(10)  
print("After append(10):", a)  

# Inserting 5 at index 0
a.insert(0, 5)
print("After insert(0, 5):", a) 

# Adding multiple elements [15, 20, 25] at the end
a.extend([15, 20, 25])  
print("After extend([15, 20, 25]):", a) 
```

**Output:**

```
After append(10): [10]
After insert(0, 5): [5, 10]
After extend([15, 20, 25]): [5, 10, 15, 20, 25]
```

## Updating Elements in List

We can change the value of an element by accessing it using its index.

```python
a = [10, 20, 30, 40, 50]

# Change the second element
a[1] = 25 

print(a)  
```

**Output:**

```
[10, 25, 30, 40, 50]
```

## Removing Elements from List

We can remove elements from a list using:

- `remove()`: Removes the first occurrence of an element.
- `pop()`: Removes the element at a specific index or the last element if no index is specified.
- `del` statement: Deletes an element at a specified index.

```python
a = [10, 20, 30, 40, 50]

# Removes the first occurrence of 30
a.remove(30)  
print("After remove(30):", a)

# Removes the element at index 1 (20)
popped_val = a.pop(1)  
print("Popped element:", popped_val)
print("After pop(1):", a) 

# Deletes the first element (10)
del a[0]  
print("After del a[0]:", a)  
```

**Output:**

```
After remove(30): [10, 20, 40, 50]
Popped element: 20
After pop(1): [10, 40, 50]
After del a[0]: [40, 50]
```

## Iterating Over Lists

We can iterate the Lists easily by using a for loop or other iteration methods. Iterating over lists is useful when we want to do some operation on each item or access specific items based on certain conditions.

### Using for Loop

```python
a = ['apple', 'banana', 'cherry']

# Iterating over the list
for item in a:
    print(item)
```

**Output:**

```
apple
banana
cherry
```

## Nested Lists in Python

A nested list is a list within another list, which is useful for representing matrices or tables. We can access nested elements by chaining indexes.

```python
matrix = [
    [1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]
]

# Access element at row 2, column 3
print(matrix[1][2]) 
```

**Output:**

```
6
```

## Common List Methods

|Method|Description|
|---|---|
|`append(x)`|Adds an element to the end of the list|
|`extend(iterable)`|Extends the list by appending elements from the iterable|
|`insert(i, x)`|Inserts an element at the specified position|
|`remove(x)`|Removes the first occurrence of a value|
|`pop([i])`|Removes the element at the given position or the last element if no index is specified|
|`clear()`|Removes all items from the list|
|`index(x)`|Returns the index of the first occurrence of a value|
|`count(x)`|Returns the number of occurrences of a value|
|`sort()`|Sorts the list in-place|
|`reverse()`|Reverses the elements of the list in-place|
|`copy()`|Returns a shallow copy of the list|

## List Comprehensions

List comprehensions provide a concise way to create lists:

```python
# Create a list of squares
squares = [x**2 for x in range(10)]
print(squares)

# Create a list with condition
even_squares = [x**2 for x in range(10) if x % 2 == 0]
print(even_squares)
```

**Output:**

```
[0, 1, 4, 9, 16, 25, 36, 49, 64, 81]
[0, 4, 16, 36, 64]
```

## Time Complexity

|Operation|Time Complexity|
|---|---|
|Access by Index|O(1)|
|Append|O(1) (amortized)|
|Insert|O(n)|
|Delete|O(n)|
|Search|O(n)|
|Length|O(1)|

This makes lists efficient for operations that add or access elements at the end, but less efficient for insertions or deletions in the middle of large lists.