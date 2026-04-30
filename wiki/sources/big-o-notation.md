---
description: "Big O notation for algorithm complexity analysis"
tags: [software-engineering, algorithms, complexity, computer-science]
sources: [Big O notation.md]
created: 2026-04-09
updated: 2026-04-09
---

# Big O Notation

**Source:** raw/02_reference/software-engineer/frontend/Patterns/Big O notation.md
**Date ingested:** 2026-04-09
**Type:** technical reference

## Summary

Big O notation describes the complexity of an algorithm — how its runtime or space requirements grow relative to input size. It provides an upper bound on growth rate.

## Key Claims

- Describes algorithm efficiency independent of hardware
- Focuses on growth rate as input approaches infinity
- Common notations: O(1), O(log N), O(N), O(N log N), O(N²)
- Represents maximum time/space required

## Common Complexities

| Notation | Name | Description |
|----------|------|-------------|
| O(1) | Constant | Same time regardless of input size |
| O(log N) | Logarithmic | Doubling input has minimal effect |
| O(N) | Linear | Time grows proportionally with input |
| O(N log N) | Linearithmic | Common in efficient sorting |
| O(N²) | Quadratic | Time grows with square of input |
| O(2^N) | Exponential | Extremely rapid growth |

## Examples

```javascript
// O(1) - Constant
function getFirst(arr) {
  return arr[0];
}

// O(N) - Linear
function findMax(arr) {
  let max = arr[0];
  for (let i = 1; i < arr.length; i++) {
    if (arr[i] > max) max = arr[i];
  }
  return max;
}

// O(N²) - Quadratic
function bubbleSort(arr) {
  for (let i = 0; i < arr.length; i++) {
    for (let j = 0; j < arr.length - 1; j++) {
      if (arr[j] > arr[j + 1]) {
        [arr[j], arr[j + 1]] = [arr[j + 1], arr[j]];
      }
    }
  }
}
```

## Formal Definition

> O(f(N)) means an operation takes time up to a maximum of k*f(N), where k is a constant multiplier and f() is a function that depends on N (input size).

## Concepts Covered

- [[big-o-notation]]
- [[algorithm-analysis]]
- [[time-complexity]]
- [[space-complexity]]
