---
description: Terminal multiplexer cheat sheet — sessions, windows, panes, copy mode, key bindings
tags: ["tools", "terminal", "tmux", "reference", "cheatsheet"]
sources: ["Tmux Cheat Sheet & Quick Reference  Session, window, pane and more.md"]
created: 2026-04-10
updated: 2026-04-10
---

# Tmux Cheat Sheet

**Source:** tmuxcheatsheet.com
**Type:** Reference guide
**Date ingested:** 2026-04-10

## Summary

Comprehensive tmux reference covering sessions, windows, panes, copy mode, and key bindings. Tmux is a terminal multiplexer that lets you switch between multiple programs in one terminal.

## Sessions

| Command | Description |
|---------|-------------|
| `tmux` | Start tmux |
| `tmux new` | Start new session |
| `tmux new-session` | Start new session |
| `tmux new -s mysession` | Start named session |
| `tmux new-session -A -s mysession` | Attach if exists, else create |
| `tmux kill-session -t mysession` | Kill specific session |
| `tmux kill-session -a` | Kill all except current |
| `tmux ls` / `tmux list-sessions` | List all sessions |
| `Ctrl+b s` | Show all sessions |
| `tmux a` / `tmux attach` | Attach to last session |
| `Ctrl+b d` | Detach from session |
| `Ctrl+b w` | Session/window preview |
| `Ctrl+b (` / `)` | Previous/next session |

## Windows

| Command/Key | Description |
|------------|-------------|
| `Ctrl+b c` | Create window |
| `Ctrl+b ,` | Rename current window |
| `Ctrl+b &` | Close current window |
| `Ctrl+b w` | List windows |
| `Ctrl+b p` / `Ctrl+b n` | Previous/next window |
| `Ctrl+b 0-9` | Switch by number |
| `Ctrl+b l` | Toggle last active window |
| `:swap-window -s 2 -t 1` | Reorder windows |
| `:move-window -s src_ses:win -t target_ses:win` | Move between sessions |
| `:move-window -r` | Renumber to remove gaps |

## Panes

| Key | Action |
|-----|--------|
| `Ctrl+b ;` | Toggle last active pane |
| `Ctrl+b %` | Split horizontal (vertical layout) |
| `Ctrl+b "` | Split vertical (horizontal layout) |
| `:join-pane -s 2 -t 1` | Merge windows as panes |
| `Ctrl+b { / }` | Move pane left/right |
| `Ctrl+b o` | Switch to next pane |
| `Ctrl+b q` | Show pane numbers |
| `Ctrl+b q 0-9` | Switch by number |
| `Ctrl+b z` | Toggle pane zoom |
| `Ctrl+b x` | Close pane |
| `Ctrl+b Spacebar` | Toggle layouts |
| `:setw synchronize-panes` | Toggle sending commands to all panes |

## Copy Mode

| Key | Action |
|-----|--------|
| `Ctrl+b [` | Enter copy mode |
| `q` | Quit mode |
| `g / G` | Go to top/bottom |
| `j / k` | Move down/up |
| `h / l` | Move left/right |
| `w / b` | Move by word |
| `/ / ?` | Search forward/backward |
| `n / N` | Next/previous keyword |
| `Spacebar` | Start selection |
| `Enter` | Copy selection |
| `Ctrl+b ]` | paste buffer_0 |
| `:capture-pane` | Copy entire visible contents |
| `:list-buffers` | Show all buffers |
| `:choose-buffer` | Show and paste buffer |
| `:save-buffer buf.txt` | Save buffer to file |

## Misc

| Command/Key | Action |
|------------|--------|
| `Ctrl+b :` | Enter command mode |
| `:set -g OPTION` | Set option for all sessions |
| `:set mouse on` | Enable mouse mode |
| `Ctrl+b ?` | List key bindings |
| `$ tmux list-keys` | List all keys |
| `$ tmux info` | Show sessions, windows, panes |

## Copy Mode VI Keys

| Key | Action |
|-----|--------|
| `:setw -g mode-keys vi` | Use vi keys in buffer |

## Related

- [[git-cheatsheet]] — Git commands reference
