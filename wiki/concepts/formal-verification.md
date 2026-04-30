---
tags: [security, lean, proof, correctness]
sources: ["when-ai-writes-worlds-software-who-verifies"]
created: 2026-04-29
updated: 2026-04-29
---

# Formal Verification

Mathematical proof that software behaves correctly for all possible inputs.

## Why It Matters Now

- AI generates code 1000× faster than humans with same review defenses
- Nearly half of AI-generated code fails basic security tests
- Testing provides confidence; proof provides guarantee
- One proof covers every input, every edge case, every interleaving

## The Lean Approach

- Small trusted kernel (few thousand lines) checks every proof step
- Programming language + theorem prover in one system
- Rich tactic framework gives AI structured, incremental feedback
- Mathlib: 200K+ formalized theorems

## Real Examples

- **zlib → Lean:** AI converted C library. Machine-checked proof that decompress(compress(data)) = data
- **Veil:** Distributed protocol verifier. Verified Rabia consensus for any number of nodes
- **AWS Cedar:** Authorization policy engine formally verified
- **Microsoft SymCrypt:** Cryptographic library being rewritten in Rust with Lean proofs

## Key Principle

Verification layer must be separate from AI that generates code. Independent verification is a security architecture requirement.

## Related

- [[lean-theorem-prover]] — Platform for verified software
- [[ai-verification-gap]] — Generation speed outpacing review
- [[supply-chain-security]] — Poisoning risks in AI-generated code
