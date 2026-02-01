---
description: Python string formatting using format() method with placeholders, f-strings for embedded expressions, and legacy % operator formatting.
tags: ["f-strings", "format-specification-mini-language", "old-string-formatting"]
---


Most programs eventually need to provide some kind of output or feedback to the user. Formatting the output makes it easier to read.

For example, imagine you are working in a farmer’s market and need to generate receipts for your customers. You need to weigh the items, calculate the total price for each item (weight times the price per pound), and then add sales tax to the subtotal. Your first attempt might look like this:
# Here are the items in the customer's basket. Each item is a tuple

# of (item name, weight, price per pound).

#

basket = [

    ("Peaches", 3.0, 2.99),

    ("Pears", 5.0, 1.66),

    ("Plums", 2.5, 3.99)

]

# Calculate the total price for each item (weight times price per pound)

# and add them up to get a subtotal.

#

subtotal = 0.00

for item in basket:

  fruit, weight, unit_price = item

  subtotal += (weight * unit_price)

# Now calculate the sales tax and total bill.

#

tax_rate = 0.06625  # 6.625% sales tax in New Jersey

tax_amt = subtotal * tax_rate

total = subtotal + tax_amt

# Print the receipt for the customer.

#

print("Subtotal:", subtotal)

print("Sales Tax:", tax_amt)

print("Total:", total)

If you run the above code, you’ll notice the output looks a bit messy:

Subtotal: 27.245 

Sales Tax: 1.8049812500000002 

Total: 29.049981250000002

We’d much prefer the output to look like a real register receipt:

Subtotal:     $27.25 

Sales Tax:    $ 1.80

Total:        $29.05

The way to do this in Python is by formatting strings in your output.

Python offers different ways to format strings. In the [Formatting Strings video](https://www.coursera.org/learn/python-crash-course/lecture/cx2nU/formatting-strings), we explained the format() method. In this reading, we'll highlight three different ways of formatting strings. For this course you need to know only the format() method. But on the internet, you might find any of the three, so it's a good idea to know that the others exist.

## **Using the** format() **method**

The format() method takes a string containing special placeholders, called the format string, and replaces the special placeholder characters {} with the value of the arguments you pass. The arguments are converted to strings if they weren’t already. The number of arguments you pass must exactly match the number of placeholders in the format string:

fruit = "peaches"
weight = 3.0
per_pound = 2.99
output = "You are buying {} pounds of {} at {} per pound.".format(weight, fruit, per_pound)
print(output)

You are buying 3.0 pounds of peaches at 2.99 per pound.

You can also consume the arguments to format() in any order you want by specifying the index inside the placeholder. As with lists and arrays, the index always starts with 0. You can even use an index more than once. Here you can see we’re using the second argument twice. 

output = "{1} are {2} per pound, and you have {0} pounds of {1}.".format(weight, fruit, per_pound)
print(output)
Peaches are 2.99 per pound, and you have 3.0 pounds of peaches.
A third option for the placeholders is to use field names instead of indexes. This can make your code much more readable.

output = {fruit} are {price} per pound, and you have {weight} pounds of {fruit}.".format(weight=weight, fruit=fruit, price=per_pound)

print(output)

Peaches are 2.99 per pound, and you have 3.0 pounds of peaches.

Python also gives you many options to control the appearance of the output. Remember the messy output from the first example? You can have Python automatically round things up to the nearest penny and produce nice output by using a _formatting expression_. In the example below, the code tells Python to round up the numbers to two decimal places.

# Print the receipt for the customer. The format string ":10,.2f" 
# works as follows:
#   - ":10" makes the output 10 characters wide.
#   - "," inserts thousands separators between groups of digits.
#   - ".2" limits the output to two digits after the decimal.
#   - "f" tells Python to expect a floating-point number.


print("Subtotal:     $ {:10,.2f}".format(subtotal))
print("Sales Tax:   $ {:10,.2f}".format(tax_amt))
print("Total:           $ {:10,.2f}".format(total))
Subtotal:                $    27.25 
Sales Tax:              $     1.80 
Total:                      $    29.05

Everything inside the placeholder after the “:” colon is part of the formatting expression. The expression “:10,.2f” means “make the output 10 characters wide, use digit separators if the amount is over 1000, output no more than 2 digits after the decimal, and expect the input to be a floating-point decimal number”. 

The following table gives you some more examples of formatting expressions:

**Formatting expressions**

|Expr|Meaning|Example|
|---|---|---|
|{:d}|integer value|"{0:.0f}".format(10.5) → '10'|
|{:.2f}|floating point with that many decimals|'{:.2f}'.format(0.5) → '0.50'|
|{:.2s}|string with that many characters|'{:.2s}'.format('Python') → 'Py'|
|{:<6s}|string aligned to the left that many spaces|'{:<6s}'.format('Py') → 'Py    '|
|{:>6s}|string aligned to the right that many spaces|'{:>6s}'.format('Py') → '    Py'|
|{:^6s}|string centered in that many spaces|'{:^6s}'.format('Py') → '  Py  '|

Check out the official documentation for [all available expressions](https://docs.python.org/3/library/string.html#format-specification-mini-language).

## **Formatted string literals (Optional)**

The formatted string literal feature, added in Python 3.6, isn’t used a lot yet. Again, it's included here in case you run into it in the future, but it's not needed for this or any upcoming courses.

A formatted string literal or f-string is a string that starts with 'f' or 'F' before the quotes. These strings might contain {} placeholders using expressions like the ones used for format() method strings.

The important difference between f-strings and the format() method is that f-strings take the value of the variables from the current context, instead of taking the values from parameters.

Examples:

>>> name = "Micah"

>>> print(f'Hello {name}')

Hello Micah

> item = "Purple Cup"
>  amount = 5
>  price = amount * 3.25
> print(f'Item: {item} - Amount: {amount} - Price: {price:.2f}')

Item: Purple Cup - Amount: 5 - Price: 16.25

Check out the official documentation for [f-strings](https://docs.python.org/3/reference/lexical_analysis.html#f-strings).

## **Old string formatting (Optional)**

The format() method was introduced in Python 2.6. Before that, the % (modulo) operator could be used to get a similar result. Although this method is **no longer recommended** for new code, you might come across it in someone else's code. This is what it looks like:

	"base string with %s placeholder" % variable

The % (modulo) operator returns a copy of the string where the placeholders indicated by % followed by a formatting expression are replaced by the variables after the operator. 

To replace more than one value, you need to supply the values as a tuple. The formatting expression must match the value type. 

	"base string with %d and %d placeholders" % (value1, value2)

Variables can also be replaced by name using a dictionary syntax (you’ll learn about dictionaries in an upcoming video).

	print("%(var1)d %(var2)d" % {"var1":value1, "var2":value2})

The formatting expressions are mostly the same as those of the format() method. 

	"Item: %s - Amount: %d - Price: %.2f" % (item, amount, price)

Check out the official documentation for [old string formatting](https://docs.python.org/3/library/stdtypes.html#old-string-formatting).