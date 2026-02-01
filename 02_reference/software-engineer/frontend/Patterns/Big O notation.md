---
description: Notes and reference material about  Big  O notation.
tags: #algorithms #big-o #complexity #performance #computer-science
---

# Big O Notation

## Overview




Briefly:

1. O(1) means in constant time - independent of the number of items.
2. O(N) means in proportion to the number of items.
3. O(log N) means a time proportional to log(N)

Basically any 'O' notation means an operation will take time up to a maximum of k*f(N)  
where:

> k is a constant multiplier
> 
> f() is a function that depends on N


> It refers to how complex your program is, i.e., how many operations it takes to actually solve a problem. O(n) means that each operation takes the same number of steps as the items in your list, which for insertion, is very slow. Likewise, if you have O(n^2) means that any operation takes "n" squared number of steps to accomplish, and so on... The "O" is for Order of Magnitude, and the the expression in the parentheses is always related to the number of items being manipulated in the procedure. [refer](https://stackoverflow.com/a/1909353)

