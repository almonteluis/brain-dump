---
description: Managing mental overhead in software development through understanding human memory limitations
tags: ["cognitive-science", "complexity", "learning", "code-quality"]
created: 2026-04-09
updated: 2026-04-09
---

# Cognitive Load

Understanding how human memory works — and its severe limitations — to write more comprehensible code and learn more effectively.

## Memory Architecture

### Working Memory (Short-Term)

- **Capacity**: 7±2 items (Miller, 1956)
- **Duration**: Seconds without rehearsal
- **Function**: Conscious processing

**Implication**: We can only juggle a handful of concepts at once. Exceed this and comprehension breaks down.

### Long-Term Memory

- **Capacity**: Effectively unlimited
- **Function**: Stores schemas (chunks of related information)
- **Access**: Retrieved into working memory when needed

**Key insight**: A schema takes only ONE slot in working memory, even if it contains dozens of related facts.

## Three Types of Cognitive Load

| Type | Definition | Goal |
|------|------------|------|
| **Intrinsic** | Inherent complexity of the task | Minimize through simpler solutions |
| **Extraneous** | Accidental complexity, poor presentation | Eliminate entirely |
| **Germane** | Load that helps build schemas | Maximize |

Maps to Fred Brooks:
- Intrinsic = Essential complexity
- Extraneous = Accidental complexity

## Software Development Applications

### Code Comprehension

When reading code, working memory must hold:
- Variable values and types
- Function purposes and relationships
- Control flow
- Business logic intent
- Performance characteristics

**Exceed 7 items** → confusion, bugs, wrong mental model

### Writing Comprehensible Code

**Reduce extraneous load**:
- Clear, consistent naming
- Small functions (fit in working memory)
- Limited dependencies (reduce items to track)
- DRY principle (don't repeat information)

**Build on existing schemas**:
- Follow conventions
- Use familiar patterns
- Match code structure to domain concepts

### Learning Codebases

**For novices** (few schemas):
- Start with working examples
- Isolate concepts before connecting them
- Run and modify code actively

**For experts** (many schemas):
- Pattern matching speeds comprehension
- Risk: Expert blind spot (missing novel solutions)
- Benefit: Can handle more complex chunks

## Learning Strategies

### Effective

| Strategy | Why It Works |
|----------|--------------|
| Working examples | Builds schemas through active processing |
| Concept isolation | Prevents working memory overload |
| Deliberate practice | Active construction of schemas |
| Spaced repetition | Strengthens long-term retention |

### Ineffective

| Strategy | Why It Fails |
|----------|--------------|
| Passive reading | Schemas require active construction |
| Katas/general challenges | Transfer to domain problems is poor |
| Memorization without application | No schema formation |

## Team Implications

### Code Review

- Reviewer working memory is limited too
- Large changes exceed capacity
- Staged reviews (architecture → logic → style)

### Onboarding

- Novices need more working memory for basics
- Pair with domain experts for schema transfer
- Document domain concepts (ubiquitous language)

### Architecture

- Bounded contexts limit what must be held in mind
- APIs reduce surface area
- Monoliths risk exceeding working memory at scale

## Related

- [[cognitive-load-theory]] — Source summary
- [[essential-complexity]] — Fred Brooks concept
- [[split-attention-effect]] — Documentation pitfalls
- [[schema-theory]] — Long-term memory organization
- [[working-memory]] — 7±2 limitation

## Resources

- [Cognitive Load Theory in Software Development](https://thevaluable.dev/cognitive-load-theory-software-developer/) — Matthieu Cneude
- [The Magical Number Seven](https://github.com/Phantas0s/alexandria-library/blob/master/teaching_learning/_PAPERS/1956_magical_number_seven_plus_minus_two.pdf) — Miller (1956)
- [No Silver Bullet](http://worrydream.com/refs/Brooks-NoSilverBullet.pdf) — Brooks
