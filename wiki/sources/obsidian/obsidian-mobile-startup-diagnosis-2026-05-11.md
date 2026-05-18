---
description: "Diagnosis report — why Obsidian mobile takes ~5 minutes to become usable after desktop sync. Read-only investigation, findings + fix plan."
tags: ['research']
raw_file: "obsidian-mobile-startup-diagnosis-2026-05-11.md"
created: 2026-05-17
---

# Mobile startup bottleneck report

## Section 1 — Most likely causes (ranked)

**1. iCloud Drive sync materialization across 1,597 files**
Vault sits in `~/Library/Mobile Documents/iCloud~md~obsidian/` (Obsidian's iCloud Drive container, not Obsidian Sync — see core plugin note below). On mobile cold-start after desktop changes, iCloud must reconcile file metadata then download placeholders → bytes on-demand. With 1,597 files, ~343 MB total, this dominates the "Loading workspace" stall. Obsidian mobile waits for the vault index before becoming usable.

**2. Mobile `file-explorer` sortOrder `byModifiedTime` + `autoReveal: false`**
`.obsidian/workspace-mobile.json:98` → `"sortOrder": "byModifiedTime"`. Forces mobile to stat **every** vault file's mtime before rendering the file tree. On iCloud this can trigger materialization of metadata for files that haven't been downloaded yet.

**3. Mobile workspace `lastOpenFiles` contains broken/stale paths**
`workspace-mobile.json:237-289` lists 53 entries. Many reference dirs that **do not exist**: `00_inbox/`, `05_archive/`, `06_system/`, `Software Engineer/`, `Clippings/`, `marvin/`, `Untitled 1.md`–`Untitled 5.canvas`. Mobile spends time resolving each; on iCloud each failed lookup may also fault through to cloud metadata.

**4. Vault root polluted with 627 files in `raw/` — 153 JSONs, 48 `.gz`, 120 binaries (incl. 25 MB GIF, 11 MB GIF, 21 MB `.m4a`)**
Obsidian indexes every file even when it can't render them. Raw graph artefacts (`raw/graph.json` 1 MB, `raw/graph.html` 800 KB), SHA-256 named JSON dumps, and undecoded hex-URL filenames are all sync overhead with zero Obsidian value.

**5. `graphify-out/` at vault root with 323 JSON files (313 in `cache/`), ~5.7 MB**
Lives inside the synced vault. iCloud syncs all 313 cache files to mobile and Obsidian indexes them. Pure waste — graphify is a desktop-only tool.

## Section 2 — Evidence

### Vault scale
| Metric | Value |
|---|---|
| Total files (excl. `.git`) | 1,597 |
| Markdown | 918 |
| JSON | 503 (153 in `raw/`, 323 in `graphify-out/`, plus `.obsidian/`) |
| `.gz` (jpg.gz article snapshots) | 48 |
| Total size | 343 MB |
| `raw/` size | 69 MB (627 files at depth 1) |
| `graphify-out/` size | 5.7 MB |
| `.git` size | 258 MB (locally only — see note 7) |

### `.obsidian/` files
- `.obsidian/workspace-mobile.json` 9.3 KB, 290 lines, 12 leaves, **53 lastOpenFiles entries with many dead paths**
- `.obsidian/workspace.json` 11.6 KB, 354 lines, 13 leaves
- `.obsidian/app.json:30` → `"attachmentFolderPath": "05_archive"` — dir does not exist
- `.obsidian/app.json:1` → `"alwaysUpdateLinks": true` — full link scan on rename
- `.obsidian/bookmarks.json` — 3 of 4 bookmarks point at non-existent `Software Engineer/` paths
- `.obsidian/core-plugins.json:30` → `"sync": true` BUT no `.obsidian/sync/` data dir → core Sync plugin is enabled with no actual sync data. iCloud Drive is doing the work, but Obsidian still initializes the Sync plugin on launch.

### Community plugins (5 enabled)
| Plugin | Size | Mobile-loadable | Notes |
|---|---|---|---|
| surfing | 1.3 MB | **No** (`isDesktopOnly: true`) | Wastes sync bytes; mobile ignores |
| pdf-plus | 1.1 MB main.js + 9.7 KB data.json | Yes | Heavy parse on cold start; has mobile copy/auto-paste hooks |
| templater-obsidian | 212 KB | Yes | Standard |
| colored-tags | 208 KB + 23 KB data.json | Yes | 23 KB tag-color cache is suspicious — many tags |
| papers | 20 KB | Yes | Trivial |

### Stale paths in mobile `lastOpenFiles` (workspace-mobile.json:237-289)
```
raw/Untitled 1.md
Untitled
00_inbox/daily/2025/attachments/Pasted image 20250111144209.png  (×10 entries)
05_archive/Untitled.canvas
Untitled 3.canvas, Untitled 2.canvas, Untitled 4.canvas, Untitled 5.canvas
```

### Big binaries in `raw/`
```
raw/0zLnOxDIrc5PjzNnp                       25 MB (GIF 1382x768, no extension)
raw/yt_0a53c75973ea.m4a                     21 MB (audio)
raw/0N4cqz26JO545ak2U                       11 MB (GIF)
raw/urnaaidscUSc...revision0                1.3 MB (PNG)
raw/graph.json                              1.0 MB
raw/graph.html                              800 KB
raw/0B2kZQK_KmNPhREvL                       500 KB (PNG)
raw/0kNlD8m6gYsMI5lMW                       470 KB (PNG)
```

### Sync conflicts (suggests dual-sync history)
```
raw/.sync-conflict-20260201-211033-2HWCBDB.DS_Store
raw/.sync-conflict-20260201-211033-2HWCBDB-1.DS_Store
```
These are Syncthing-style conflict markers. Either a past Syncthing run or another non-iCloud sync touched this vault. Worth confirming no second sync layer is active on mobile.

### Note 7 — `.git` and iCloud
`.git` is 258 MB locally. iCloud Drive normally skips `.git` directories (Apple added an opt-out for dot-prefixed dirs in Obsidian's container in newer iOS), but behavior varies. If iCloud IS syncing it, mobile materialization of 258 MB of pack files compounds the startup hit. User can check via Finder: `.git` should show a cloud-with-slash icon if not synced.

## Section 3 — Safe fixes (lowest risk first)

**A. Edit `workspace-mobile.json` only** (mobile-isolated, doesn't touch desktop state):
1. Truncate `lastOpenFiles` to last 5 valid entries — drops resolution of ~48 stale paths.
2. Change file-explorer `sortOrder` from `byModifiedTime` to `alphabetical` — avoids full-vault mtime stat on startup.
3. Reduce open tabs from 12 → 2 (one note, one search). Mobile rebuilds them on demand anyway.

**B. Add `.obsidianignore` (Obsidian 1.5+)** to exclude generated artefacts from indexing:
```
graphify-out/
raw/graph.json
raw/graph.html
raw/*.gz
raw/0*
raw/yt_*.m4a
```
Reduces indexed file count by ~400, sync surface by ~5 MB+. Reversible — delete file to restore.

**C. Move `graphify-out/` out of the vault** to `~/Library/.../graphify-out/` or sibling dir. Update `CLAUDE.md` and graphify config to point at new path. Removes 5.7 MB / 323 files from sync.

**D. Disable `surfing` plugin in `community-plugins.json`** (already a no-op on mobile but still synced). Saves 1.3 MB.

**E. Fix `app.json` attachmentFolderPath** — set to existing dir (e.g. `"raw/attachments"`) or `""` (vault root). Current value `05_archive` is dead.

**F. Repair `bookmarks.json`** — remove 3 dead bookmarks; keep only `wiki/sources/git-commands-before-reading-code.md`.

**G. Clean sync-conflict `.DS_Store` files** — `raw/.sync-conflict-*` are pure noise.

**H. Re-evaluate desktop-only assets in `raw/`** — the 25 MB GIF, 11 MB GIF, 21 MB m4a, 1.3 MB revision PNG, hex-URL files, and `*.jpg.gz` web-clipper artefacts could move to `raw/` ignored subdir or outside vault. Lowest risk: just `.obsidianignore` them per fix B.

## Section 4 — Experiments to isolate the bottleneck

**E1. Time startup with current state (baseline)**
Force-quit Obsidian mobile. Cold start, stopwatch from tap to "Loading workspace" gone. Repeat 3×.

**E2. Empty `lastOpenFiles` test**
Backup `workspace-mobile.json`. Edit to `"lastOpenFiles": []` and remove all but one tab. Sync to mobile. Force-quit, cold start, time. Compares delta from stale-path resolution.

**E3. Disable pdf-plus on mobile only**
Toggle pdf-plus off in mobile settings (Obsidian mobile keeps its own enabled-plugin list). Time cold start. Isolates the 1 MB JS parse cost.

**E4. Add `.obsidianignore` for `graphify-out/` and `raw/*.json` only**
Sync to mobile. Force-quit, cold start, time. Isolates indexer cost from sync cost — files are still on disk but skipped by Obsidian.

**E5. Airplane-mode startup test**
Turn on airplane mode on phone, then cold-start Obsidian. If startup is fast in airplane mode but slow with network, iCloud reconciliation is the dominant cause (fix B+C). If still slow in airplane mode, indexer/workspace cost dominates (fix A+B).

## Section 5 — Questions for user

1. **Confirm sync method:** Obsidian Sync (paid) vs iCloud Drive? `core-plugins.json` enables sync but no sync data dir exists → assume iCloud Drive. Correct?
2. **What is `00_inbox/`, `05_archive/`, etc.?** Old PARA structure that was deleted but workspace.json still references it? Confirm safe to scrub from workspace files.
3. **Is `raw/` actively used on mobile?** If mobile never opens `raw/` files, ignoring the whole dir via `.obsidianignore` would be the single biggest win.
4. **Sync-conflict `.DS_Store`** — was Syncthing or another sync tool ever pointed at this vault?

Recommend running E5 first (airplane mode) — it answers the iCloud-vs-indexer question in one minute and decides whether fix path is sync-reduction (B/C/H) or workspace/index reduction (A/D/E).
