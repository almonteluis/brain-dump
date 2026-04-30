---
description: Learnosity — third-party assessment platform integration for skill assessments and interactive learning content
tags: ["learnosity", "assessment", "third-party", "integration", "education", "concept"]
created: 2026-04-30
updated: 2026-04-30
sources: ["teame-188-timeline-reset-skill-resource", "teame-189-skill-assessment-refresh-failure", "teame-166-learnosity-stability"]
---

# Learnosity

Learnosity is a third-party assessment platform integrated into the application for delivering skill assessments, practice problems, and interactive learning content to students.

## Integration Points

- **Skill Resource Page** — Students take assessments within the application's UI
- **Timeline** — Displays history of assessment iterations and results
- **State Management** — Assessment state (in-progress, completed, results) tracked alongside Learnosity session data

## Known Issues

### Timeline Reset (TEAME-188)

When students take multiple assessments within the same iteration, leave the page, and return, the timeline sometimes resets without showing previous iterations. Database records are correct — frontend state issue suspected.

### Assessment Loading Failure (TEAME-189)

After page refresh during an active assessment with previous timeline attempts, the Practice Problems and Start button fail to load. State rehydration issue after refresh.

### Stability Investigation (TEAME-166)

Parent story investigating long-term Learnosity stability. Multiple sub-defects related to state management, timeline rendering, and assessment lifecycle.

## Related

- [[teame-188-timeline-reset-skill-resource]] — Timeline reset bug
- [[teame-189-skill-assessment-refresh-failure]] — Assessment loading after refresh
- [[teame-166-learnosity-stability]] — Parent stability investigation
- [[skill-resource-page]] — Student-facing assessment UI
- [[third-party-integrations]] — General integration patterns
