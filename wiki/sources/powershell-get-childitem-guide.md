---
description: PowerShell Get-ChildItem as a find replacement with filtering, regex, and property-based queries
tags: [powershell, shell, find, windows, cli]
sources: [PowerShell equivalent of find.md]
created: 2026-04-30
updated: 2026-04-30
---

# PowerShell Get-ChildItem Guide

**Source:** PowerShell equivalent of find.md
**Date ingested:** 2026-04-30
**Type:** article

## Summary

Article by Jessitron comparing bash `find` with PowerShell's `Get-ChildItem` (alias `gci`). Demonstrates how PowerShell's object pipeline enables more composable and scalable file searching compared to find's argument-specific syntax.

## Key Claims

- `gci -r -fi <pattern>` is the PowerShell equivalent of `find . -name '<pattern>'`
- `-Recurse` (`-r`) traverses directories; `-Filter` (`-fi`) selects by name with wildcards (not regex)
- For regex filtering: pipe to `Where-Object` (`where`) with `-match`
- PowerShell scales better in complexity because filtering uses the same language as everything else
- `find` arguments are specific to `find` and do not transfer to other bash commands
- Tab completion works for property names based on the type of objects in the pipeline

## Common Patterns

```powershell
# Find files by name pattern
gci -r -fi *.jar

# Regex matching on name
gci -r | where Name -match '\.jar$'

# Filter by file size
gci -r | where Length -gt 3000

# Filter by last access time
gci -r | where LastAccessTime -gt (Get-Date).AddHours(-1)

# Complex conditional with code block
gci -r | where { $_.Length -gt (3 * 1024) -or $_.LastWriteTime -gt "04/23/2020" }

# Condense output to paths only
gci -r -Include '*.json' | Select FullName

# List all available properties
gci -r | Get-Member
```

## Entities Mentioned

- [[PowerShell]] — Windows shell and scripting language
- [[Bash]] — Unix shell (comparison target)
- [[Get-ChildItem]] — PowerShell file listing cmdlet
- [[Where-Object]] — PowerShell filtering cmdlet

## Concepts Covered

- [[powershell-pipeline]] — object-based piping vs text-based piping
- [[file-search-patterns]] — wildcard vs regex filtering
- [[powershell-property-filtering]] — filtering by file metadata (size, time, etc.)
