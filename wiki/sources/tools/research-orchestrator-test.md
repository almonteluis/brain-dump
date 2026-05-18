---
description: "Correct. Keep this contained."
tags: ['research']
raw_file: "Research orchestrator test.md"
created: 2026-05-17
---

Correct. Keep this contained.

Create a fresh folder outside your existing vault — something like `~/research/orchestrator-test/` — drop the three files in there, run Second Brain and graphify against that folder only. Nothing touches your real `raw/` or `wiki/`.

Reasons to keep it isolated for this run:

1. **Clean signal.** If you dump these into your existing raw, graphify will find connections across your entire knowledge base — frontend notes, BrainBreak architecture, every web clip you've ever saved. That's actually useful long-term, but for _this test_ it muddies whether graphify is finding real signal in the orchestrator research or just surfacing your own existing notes back at you.
    
2. **Reversible.** If the test flops, you delete one folder. No cleanup in your real vault.
    
3. **It mirrors the real workflow.** Once you confirm graphify earns its place, _then_ you point it at your full vault with confidence. This run is the dress rehearsal.
    

So the structure for the test:

```
~/research/orchestrator-test/
├── raw/
│   ├── orchestrator-three-ring.md
│   ├── references-seed.md
│   └── (article content from `graphify add` if you run those)
├── wiki/          ← Second Brain output
└── graphify-out/  ← graphify output
```

After the test, if it's a yes, you've got two reasonable migration paths: either keep ed-tech research as its own vault permanently (cleaner topical separation), or fold it into your main vault as a `student-pace/` subfolder. That's a decision for after the test, not before.

[[test-run-kickoff]]
[[orchestrator-three-ring]]
[[references-seed]]
