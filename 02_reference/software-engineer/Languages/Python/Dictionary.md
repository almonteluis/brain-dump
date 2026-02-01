---
description: Python dictionaries store key-value pairs with constant time operations, ordered insertion since Python 3.7, and require immutable keys.
tags: ["data-structures", "programming", "python"]
---
#python #data-structures #programming

_Last Updated: 12 Feb, 2025_

A Python dictionary is a data structure that stores the value in **key: value** pairs. Values in a dictionary can be of any data type and can be duplicated, whereas keys can't be repeated and must be _immutable_.

**Example:** Here, the data is stored in key:value pairs in dictionaries, which makes it easier to find values.

```python
d = {1: 'Geeks', 2: 'For', 3: 'Geeks'}
print(d)
```

**Output**

```
{1: 'Geeks', 2: 'For', 3: 'Geeks'}
```

## How to Create a Dictionary

In Python, a dictionary can be created by placing a sequence of elements within curly **{}** braces, separated by a 'comma'.

```python
# create dictionary using { }
d1 = {1: 'Geeks', 2: 'For', 3: 'Geeks'}
print(d1)

# create dictionary using dict() constructor
d2 = dict(a = "Geeks", b = "for", c = "Geeks")
print(d2)
```

**Output**

```
{1: 'Geeks', 2: 'For', 3: 'Geeks'}
{'a': 'Geeks', 'b': 'for', 'c': 'Geeks'}
```

## Key Characteristics

- From Python 3.7 Version onward, Python dictionaries are Ordered.
- **Dictionary keys are case sensitive:** the same name but different cases of Key will be treated distinctly.
- **Keys must be immutable:** This means keys can be strings, numbers, or tuples but not lists.
- **Keys must be unique:** Duplicate keys are not allowed and any duplicate key will overwrite the previous value.
- Dictionary internally uses **Hashing**. Hence, operations like search, insert, delete can be performed in **Constant Time**.

## Accessing Dictionary Items

We can access a value from a dictionary by using the **key** within square brackets or **get()** method.

```python
d = { "name": "Alice", 1: "Python", (1, 2): [1,2,4] }

# Access using key
print(d["name"])

# Access using get()
print(d.get("name"))  
```

**Output**

```
Alice
Alice
```

## Adding and Updating Dictionary Items

We can add new key-value pairs or update existing keys by using assignment.

```python
d = {1: 'Geeks', 2: 'For', 3: 'Geeks'}

# Adding a new key-value pair
d["age"] = 22

# Updating an existing value
d[1] = "Python dict"

print(d)
```

**Output**

```
{1: 'Python dict', 2: 'For', 3: 'Geeks', 'age': 22}
```

## Removing Dictionary Items

We can remove items from dictionary using the following methods:

- **del**: Removes an item by key.
- **pop()**: Removes an item by key and returns its value.
- **clear()**: Empties the dictionary.
- **popitem()**: Removes and returns the last key-value pair.

```python
d = {1: 'Geeks', 2: 'For', 3: 'Geeks', 'age':22}

# Using del to remove an item
del d["age"]
print(d)

# Using pop() to remove an item and return the value
val = d.pop(1)
print(val)

# Using popitem to removes and returns
# the last key-value pair.
key, val = d.popitem()
print(f"Key: {key}, Value: {val}")

# Clear all items from the dictionary
d.clear()
print(d)
```

**Output**

```
{1: 'Geeks', 2: 'For', 3: 'Geeks'}
Geeks
Key: 3, Value: Geeks
{}
```

## Iterating Through a Dictionary

We can iterate over **keys** (using **keys() method**), **values** (using **values() method**) or both (using **items() method**) with a **for loop**.

```python
d = {1: 'Geeks', 2: 'For', 'age':22}

# Iterate over keys
for key in d:
    print(key)

# Iterate over values
for value in d.values():
    print(value)

# Iterate over key-value pairs
for key, value in d.items():
    print(f"{key}: {value}")
```

**Output**

```
1
2
age
Geeks
For
22
1: Geeks
2: For
age: 22
```

## Nested Dictionaries

Dictionaries can contain other dictionaries, creating a nested structure.

**Example of Nested Dictionary:**

```python
d = {1: 'Geeks', 2: 'For',
        3: {'A': 'Welcome', 'B': 'To', 'C': 'Geeks'}}

print(d)
```

**Output**

```
{1: 'Geeks', 2: 'For', 3: {'A': 'Welcome', 'B': 'To', 'C': 'Geeks'}}
```

## Common Dictionary Methods

|Method|Description|
|---|---|
|`clear()`|Removes all items from the dictionary|
|`copy()`|Returns a shallow copy of the dictionary|
|`fromkeys(seq[, value])`|Creates a new dictionary with keys from seq and values set to value|
|`get(key[, default])`|Returns the value for key if key is in the dictionary, else default|
|`items()`|Returns a view object of the dictionary's key-value pairs|
|`keys()`|Returns a view object of the dictionary's keys|
|`pop(key[, default])`|Removes the element with the specified key|
|`popitem()`|Removes and returns the last inserted key-value pair|
|`setdefault(key[, default])`|Returns the value of the specified key. If the key does not exist, insert the key with the specified value|
|`update([other])`|Updates the dictionary with elements from another dictionary object or key-value pairs|
|`values()`|Returns a view object of the dictionary's values|

## Dictionary Comprehension

Similar to list comprehensions, dictionary comprehensions provide a concise way to create dictionaries:

```python
# Create a dictionary of squares
squares = {x: x*x for x in range(6)}
print(squares)

# Create a dictionary with condition
even_squares = {x: x*x for x in range(6) if x % 2 == 0}
print(even_squares)
```

**Output**

```
{0: 0, 1: 1, 2: 4, 3: 9, 4: 16, 5: 25}
{0: 0, 2: 4, 4: 16}
```

## Time Complexity

|Operation|Time Complexity|
|---|---|
|Access|O(1)|
|Insert|O(1)|
|Delete|O(1)|
|Search|O(1)|

This constant time complexity makes dictionaries highly efficient for lookups and operations when the key is known.