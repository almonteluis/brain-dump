---
description: Notes about FAANG Frontend Resources.
tags: ["resource"]
---

## System Design Resources

[[Netflix Frontend Architecture]]

[[Meta React Performance]]

[[Google Web Development]]

[[AWS Frontend Patterns]]

## Interview Preparation

### System Design Interview
---
description: React notes and reference about FAANG Frontend Resources.
rating: 5
focus: interviews
url: https://bytebytego.com
company: FAANG
author: ex-FAANG
tags: resource, interviews
---

Covers:
- Frontend system design
- Scalability patterns
- Common interview questions
- Architecture deep dives

### Frontend Expert
---
rating: 4.5
focus: interview prep
url: https://frontendmasters.com
author: ex-FAANG
tags: resource, interviews
---

Content includes:
- Coding challenges
- System design exercises
- Performance optimization
- Common patterns

## Technical Deep Dives

### React Architecture
---
rating: 5
focus: React internals
url: https://overreacted.io
author: ex-FAANG
tags: resource, React
---

Topics:
- React internals
- Hooks implementation
- Performance patterns
- State management

### Performance Optimization
---
rating: 4.5
focus: performance
url: https://3perf.com
author: ex-FAANG
tags: resource, performance
---

Areas covered:
- Loading optimization
- Runtime performance
- Memory management
- Rendering patterns

---

## Progress Tracking
```dataview
TABLE rating, focus, url 
FROM #resource
WHERE contains(company, "FAANG") OR author = "ex-FAANG"
SORT rating DESC
```

## Resource Categories
```dataview
TABLE length(rows) AS "Count"
FROM #resource
GROUP BY focus
SORT count DESC
```

## Top Rated Resources
```dataview
TABLE focus, author, url
FROM #resource
WHERE rating >= 4.5
SORT rating DESC
```

---
tags: resources, FAANG, learning