---
description: Python sets are unordered collections with no duplicates, using hash tables for efficient membership testing and mathematical operations.
tags: ["data-structures", "programming", "python"]
---
#python #data-structures #programming

A Set in Python is used to store a collection of items with the following properties:

- **No duplicate elements.** If you try to insert the same item again, it overwrites the previous one.
- **An unordered collection.** When we access all items, they are accessed without any specific order and we cannot access items using indexes as we do in lists.
- **Internally uses hashing** that makes sets efficient for search, insert and delete operations. This gives a major advantage over a list for problems with these operations.
- **Mutable**, meaning we can add or remove elements after their creation, though the individual elements within the set cannot be changed directly.

## Basic Example of Python Sets

```python
s = {10, 50, 20}
print(s)
print(type(s))
```

**Output:**

```
{10, 50, 20}
<class 'set'>
```

**Note:** There is no specific order for set elements to be printed.

## Creating Sets

### Using Curly Braces

```python
# Creating a set with curly braces
colors = {"red", "green", "blue"}
print(colors)
```

### Using the set() Constructor

The Python `set()` method is used for type casting.

```python
# Typecasting list to set
s = set(["a", "b", "c"])
print(s)

# Adding element to the set
s.add("d")
print(s)
```

**Output:**

```
{'c', 'b', 'a'}
{'d', 'c', 'b', 'a'}
```

## Unique Values and Immutability

Python sets cannot have duplicate values. While you cannot modify the individual elements directly, you can still add or remove elements from the set.

```python
# A set cannot have duplicate values
s = {"Geeks", "for", "Geeks"}
print(s)

# This will cause an error because we cannot change items by index
# s[1] = "Hello"
```

**Output:**

```
{'Geeks', 'for'}
```

Attempting to modify an element by index would generate:

```
TypeError: 'set' object does not support item assignment
```

## Heterogeneous Elements in Python Sets

Python sets can store heterogeneous elements, i.e., a set can store a mixture of string, integer, boolean, etc. datatypes.

```python
# Python example demonstrate that a set
# can store heterogeneous elements
s = {"Geeks", "for", 10, 52.7, True}
print(s)
```

**Output:**

```
{True, 'for', 'Geeks', 10, 52.7}
```

## Python Frozen Sets

Frozen sets in Python are immutable objects that only support methods and operators that produce a result without affecting the frozen set or sets to which they are applied. It can be created with the `frozenset()` method in Python.

While elements of a set can be modified at any time, elements of the frozen set remain the same after creation.

If no parameters are passed, it returns an empty frozenset.

```python
# Normal Set
s = set(["a", "b", "c"])
print("Normal Set")
print(s)

# A frozen set
fs = frozenset(["e", "f", "g"])
print("\nFrozen Set")
print(fs)

# Uncommenting below line would cause error as
# we are trying to add element to a frozen set
# fs.add("h")
```

**Output:**

```
Normal Set
{'a', 'c', 'b'}

Frozen Set
frozenset({'e', 'g', 'f'})
```

## Internal Working of Sets

Sets in Python are implemented using a data structure known as a hash table. If multiple values are present at the same index position, then the value is appended to that index position to form a linked list.

In Python, sets are implemented using a dictionary with dummy variables, where keys are the members of the set, with optimizations for time complexity.

## Methods for Sets

### Adding Elements to Python Sets

Insertion in the set is done through the `set.add()` function, where an appropriate record value is created to store in the hash table. Similar to checking for an item, the time complexity is O(1) on average. However, in worst case it can become O(n).

```python
# Creating a Set
people = {"Jay", "Idrish", "Archi"}
print("People:", end=" ")
print(people)

# This will add Daxit in the set
people.add("Daxit")

# Adding elements to the set using iterator
for i in range(1, 6):
    people.add(i)

print("\nSet after adding element:", end=" ")
print(people)
```

**Output:**

```
People: {'Idrish', 'Archi', 'Jay'}

Set after adding element: {1, 2, 3, 4, 5, 'Daxit', 'Archi', 'Jay', 'Idrish'}
```

### Union Operation on Python Sets

Two sets can be merged using the `union()` function or `|` operator. Both hash table values are accessed and traversed with merge operation performed on them to combine the elements, while duplicates are removed. The time complexity is O(len(s1) + len(s2)) where s1 and s2 are two sets whose union needs to be done.

```python
people = {"Jay", "Idrish", "Archil"}
vampires = {"Karan", "Arjun"}
dracula = {"Deepanshu", "Raju"}

# Union using union() function
population = people.union(vampires)
print("Union using union() function")
print(population)

# Union using "|" operator
population = people | dracula
print("\nUnion using '|' operator")
print(population)
```

**Output:**

