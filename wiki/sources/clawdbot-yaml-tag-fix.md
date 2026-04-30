---
description: "YAML tag fix workflow"
tags: [clawdbot, yaml, obsidian, frontmatter, fix, workflow]
sources: [clawdbot/yaml-tag-fix-workflow.md]
created: 2026-04-09
updated: 2026-04-09
---

# YAML Tag Fix Workflow

**Source:** raw/02_reference/tools/clawdbot/yaml-tag-fix-workflow.md
**Date ingested:** 2026-04-09
**Type:** workflow

## Summary

Workflow for detecting and fixing YAML frontmatter errors where tags appear on the same line as description in Obsidian notes.

## The Problem

Obsidian throws a `YAMLParseError: Nested mappings are not allowed in compact mappings` when `tags:` appears on the same line as `description:` in YAML frontmatter.

```yaml
# WRONG - causes YAML parse error
description: Some text.tags: ["tag1", "tag2"]

# CORRECT
description: Some text
tags: ["tag1", "tag2"]
```

The key insight: `.tags:` (with a dot before) shouldn't exist in valid YAML — `tags:` should be on its own line.

## Detection

Find all markdown files with this pattern:

```bash
grep -r "description:.*\.tags:" --include="*.md" .
```

## Fix Options

### Option 1: One-liner (bash + sed)

```bash
find . -name "*.md" -type f -exec sed -i '' 's/\(description: [^[]*\)\.tags: /\1\ tags: /g' {} +
```

### Option 2: Python Script

```python
#!/usr/bin/env python3
import os
import re
from pathlib import Path

def fix_yaml_error(file_path):
    """Fix YAML where tags: is on same line as description:"""
    with open(file_path, 'r') as f:
        content = f.read()
    original = content

    # Pattern: description: text.tags: ["..."]
    content = re.sub(
        r'(description: [^\n]+?)\.tags: (\[[^\]]+\])',
        r'\1\n\2',
        content
    )

    if content != original:
        with open(file_path, 'w') as f:
            f.write(content)
        print(f"Fixed: {file_path}")
        return True
    return False

def main():
    vault_path = "."
    md_files = Path(vault_path).rglob("*.md")
    fixed_count = 0

    for file in md_files:
        if fix_yaml_error(file):
            fixed_count += 1

    print(f"\nTotal files fixed: {fixed_count}")

if __name__ == "__main__":
    main()
```

## How It Works

1. **Detect:** `grep -r "description:.*\.tags:"` finds files with the error
2. **Fix:** Split the line at `.tags:` → put `tags:` on new line
3. **Verify:** Run grep again to confirm no matches

## Related

- `06_system/standardize-yaml.py` - Script to standardize YAML frontmatter
- `02_reference/tools/yaml-descriptions-layer-2.md` - Layer 2 progressive disclosure

## Concepts Covered

- [[YAML Frontmatter]] — Metadata standards
- [[YAML Errors]] — Common parsing issues
- [[Fix Workflow]] — Automated correction
- [[Obsidian Compatibility]] — Format requirements

## Related

- [[yaml-descriptions-layer-2]]
- [[obsidian-claude-101]]
