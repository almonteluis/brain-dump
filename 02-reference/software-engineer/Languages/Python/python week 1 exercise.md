---
description: Notes about python week 1 exercise.
tags: #python #exercises #learning #backend #practice
---

# Python Week 1 Exercises


Exercise 1: Basic Variables
Create variables for:

## Exercises


• Your name
• Your age
• Your favorite number
• Whether you like coding (True/False)
Print all of them.

```
name = “Luis”
age = 33
favorite_num = 5

do_you_like_coding = True

print(name)
print(age)
print(favorite_num)
print(f“do you like to code? {do_you_like_coding}“ )
```

## Solutions

Exercise 2: Changing Values

1. Assign a variable x with a number.
2. Change x to a string.
3. Change x to a boolean.
4. Print x after each change.

```
x = 23
print(x)
x = “this is a string”
print(x)
x = True
print(x)
```

Exercise 3: Working with Lists

1. Create a list of three of your favorite foods.
2. Change the second item.
3. Add a new food to the list.
4. Print the final list.
```
fav_foods = [“pizza”, “lemon pepper wings”, “birra tacos”]

fav_foods.insert(1, “Lemon Pepper Wings”)
fav_foods.append(“Sweet and crispy chicken”)

print(fav_foods)

```
  

Exercise 4: Using Type Hints

## Additional Notes

Write a function that takes a number and returns its square. Use type hints in your function definition.
```
def square(num: int) -> int:
    return num ** 2

```
  

Exercise 5: Open-Ended Challenge

Write a small Python program that asks the user for their name and age, then calculates the year they will turn 100.

```
name = input(“what’s your name? ”)
age = int(input(“how old are you? ”))
birth_year = 2025 - age
to100 = birth_year + 100

print(to100)

```