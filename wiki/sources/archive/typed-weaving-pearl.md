---
description: "TEAME-203: PR Description & Screenshot Checklist"
tags: ['research']
raw_file: "typed-weaving-pearl.md"
created: 2026-05-17
---

# TEAME-203: PR Description & Screenshot Checklist

---

## PR Description

### Title
Add experimental logging for teacher assignment creation patterns

### Summary
Adds logging to the `experiments_observations` table when teachers create assignments, enabling analysis of assignment patterns and curriculum alignment strategies. This helps identify teachers who use the product intentionally vs. "set it and forget it" approaches.

**Note**: This is backend-only observability with no UI changes.

### What's Being Logged

| Field | Source | Status |
|-------|--------|--------|
| `assignment_created` | event marker | ✅ Done |
| `student_count` | input | ✅ Done |
| `assignment_method_skill_only` | input | ✅ Done |
| `skill_type_support` / `skill_type_target` | skill lookup | ✅ Done |
| `skill_id` | input.skillId | ⏳ Added |
| `class_id` | input.classIds[0] | ⏳ Added |
| `curriculum_id` / `roadmap_id` | Class lookup | ⏳ Added |
| `target_id` | Skill lookup | ⏳ Added |
| `unit_id` | Skill lookup | ⏳ Added |
| `unit_continuity` | previous assignment comparison | ⏳ Added |

### Changes
- Extended assignment creation mutation to log additional fields to `experiments_observations`
- Added GraphQL fragments for Class (curriculum/roadmap) and Skill (target/unit) lookups
- Implemented unit continuity tracking for target skill assignments

### Testing
- Verified logging populates correctly in `experiments_observations` table
- Tested both target skill and support skill assignment flows

---

## Screenshot / Verification Checklist

Since this has **no UI changes**, verification is database-based:

### Database Verification (Required)
- [ ] **Assignment created as target skill** - Check `experiments_observations` table for:
  - `assignment_created` = true
  - `skill_type_target` = true
  - `skill_id` populated
  - `class_id` populated
  - `curriculum_id` or `roadmap_id` populated
  - `target_id` populated
  - `unit_id` populated
  - `unit_continuity` = "same" or "different"

- [ ] **Assignment created as support skill** - Check `experiments_observations` table for:
  - `assignment_created` = true
  - `skill_type_support` = true
  - `skill_id`, `class_id`, `curriculum_id` populated
  - `unit_continuity` should be null (only tracked for target skills per Sam)

- [x] **Student count varies** - Create assignment for:
  - [ ] Entire class (student_count = all students)
  - [ ] Small group (student_count = small number)
  - [ ] Single student (student_count = 1)

### Edge Cases to Verify
- [x] First assignment in a class (no previous assignment → unit_continuity should be null or "none")
- [x] Second assignment in same unit (unit_continuity = "same")
- [ ] Assignment in different unit (unit_continuity = "different")
- [ ] Support skill assignment (unit_continuity NOT logged)

### SQL Queries for Verification

```sql
-- Check latest assignment log entries
SELECT * FROM experiments_observations
WHERE observation_key = 'assignment_created'
ORDER BY created_at DESC
LIMIT 10;

-- Verify all fields are populated
SELECT
  observation_key,
  data->>'skill_id' as skill_id,
  data->>'class_id' as class_id,
  data->>'curriculum_id' as curriculum_id,
  data->>'target_id' as target_id,
  data->>'unit_id' as unit_id,
  data->>'unit_continuity' as unit_continuity,
  data->>'student_count' as student_count,
  data->>'skill_type' as skill_type
FROM experiments_observations
WHERE observation_key = 'assignment_created'
ORDER BY created_at DESC;
```

---

## Notes for Reviewer
- This is experimental/analytics logging, not user-facing
- No frontend visual changes expected
- Please verify on staging/dev before deploying to production
- Related to TEAME-213 (student-flow metrics)

