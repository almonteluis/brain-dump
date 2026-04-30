---
description: Microsoft's task automation and configuration management framework with shell and scripting language
tags: [powershell, shell, windows, cli, scripting, concept]
created: 2026-04-30
updated: 2026-04-30
---

# PowerShell

Microsoft's cross-platform task automation solution comprising a command-line shell, scripting language, and configuration management framework. Built on .NET, it works with objects rather than text streams.

## Key Characteristics

- Object-based pipeline (not text-based like bash)
- Cmdlets follow Verb-Noun naming (Get-ChildItem, Where-Object)
- Tab completion for properties based on object types
- Cross-platform (Windows, macOS, Linux)
- Integrated scripting environment (ISE) and VS Code extension

## Common Cmdlets

| Cmdlet | Alias | Purpose |
|--------|-------|---------|
| Get-ChildItem | gci, ls, dir | List files/directories |
| Where-Object | where | Filter objects |
| Select-Object | select | Choose properties |
| Get-Member | gm | List object properties/methods |
| Get-Content | cat, gc | Read file contents |

## Related

- [[powershell-get-childitem-guide]] — find replacement patterns
- [[Bash]] — Unix shell comparison