``` python
Union using union() function
{'Idrish', 'Arjun', 'Jay', 'Karan', 'Archil'}

Union using '|' operator
{'Idrish', 'Deepanshu', 'Raju', 'Jay', 'Archil'}
```

### Intersection Operation on Python Sets

This can be done through `intersection()` or `&` operator. Common elements are selected. They are similar to iteration over the hash lists and combining the same values on both tables. The time complexity is `O(min(len(s1), len(s2)))` where `s1` and `s2` are two sets whose intersection needs to be found.

```python
set1 = set()
set2 = set()

for i in range(5):
    set1.add(i)

for i in range(3, 9):
    set2.add(i)

# Intersection using intersection() function
set3 = set1.intersection(set2)
print("Intersection using intersection() function")
print(set3)

# Intersection using "&" operator
set3 = set1 & set2
print("\nIntersection using '&' operator")
print(set3)
```

**Output:**

```
Intersection using intersection() function
{3, 4}

Intersection using '&' operator
{3, 4}
```

### Finding Differences of Sets in Python

To find differences between sets, we use the `difference()` method or `-` operator. This is similar to finding differences in a linked list. The time complexity of finding difference s1 - s2 is `O(len(s1)).`

```python
set1 = set()
set2 = set()

for i in range(5):
    set1.add(i)

for i in range(3, 9):
    set2.add(i)

# Difference of two sets using difference() function
set3 = set1.difference(set2)
print("Difference of two sets using difference() function")
print(set3)

# Difference of two sets using '-' operator
set3 = set1 - set2
print("\nDifference of two sets using '-' operator")
print(set3)
```

**Output:**

```
Difference of two sets using difference() function
{0, 1, 2}

Difference of two sets using '-' operator
{0, 1, 2}
```

### Clearing Python Sets

The `clear()` method empties the whole set in place.

```python
set1 = {1, 2, 3, 4, 5, 6}

print("Initial set")
print(set1)

# This method will remove all the elements of the set
set1.clear()

print("\nSet after using clear() function")
print(set1)
```

**Output:**

```
Initial set
{1, 2, 3, 4, 5, 6}

Set after using clear() function
set()
```

## Limitations of Python Sets

There are two major pitfalls in Python sets:

1. The set doesn't maintain elements in any particular order.
2. Only instances of immutable types can be added to a Python set.

## Time Complexity of Set Operations

|Operation|Average case|Worst Case|Notes|
|---|---|---|---|
|x in s|O(1)|O(n)||
|Union s\|t|O(len(s)+len(t))|||
|Intersection s&t|O(min(len(s), len(t))|O(len(s) * len(t))|Replace "min" with "max" if t is not a set|
|Multiple intersection s1&s2&..&sn||(n-1)*O(l) where l is max(len(s1),..,len(sn))||
|Difference s-t|O(len(s))|||

## Operators for Sets

Sets and frozen sets support the following operators:

|Operators|Notes|
|---|---|
|key in s|Containment check|
|key not in s|Non-containment check|
|s1 == s2|s1 is equivalent to s2|
|s1 != s2|s1 is not equivalent to s2|
|s1 <= s2|s1 is subset of s2|
|s1 < s2|s1 is proper subset of s2|
|s1 >= s2|s1 is superset of s2|
|s1 > s2|s1 is proper superset of s2|
|s1 \| s2|The union of s1 and s2|
|s1 & s2|The intersection of s1 and s2|
|s1 – s2|The set of elements in s1 but not s2|
|s1 ^ s2|The set of elements in precisely one of s1 or s2 (symmetric difference)|

## Common Set Methods

|Method|Description|
|---|---|
|`add(elem)`|Adds an element to the set|
|`remove(elem)`|Removes an element from the set. Raises KeyError if element doesn't exist|
|`discard(elem)`|Removes an element from the set if it exists|
|`pop()`|Removes and returns an arbitrary element from the set|
|`clear()`|Removes all elements from the set|
|`union(other_set)`|Returns a new set with elements from both sets|
|`intersection(other_set)`|Returns a new set with elements common to both sets|
|`difference(other_set)`|Returns a new set with elements in this set but not in the other|
|`symmetric_difference(other_set)`|Returns a new set with elements in either set but not in both|
|`issubset(other_set)`|Returns True if this set is a subset of the other set|
|`issuperset(other_set)`|Returns True if this set is a superset of the other set|
|`isdisjoint(other_set)`|Returns True if both sets have no elements in common|
|`copy()`|Returns a shallow copy of the set|

## Common Applications of Sets

Sets are particularly useful for:

1. Removing duplicates from a collection
2. Membership testing (checking if an item exists)
3. Mathematical operations like union, intersection, difference
4. Finding unique elements in a collection
5. Eliminating duplicate entries
6. Data deduplication
7. Tracking visited elements in algorithms