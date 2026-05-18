---
description: "Documents Folder Reorganization Plan"
tags: ['research']
raw_file: "stateful-watching-adleman.md"
created: 2026-05-17
---

# Documents Folder Reorganization Plan

## Proposed New Structure

```
Documents/
├── Development/           # All coding projects, organized by purpose
│   ├── Learning/          # Tutorials, courses, practice projects
│   ├── Tools/             # Utilities, automation, productivity apps
│   ├── Work/              # Professional/job-related projects
│   └── Personal/          # Side projects, experiments
├── Learning/              # Educational content (non-code)
│   └── Courses/           # Video courses, tutorials
├── Music Production/      # All DAW and plugin data consolidated
│   ├── Native Instruments/
│   ├── iZotope/
│   ├── FeelYourSound/
│   ├── Image-Line/
│   ├── Max 8/
│   ├── rekordbox/
│   └── Blackmagic Design/
├── Media/                 # Media files (keep existing)
│   ├── Audio/
│   ├── Images/
│   └── Video/
├── Personal/              # Personal documents
│   ├── Taxes/
│   ├── Financial/
│   ├── Docs/
│   └── Resumes/
└── Archive/               # Inactive items
```

## Detailed Move Operations

### 1. Create New Directory Structure
- Create `Development/Learning/`, `Development/Tools/`, `Development/Work/`, `Development/Personal/`
- Create `Learning/Courses/`
- Create `Music Production/`
- Create `Archive/`

### 2. Move Music Production Folders (consolidate scattered music software)
| Source | Destination |
|--------|-------------|
| `/Documents/Native Instruments/` | `/Documents/Music Production/Native Instruments/` |
| `/Documents/iZotope/` | `/Documents/Music Production/iZotope/` |
| `/Documents/FeelYourSound/` | `/Documents/Music Production/FeelYourSound/` |
| `/Documents/Projects/Active/Native Instruments/` | `/Documents/Music Production/Native Instruments Projects/` |
| `/Documents/Projects/Active/Image-Line/` | `/Documents/Music Production/Image-Line/` |
| `/Documents/Projects/Active/Max 8/` | `/Documents/Music Production/Max 8/` |
| `/Documents/Projects/Active/rekordbox/` | `/Documents/Music Production/rekordbox/` |
| `/Documents/Projects/Active/AI-Music/` | `/Documents/Music Production/AI-Music/` |
| `/Documents/Projects/Active/Music/` | `/Documents/Music Production/Music Projects/` |
| `/Documents/Projects/Active/Blackmagic Design/` | `/Documents/Music Production/Blackmagic Design/` |
| `/Documents/Media/iZotope/` | Merge with `/Documents/Music Production/iZotope/` |

### 3. Move Learning/Courses
| Source | Destination |
|--------|-------------|
| `/Documents/Personal/Courses/` | `/Documents/Learning/Courses/` |

### 4. Categorize Development Projects by Purpose

**Learning projects** → `Development/Learning/`
- beginners-typescript-tutorial
- cs50
- frontendmentor
- greatFrontEnd
- leetcode
- microsoft-fullstack-certification
- newClassroom
- odinProject
- roadmap
- traintoCode
- course
- Google IT Automation with Python
- modern_languages
- rust

**Tools/Automation** → `Development/Tools/`
- Auto_job_applier_linkedIn
- EasyApplyBot
- EasyApplyBot2
- github-activity-generator
- interview-coder
- keep-presence
- vscode-extension
- gpt-researcher (from Personal)
- llama-agent (from Projects/llama)
- post_banger

**Work/Professional** → `Development/Work/`
- centivo
- gocollette.com
- careerPilot
- AI Sourcing
- sourcing-app
- FBA Sourcing (from Projects/Active)
- LeadTracker

**Personal Projects** → `Development/Personal/`
- Assembly Endgame
- bookRecommendation
- boilerplate-npm
- Chef Claude
- e-plantShopping
- event-app
- fintech-banking
- Frontend-Luis-Almonte
- Here-We-Go-Again-Counter
- InventoryApp
- movieverse
- onePoint
- react-o
- react-practice
- storybook
- task-tracking
- Tenzies
- tiny-homes
- vanlife react
- warp-community
- web-booking-application
- website
- C#

### 5. Move Personal Items
| Source | Destination |
|--------|-------------|
| `/Documents/Projects/Active/Resumes/` | `/Documents/Personal/Resumes/` |
| `/Documents/Projects/Active/SPC & TRUSTS/` | `/Documents/Personal/SPC & TRUSTS/` |
| `/Documents/Projects/Active/Discharging Debts/` | `/Documents/Personal/Discharging Debts/` |
| `/Documents/Personal/Taxes-20241227105123/` | Merge into `/Documents/Personal/Taxes/` |

### 6. Clean Up Loose Files at Root
| File | Action |
|------|--------|
| `Game 1.game`, `Game 2.game` | Move to `Media/Games/` or `Archive/` |
| `Untitled Diagram.drawio` | Move to `Personal/Docs/` or `Archive/` |
| `desktop.ini` | Delete (Windows artifact) |
| `organize_docs.py` | Move to `Archive/` (superseded) |
| `directory_moves.json` | Move to `Archive/` (old log) |

### 7. Clean Up Empty/Redundant Folders
- Delete `/Documents/Software/SWE/` (empty)
- Delete `/Documents/Projects/Active/$RECYCLE.BIN/` (Windows artifact)
- Remove `/Documents/Software/` after moving contents (will be replaced by Development)
- Remove `/Documents/Projects/` after moving all contents

### 8. Handle Cline and VM folders
| Source | Destination |
|--------|-------------|
| `/Documents/Projects/Active/Cline/` | `/Documents/Development/Tools/Cline/` |
| `/Documents/Projects/Active/VM/` | `/Documents/Archive/VM/` (or Development if active) |

## Verification Steps
1. Verify all folders exist after creation
2. Confirm no data loss by comparing file counts before/after
3. Test that music software still finds its data (may need symlinks if apps have hardcoded paths)

## Rollback
A `reorganization_log.json` file will be created to track all moves, enabling undo if needed.

