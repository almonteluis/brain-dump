---
description: "Comprehensive Big-O complexity reference for common data structures and sorting algorithms"
tags: [software-engineering, algorithms, complexity, computer-science, reference]
sources: [Big-O Algorithm Complexity Cheat Sheet (Know Thy Complexities!) @ericdrowell.md]
created: 2026-04-22
updated: 2026-04-22
---

# Big-O Algorithm Complexity Cheat Sheet

**Source:** Big-O Algorithm Complexity Cheat Sheet (Know Thy Complexities!) @ericdrowell.md
**Date ingested:** 2026-04-22
**Type:** reference

## Summary

A comprehensive reference chart of Big-O time and space complexities for common data structure operations and array sorting algorithms. Created by Eric Rowell as a study aid for technical interviews at major tech companies (Google, Facebook, Yahoo, LinkedIn, Uber). Covers average and worst-case scenarios for access, search, insertion, and deletion across 14 data structures and 13 sorting algorithms.

## Key Claims

- Hash tables offer O(1) average-case search, insertion, and deletion, but degrade to O(n) worst case
- B-Trees and AVL/Red-Black trees guarantee O(log n) worst-case performance across all operations
- Quicksort has O(n log n) average case but degrades to O(n^2) worst case, with O(log n) space
- Mergesort and Timsort guarantee O(n log n) worst case at the cost of O(n) space
- Heapsort offers O(n log n) worst case with only O(1) space, making it the only optimal in-place sort
- Simple sorts (Bubble, Insertion, Selection) are all O(n^2) average but useful for small or nearly-sorted inputs

## Data Structure Complexity Overview

| Data Structure | Average Access | Average Search | Average Insert | Average Delete | Worst Space |
|---|---|---|---|---|---|
| Array | O(1) | O(n) | O(n) | O(n) | O(n) |
| Hash Table | N/A | O(1) | O(1) | O(1) | O(n) |
| BST | O(log n) | O(log n) | O(log n) | O(log n) | O(n) |
| B-Tree | O(log n) | O(log n) | O(log n) | O(log n) | O(n) |
| Red-Black Tree | O(log n) | O(log n) | O(log n) | O(log n) | O(n) |
| Skip List | O(log n) | O(log n) | O(log n) | O(log n) | O(n log n) |

## Sorting Algorithm Complexity Overview

| Algorithm | Best | Average | Worst | Space |
|---|---|---|---|---|
| Quicksort | O(n log n) | O(n log n) | O(n^2) | O(log n) |
| Mergesort | O(n log n) | O(n log n) | O(n log n) | O(n) |
| Timsort | O(n) | O(n log n) | O(n log n) | O(n) |
| Heapsort | O(n log n) | O(n log n) | O(n log n) | O(1) |
| Bubble Sort | O(n) | O(n^2) | O(n^2) | O(1) |
| Insertion Sort | O(n) | O(n^2) | O(n^2) | O(1) |
| Radix Sort | O(nk) | O(nk) | O(nk) | O(n+k) |

## Complexity Quality Scale

| Rating | Complexities |
|---|---|
| Excellent | O(log n), O(1) |
| Good | O(n) |
| Fair | O(n log n) |
| Bad | O(n^2) |
| Horrible | O(2^n), O(n!) |

## Concepts Covered

- [[big-o-notation]] — the foundational concept behind this reference
- [[dsa-learning-journey]] — broader DSA study context

## Cross-References

- [[big-o-notation]] — existing wiki page covering Big O fundamentals
- [[connection-pattern-pagination]] — practical application of complexity in pagination design
- [[autocomplete-system-design]] — system design applying these complexity trade-offs
