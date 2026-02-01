---
tags: ["conditionals", "control-flow", "if-statements", "python"]description: Notes on Conditional Statements and key concepts for reference.
---
#python #control-flow #conditionals #if-statements

Conditional statements allow your programs to make decisions based on specific conditions. Python provides three main conditional statements: `if`, `else`, and `elif` (else if).

## The `if` Statement

The `if` statement executes a block of code only if a specified condition evaluates to `True`.

### Syntax
```python
if condition:
    # Code to execute if condition is True
```

### Example: Light Switch

In this example, we use Boolean values to represent the state of a light switch:
- `True` means the light is on
- `False` means the light is off

```python
# Light is currently off
current = False

if current:
    current = False
    print('Turning light off')

if not current:
    current = True
    print('Turning light on')
```

In this code:
1. We initialize `current` as `False` (light is off)
2. The first `if` checks if the light is on, but since it's not, this block is skipped
3. The second `if` checks if the light is off (`not current`), which is true, so it turns the light on

## The `if-else` Statement

The `else` statement provides an alternative block of code to execute when the `if` condition is `False`.

### Syntax
```python
if condition:
    # Code to execute if condition is True
else:
    # Code to execute if condition is False
```

### Example: Improved Light Switch

We can improve our previous example by using an `if-else` structure:

```python
current = False

if current:
    current = False
    print('Turning light off')
else: 
    current = True
    print('Turning light on')
```

This makes the code more concise and logically connected, as both branches relate to the same condition.

## The `elif` Statement

The `elif` (else if) statement allows you to check multiple conditions in sequence. It's useful when you have several conditions to evaluate.

### Syntax
```python
if condition1:
    # Code to execute if condition1 is True
elif condition2:
    # Code to execute if condition1 is False and condition2 is True
else:
    # Code to execute if all conditions are False
```

### Example: Customer Discount System

Here's an example of a customer discount system with multiple conditions:

```python
loyalty_customer = True
total_bill = 124

if loyalty_customer and total_bill > 100:
    # give 20% discount
    total_bill = total_bill - (float(total_bill) / 100) * 20
elif total_bill > 100:
    # give 10% discount
    total_bill = total_bill - (float(total_bill) / 100) * 10
else:
    # sorry no discount, 5% service charge applied.
    print('Sorry, no discount...')
    total_bill = total_bill + (float(total_bill) / 100) * 5

print('Total Bill: ', float(total_bill))
```

In this example:
1. First, we check if the customer is a loyalty member AND spent over $100
   - If both conditions are true: 20% discount
2. If the first condition isn't met, we check if they spent over $100
   - If true: 10% discount
3. If neither condition is met, no discount is applied and a 5% service charge is added

## Nested Conditionals

You can also nest conditional statements inside other conditional statements to create more complex decision trees.

```python
x = 10

if x > 5:
    print("x is greater than 5")
    if x > 8:
        print("x is also greater than 8")
    else:
        print("x is not greater than 8")
else:
    print("x is not greater than 5")
```

## Tips for Using Conditionals

1. **Indentation matters**: Python uses indentation to define code blocks, so make sure your indentation is consistent
2. **Be careful with comparisons**: Use `==` for equality, not `=` (which is assignment)
3. **Compound conditions**: Use `and`, `or`, and `not` to combine conditions
4. **Truthiness**: In Python, empty values (like `0`, `""`, `[]`, `None`) evaluate to `False` in a condition
5. **One-line conditionals**: For simple cases, you can use a more compact form:
   ```python
   result = "Even" if x % 2 == 0 else "Odd"
   ```

---
description: React notes and reference about Conditional Statements.

**Related Notes:**
- [[Python Operators]]
- [[Logical Operators in Python]]
- [[Control Flow in Python]]
- [[Loops in Python]]

**Back to:** [[Meta's Programming in Python Course - Map of Content]]