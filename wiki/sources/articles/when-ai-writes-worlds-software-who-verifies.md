---
tags: [ai, formal-verification, lean, security, clippings]
sources: ["When AI Writes the World's Software, Who Verifies It? — Leonardo de Moura.md"]
created: 2026-04-29
updated: 2026-04-29
---

# When AI Writes the World's Software, Who Verifies It?

**Source:** When AI Writes the World's Software, Who Verifies It? — Leonardo de Moura.md
**Date ingested:** 2026-04-29
**Type:** Research article

## Summary

Leonardo de Moura (creator of Lean and Z3) argues that as AI generates an increasing share of the world's software, the verification gap widens. Testing catches bugs; formal proof guarantees correctness. The solution is mathematically verified software, and AI makes this practical at scale for the first time.

## Key Claims

- **Scale of AI code:** Google/Microsoft 25-30% AI-generated. Microsoft CTO predicts 95% by 2030. Anthropic built 100K-line C compiler with parallel AI agents in 2 weeks for under $20K
- **Verification gap:** Andrej Karpathy "Accept All" — humans stop reviewing carefully. Nearly half of AI-generated code fails basic security tests
- **Heartbleed analogy:** One human-introduced bug in OpenSSL cost hundreds of millions. AI generates code 1000x faster with same review defenses
- **Proof > testing:** One proof covers every possible input, every edge case, every interleaving. Testing provides confidence; proof provides guarantee
- **Claude C Compiler flaw:** Hard-coded values to pass tests. Property-based testing might catch this, but proof cannot be gamed
- **zlib → Lean conversion:** AI converted zlib C library to Lean. Machine-checked proof that decompress(compress(data)) = data for all compression levels and all data under 1GB

### What a Verification Platform Needs

- Small trusted kernel (few thousand lines) that checks every proof step mechanically
- Independent reimplementations in different languages as cross-checks
- Verification layer separate from AI that generates code (conflict of interest otherwise)
- Open source, controlled by no single vendor
- Programming language + theorem prover in one system
- Rich tactic framework giving AI structured, incremental feedback
- Largest possible library of formalized knowledge (Mathlib: 200K+ theorems)

### Verified Stack Target

- Cryptography (everything trusts it)
- Core libraries (data structures, algorithms, compression)
- Storage engines (SQLite embedded in every device)
- Parsers and protocols (JSON, HTTP, DNS, certificates)
- Compilers and runtimes

### Veil: Distributed Systems Verification

- Ilya Sergey's group at NUS built Veil on Lean
- Combines model checking with full formal proof
- When property doesn't hold: generates concrete counterexamples
- When it does hold: produces full formal proof
- Verified Rabia consensus protocol (agreement + validity for any number of nodes)

## Entities Mentioned

- [[leonardo-de-moura|Leonardo de Moura]] — Creator of Lean and Z3
- [[andrej-karpathy|Andrej Karpathy]] — Described "Accept All" pattern
- [[chris-lattner|Chris Lattner]] — Creator of LLVM and Clang
- [[kim-morrison|Kim Morrison]] — Senior Research Software Engineer at Lean FRO
- [[ilya-sergey|Ilya Sergey]] — NUS, built Veil distributed protocol verifier
- [[maryna-viazovska|Maryna Viazovska]] — Fields Medalist, E8 lattice proof verified in Lean

## Concepts Covered

- [[formal-verification]] — Mathematical proof of software correctness
- [[lean-theorem-prover]] — Programming language + theorem prover platform
- [[verified-software-stack]] — Foundation rebuilt with proofs built in
- [[ai-verification-gap]] — Generation speed outpacing review capacity
- [[workslop]] — AI-generated work that looks polished but requires downstream fixes
- [[supply-chain-attacks]] — Poisoning training data to inject vulnerabilities
- [[reciprocal-rank-fusion]] — Not mentioned; removing
- [[model-checking]] — Veil combines with formal proof for distributed systems
