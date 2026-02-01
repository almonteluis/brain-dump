---
description: Notes about O(n).
tags: #algorithms #big-o #complexity #performance #time-complexity
---

# Big O Notation



description: Notes and reference material about  O(n).

## Overview

---


O(n) is a part of Big O notation, which is a theoretical way to describe the time or space complexity of an algorithm as a function of the size of its input. O(n) represents linear time complexity, meaning that the runtime of an algorithm grows in direct proportion to the amount of data it receives. [[1](https://www.simplilearn.com/big-o-notation-in-data-structure-article#:~:text=O(n)%20represents%20linear%20time%20complexity%2C%20where%20the,runtime%20grows%20exponentially%20with%20the%20input%20size.), [2](https://medium.com/@seancoyne/what-is-big-o-notation-o-n-time-and-space-complexity-841367face05), [3](https://xlinux.nist.gov/dads/HTML/bigOnotation.html), [4](https://lankydan.dev/2017/04/23/learning-big-o-notation-with-on-complexity#:~:text=O(n)%20represents%20the%20complexity%20of%20a%20function,or%20false%20after%20reading%20all%20n%20elements.), [5](https://www.datacamp.com/tutorial/big-o-notation-time-complexity#:~:text=Linear%20time:%20O(N)%20If%20the%20list%20has,to%20process%20the%20data%20should%20also%20doubled.)]
  

Here are some examples of how O(n) is used: [[6](https://www.geeksforgeeks.org/what-does-big-o-on-complexity-mean/)]

Finding a number in a list

If you want to find a number in a list, you might need to go through each element one by one. This process would take O(n) time because you're performing N checks for an input of size N.

Finding the maximum in an array

If you want to find the largest number in an array, you might need to go through each number in the array. This process would also take O(n) time because the number of iterations needed increases as the number of elements in the array increases.

  

Here are some other examples of Big O notation: [[1](https://www.simplilearn.com/big-o-notation-in-data-structure-article#:~:text=O(n)%20represents%20linear%20time%20complexity%2C%20where%20the,runtime%20grows%20exponentially%20with%20the%20input%20size.)]

- O(n^2): Represents quadratic time complexity [[1](https://www.simplilearn.com/big-o-notation-in-data-structure-article#:~:text=O(n)%20represents%20linear%20time%20complexity%2C%20where%20the,runtime%20grows%20exponentially%20with%20the%20input%20size.)]
- O(2^n): Represents exponential time complexity [[1](https://www.simplilearn.com/big-o-notation-in-data-structure-article#:~:text=O(n)%20represents%20linear%20time%20complexity%2C%20where%20the,runtime%20grows%20exponentially%20with%20the%20input%20size.)]
- O(log n): Represents an algorithm that takes time proportional to the logarithm of the input size [[7](https://tutorials.eu/olog-n-algorithm-example/#:~:text=O(log%20n)%20time%20complexity%20refers%20to%20an,as%20the%20size%20of%20the%20input%20increases.)]

  

_Generative AI is experimental._

## Examples

[1] [https://www.simplilearn.com/big-o-notation-in-data-structure-article](https://www.simplilearn.com/big-o-notation-in-data-structure-article#:~:text=O(n)%20represents%20linear%20time%20complexity%2C%20where%20the,runtime%20grows%20exponentially%20with%20the%20input%20size.)

## Notes

[2] [https://medium.com/@seancoyne/what-is-big-o-notation-o-n-time-and-space-complexity-841367face05](https://medium.com/@seancoyne/what-is-big-o-notation-o-n-time-and-space-complexity-841367face05)

[3] [https://xlinux.nist.gov/dads/HTML/bigOnotation.html](https://xlinux.nist.gov/dads/HTML/bigOnotation.html)

[4] [https://lankydan.dev/2017/04/23/learning-big-o-notation-with-on-complexity](https://lankydan.dev/2017/04/23/learning-big-o-notation-with-on-complexity#:~:text=O(n)%20represents%20the%20complexity%20of%20a%20function,or%20false%20after%20reading%20all%20n%20elements.)

[5] [https://www.datacamp.com/tutorial/big-o-notation-time-complexity](https://www.datacamp.com/tutorial/big-o-notation-time-complexity#:~:text=Linear%20time:%20O(N)%20If%20the%20list%20has,to%20process%20the%20data%20should%20also%20doubled.)

[6] [https://www.geeksforgeeks.org/what-does-big-o-on-complexity-mean/](https://www.geeksforgeeks.org/what-does-big-o-on-complexity-mean/)

[7] [https://tutorials.eu/olog-n-algorithm-example/](https://tutorials.eu/olog-n-algorithm-example/#:~:text=O(log%20n)%20time%20complexity%20refers%20to%20an,as%20the%20size%20of%20the%20input%20increases.)

  

_Not all images can be exported from Search._