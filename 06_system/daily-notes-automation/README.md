---
description: Documentation and setup guide for this directory or project..
---

# Daily Notes Automation

> Automatic daily note creation for Obsidian. Runs at 7pm EST (midnight UTC).

---
description: React notes and reference about README.

## 🤖 How It Works

### Automatic Creation
- **Schedule:** Every day at midnight UTC (7pm EST)
- **Location:** `00_inbox/daily/` folder in your vault
- **Template:** Uses `Templates/daily-note-template.md`
- **Format:** `MM-DD-YYYY.md` (e.g., `01-28-2026.md`)

### Script Location
- **Path:** `/home/ubuntu/clawd/scripts/create-daily-note.py`
- **Cron Job:** Runs automatically via system crontab

### What Gets Created

Each daily note includes:
- ✅ **Morning Review** - Focus areas and learning objectives
- ✅ **Learning Tracker** - Current learning topics and progress
- ✅ **Code Practice** - Algorithm and system design problems
- ✅ **Daily Tasks** - High priority, learning, code reviews
- ✅ **Notes & Documentation** - Learning notes and questions
- ✅ **Progress Metrics** - Weekly goals and study time
- ✅ **Review & Reflection** - What went well, challenges, tomorrow's prep
- ✅ **Skills Progress** - React, JavaScript, System Design, Algorithms tracking

---

## 🛠️ Manual Creation

If you want to create a daily note before 7pm:

```bash
python3 /home/ubuntu/clawd/scripts/create-daily-note.py
```

### Edit Existing Note

Open in Obsidian and start typing - the script won't overwrite existing notes.

---

## 📝 Template Customization

Edit `Templates/daily-note-template.md` to:
- Add/remove sections
- Change structure
- Update Dataview queries
- Customize task format

---

## 🔧 Cron Job Details

**Current crontab:**
```
0 0 * * * /usr/bin/python3 /home/ubuntu/clawd/scripts/create-daily-note.py >> /home/ubuntu/clawd/logs/daily-note.log 2>&1
```

**Schedule:** Every day at 00:00 UTC (7pm EST)
**Log file:** `/home/ubuntu/clawd/logs/daily-note.log`

### View Logs
```bash
tail -f /home/ubuntu/clawd/logs/daily-note.log
```

### Update Cron Job
```bash
# Edit crontab
crontab -e

# Remove automation
crontab -r
```

---

## 📊 Today's Note Status

**Last check:** 2026-01-28

**To create today's note manually:**
```bash
python3 /home/ubuntu/clawd/scripts/create-daily-note.py
```

---

**Note:** If you open Obsidian and today's note doesn't exist yet, it will appear after the script runs at 7pm EST. You can manually run the script to create it earlier.

---

## 🔗 Related

- [[Templates/daily-note-template.md]] - The template file
- [[Clawdbot]] - AI assistant settings
- [[Software Engineer]] - Technical notes
