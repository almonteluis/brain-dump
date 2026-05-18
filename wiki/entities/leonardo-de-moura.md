---
description: Leonardo de Moura — creator of Lean and Z3. The person building the mathematical infrastructure for a world where code correctness can be *proven*, not just tested.
tags: [person, formal-verification, lean, microsoft]
sources: ["when-ai-writes-worlds-software-who-verifies"]
created: 2026-04-29
updated: 2026-05-17
---

# Leonardo de Moura

Creator of the Lean theorem prover and Z3 SMT solver. Senior Principal Researcher at Microsoft Research. If formal verification ever becomes mainstream, de Moura built the foundation.

## Key Facts

- **Lean:** Programming language + theorem prover. 12+ years of development. Won the ACM SIGPLAN 2025 Software Award. De facto choice for AI-based mathematical reasoning.
- **Z3:** Widely-used SMT solver. Powers verification across industry.
- **Lean FRO:** 20-person team maintaining the platform.
- **Mathlib:** 200,000+ formalized theorems, 750+ contributors. The largest formalized math library in existence.
- **Enterprise use:** AWS verified Cedar auth engine with Lean. Microsoft verifying SymCrypt in Rust with Lean.
- **zlib → Lean:** AI converted the zlib C library to Lean with machine-checked correctness proofs. Not theoretical — done.

## Why He Matters

De Moura's work is the answer to the question "who verifies the AI-written code?" [[trust-boundaries-formal-verification-and-bloat|Formal verification]] + [[dependency-bloat|dependency reduction]] are two strategies for the same problem: the production binary contains code you didn't write. Lean lets you prove correctness mathematically instead of hoping your tests caught everything.

## Sources

- [[when-ai-writes-worlds-software-who-verifies]]
