---
tags: ["conversion", "data-types", "python", "type-casting"]description: Notes on Type Casting and key concepts for reference.
---
#python #data-types #type-casting #conversion

There are some scenarios in which a given value's data type needs to be changed to some other data type. This process is known as **type casting**, or more informally, **data type conversion**.

## Implicit Type Conversion

Python automatically converts some data types during operations, which is called **implicit type conversion**.

### Example: Comparing Numbers

```python
print(10 == 10)    # True
print(10 == 10.00) # True
```

Even though 10 is an integer and 10.00 is a float, Python considers them equal. This is because Python performs implicit type conversion when comparing values of different but compatible types.

### Example: Adding Numbers of Different Types

```python
print(10 + 10.0)      # 20.0
print(type(10 + 10.0)) # <class 'float'>
```

When Python performs operations involving integers and floats, it implicitly converts the integer type to a float, and then completes the operation. The result is always a float when at least one operand is a float.

## Explicit Type Conversion

Explicit type conversion happens when you manually convert a value from one type to another using built-in functions.

### Common Type Conversion Functions

- `int()`: Converts to integer
- `float()`: Converts to float
- `str()`: Converts to string
- `bool()`: Converts to boolean
- `list()`: Converts to list
- `tuple()`: Converts to tuple
- `set()`: Converts to set
- `dict()`: Converts to dictionary

### Example: User Input

When receiving input from users, Python always stores it as a string, even if the user types in numbers:

```python
user_num_1 = input('First number is: ')
user_num_2 = input('Second number is: ')
user_sum = user_num_1 + user_num_2
print(user_sum)
```

If the user enters "5" for both inputs, the output will be "55" instead of 10, because the inputs are being concatenated as strings.

### Converting Input to Numbers

To perform mathematical operations on user input, you need to convert the strings to numbers first:

```python
user_num_1 = input('First number is: ')
user_num_2 = input('Second number is: ')
user_sum = float(user_num_1) + float(user_num_2)
print(user_sum)
```

Now if the user enters "5.5" for both inputs, the output will be 11.0 as expected.

## Type Safety in String Concatenation

Python enforces type safety, meaning you can't directly concatenate strings with other data types like integers or floats:

```python
num_1 = input('First number is: ')
num_2 = input('Second number is: ')
user_sum = float(num_1) + float(num_2)
print("The sum of: " + num_1 + " and " + num_2 + " is " + user_sum)  # Error!
```

This will throw an error:
```
TypeError: can only concatenate str (not "float") to str
```

### Solution: Convert Everything to Strings

When concatenating different data types in a string, you need to convert non-string values to strings first:

```python
n1 = input('First number is: ')
n2 = input('Second number is: ')
user_sum = float(n1) + float(n2)
print("The sum of " + str(float(n1)) + " and " + str(float(n2)) + " is " + str(user_sum))
```

Output: `The sum of 5.5 and 5.5 is 11.0`

## An Alternative Approach: String Formatting

Rather than concatenating strings with the `+` operator, Python offers more elegant ways to format strings:

### Using f-strings (Python 3.6+)

```python
n1 = input('First number is: ')
n2 = input('Second number is: ')
user_sum = float(n1) + float(n2)
print(f"The sum of {float(n1)} and {float(n2)} is {user_sum}")
```

### Using .format() method

```python
n1 = input('First number is: ')
n2 = input('Second number is: ')
user_sum = float(n1) + float(n2)
print("The sum of {} and {} is {}".format(float(n1), float(n2), user_sum))
```

## Type Casting Considerations

- Not all conversions are possible. For example, converting a string like "hello" to an integer will raise a `ValueError`.
- Information can be lost during conversion. For example, when converting a float to an integer, the decimal portion is truncated.
- Type casting can affect the performance of your code, especially in large loops or data processing tasks.

---
description: React notes and reference about Type Casting.

**Related Notes:**
- [[Python Data Types and Syntax Reference]]
- [[Python Variables]]
- [[User Input and Output in Python]]
- [[String Formatting in Python]]

**Back to:** [[Meta's Programming in Python Course - Map of Content]]