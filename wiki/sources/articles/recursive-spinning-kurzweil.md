---
description: "Vector Explore UI/UX Overhaul - Implementation Plan"
tags: ['research']
raw_file: "recursive-spinning-kurzweil.md"
created: 2026-05-17
---

# Vector Explore UI/UX Overhaul - Implementation Plan

## Overview

This plan implements the PRD requirements for the Level Selection and Career Progress screens, transforming the interface into a high-tech "Mission Control" experience.

**Key Finding:** Many Level Selection features (hexagonal cells, tactical background, glassmorphism) are already implemented. The primary work focuses on Career Dashboard redesign and adding Mission Briefing tooltips.

---

## Phase 1: Foundation (Priority: HIGH)

### 1.1 Add Module Signature Colors to Tailwind Config

**File:** `tailwind.config.js`

Add module-specific colors to theme.extend.colors:
```javascript
module: {
    abstract: '#d946ef',  // Magenta (fuchsia-500)
    drone: '#00d9ff',     // Cyan (existing)
    bridge: '#f59e0b',    // Amber
    robotics: '#84cc16',  // Lime Green
}
```

### 1.2 Create Centralized Module Theme Constants

**New File:** `src/lib/theme/moduleTheme.ts`

Create constants for module colors, gradients, icons, and names to prevent duplication across files. Currently `MODULE_NAMES` is duplicated in CareerDashboard.tsx and LevelSelector.tsx.

### 1.3 Extend Types for Level Tooltips

**File:** `src/lib/types.ts`

Add `vectorConcept` interface to `BaseLevelConfig`:
```typescript
vectorConcept?: {
    name: string;           // e.g., "Vector Magnitude"
    briefDescription: string;
}
```

---

## Phase 2: Career Dashboard Redesign (Priority: HIGH)

### 2.1 Create CircularProgressGauge Component

**New File:** `src/components/ui/CircularProgressGauge.tsx`

Reusable SVG gauge component (adapt pattern from MissionControlPanel.tsx lines 46-95):
- Props: `value`, `max`, `label`, `color`, `size`, `icon`
- Uses `stroke-dasharray/stroke-dashoffset` for animated fill
- Module-specific glow color

### 2.2 Create ModuleAchievementCard Component

**New File:** `src/components/ui/ModuleAchievementCard.tsx`

Replace inline badge rendering with dedicated component:

**Locked State (fix contrast issue):**
- Remove `opacity-50` (currently line 112 of CareerDashboard.tsx)
- Use `bg-slate-800/60 border-slate-600/50 text-slate-400`
- Show ghosted icon with CSS filter

**Unlocked State:**
- Add module signature color border glow
- Keep existing tier gradients (TIER_COLORS)

### 2.3 Create ModuleFilterBar Component

**New File:** `src/components/ui/ModuleFilterBar.tsx`

Horizontal filter pills for achievements:
- Toggle buttons for Abstract, Drone, Bridge, Robotics
- Module-specific colors when active
- "All" option as default

### 2.4 Create ModuleSectionHeader Component (Sticky Headers)

**New File:** `src/components/ui/ModuleSectionHeader.tsx`

Sticky category headers:
- `position: sticky; top: 0;`
- Module-colored left border accent
- Glassmorphism background blur

### 2.5 Refactor CareerDashboard.tsx

**File:** `src/components/ui/CareerDashboard.tsx`

Major changes:
1. Replace top stats grid (lines 71-87) with 4 `CircularProgressGauge` components
2. Add `ModuleFilterBar` with local filter state
3. Replace inline badge rendering (lines 101-147) with `ModuleAchievementCard`
4. Wrap module sections with `ModuleSectionHeader`
5. Update responsive grid: `grid-cols-1 sm:grid-cols-2 lg:grid-cols-3 xl:grid-cols-4`

---

## Phase 3: Level Selection Tooltip (Priority: HIGH)

### 3.1 Create MissionBriefingTooltip Component

**New File:** `src/components/ui/MissionBriefingTooltip.tsx`

Tooltip showing vector concept on level hover:
- Glassmorphism styling (match existing pattern)
- Display: level title, vector concept name, brief description
- Fade-in animation with slight scale

### 3.2 Extend HexagonalLevelCell with Hover Callbacks

**File:** `src/components/ui/HexagonalLevelCell.tsx`

Add props:
- `onHover: (isHovered: boolean, rect: DOMRect | null) => void`
- `levelConfig: ModuleLevelConfig`

### 3.3 Integrate Tooltip in LevelSelector

**File:** `src/components/ui/LevelSelector.tsx`

Add hover state management and render `MissionBriefingTooltip`.

### 3.4 Add vectorConcept Data to All Levels

**Files:**
- `src/lib/levels/abstract.ts`
- `src/lib/levels/drone.ts`
- `src/lib/levels/bridge.ts`
- `src/lib/levels/robotics.ts`

Add `vectorConcept` object to each level configuration.

---

## Phase 4: Animations and Polish (Priority: MEDIUM)

### 4.1 Add CSS Animations

**File:** `src/index.css`

Add keyframes:
- `badge-unlock` - Pulse animation for newly earned badges
- `tooltip-enter` - Fade-in with scale for tooltips
- `gauge-fill` - Progress gauge fill animation

### 4.2 Accessibility Improvements

- Increase locked badge text contrast (slate-400 minimum)
- Add keyboard navigation for filter bar (arrow keys, ARIA roles)
- Add `aria-describedby` for tooltips

---

## File Summary

| File | Action | Description |
|------|--------|-------------|
| `tailwind.config.js` | Modify | Add module signature colors |
| `src/lib/types.ts` | Modify | Add vectorConcept interface |
| `src/lib/theme/moduleTheme.ts` | Create | Centralized module theme constants |
| `src/components/ui/CircularProgressGauge.tsx` | Create | Reusable SVG gauge |
| `src/components/ui/ModuleAchievementCard.tsx` | Create | Achievement card component |
| `src/components/ui/ModuleFilterBar.tsx` | Create | Module filter pills |
| `src/components/ui/ModuleSectionHeader.tsx` | Create | Sticky section headers |
| `src/components/ui/CareerDashboard.tsx` | Modify | Major redesign with new components |
| `src/components/ui/MissionBriefingTooltip.tsx` | Create | Level hover tooltip |
| `src/components/ui/HexagonalLevelCell.tsx` | Modify | Add hover callbacks |
| `src/components/ui/LevelSelector.tsx` | Modify | Integrate tooltip |
| `src/lib/levels/*.ts` | Modify | Add vectorConcept data |
| `src/index.css` | Modify | Add animation keyframes |

---

## Verification

1. **Run dev server:** `npm run dev`
2. **Test Level Selection:**
   - Hover over level cells to see Mission Briefing tooltip
   - Verify tooltip displays vector concept info
   - Check tooltip positioning near screen edges
3. **Test Career Dashboard:**
   - Verify circular gauges show per-module progress
   - Test module filter buttons
   - Check sticky headers while scrolling
   - Verify locked badge contrast is improved
   - Confirm unlocked badges have module-colored glow
4. **Test responsiveness:** Check tablet/mobile layouts
5. **Run build:** `npm run build` to ensure single-file output works

