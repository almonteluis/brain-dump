---
description: "Budget Builder Implementation Plan"
tags: ['research']
raw_file: "quiet-stargazing-whisper.md"
created: 2026-05-17
---

# Budget Builder Implementation Plan

## Overview
Add a material cost and budgeting system that transforms the geometry quiz into a resource management puzzle. Users see real-time cost updates as they draw rooms, with optional budget caps as a game mechanic.

## Phase 1: MVP - Cost Display (Start Here)

### New Files to Create

**1. `src/constants/materials.ts`** - Material pricing constants
```typescript
export const FLOORING_RATE = 2;  // $/sq ft
export const WALL_RATE = 5;      // $/linear ft
```

**2. `src/stores/budgetStore.ts`** - Zustand store for budget state
- `budgetCap: number | null` - optional cap per level
- `setBudgetCap(cap)` action

**3. `src/hooks/useBudgetCalculation.ts`** - Derived cost calculations
- Reads `rooms` from `designStore`
- Reads rates from constants
- Returns: `{ flooringCost, wallCost, totalCost, isOverBudget, remainingBudget }`

**4. `src/components/ui/BudgetCard.tsx`** - Floating cost display
- Position: Below Header (top-left, second row)
- Style: Match Header's glassmorphism (`bg-surface/95 backdrop-blur-md border-white/50 rounded-[2rem]`)
- Display: Flooring cost + Wall cost + Total (with $ formatting)

### Files to Modify

**`src/types/index.ts`** - Add budget types
```typescript
export interface BudgetBreakdown {
  flooringCost: number;
  wallCost: number;
  totalCost: number;
  budgetCap: number | null;
  isOverBudget: boolean;
}
```

**`src/App.tsx`** - Add BudgetCard to UI
```typescript
import { BudgetCard } from './components/ui/BudgetCard';
// After <Header />, add:
<BudgetCard />
```

---

## Phase 2: Budget Cap Interaction

### Modifications

**`src/stores/budgetStore.ts`** - Add level-based caps
- Add `levelBudgetCaps: Record<number, number>` (e.g., `{1: 150, 2: 250}`)

**`src/components/ui/BudgetCard.tsx`** - Visual feedback
- Green border when under budget
- Yellow border when >85% of cap
- Red border + pulse animation when over

**`src/components/ui/BottomBar.tsx`** - Disable progression
- Import `useBudgetCalculation`
- Disable Challenge button if `isOverBudget`

---

## Phase 3: Material Selection (Future)

### New Files

**`src/components/ui/MaterialPanel.tsx`** - Pop-out material picker
- Follow `ColorPanel.tsx` pattern
- Tabs: Flooring | Walls
- Options: Standard ($2) vs Premium ($8) flooring

### Modifications

**`src/stores/budgetStore.ts`** - Track selected materials
- `selectedFlooringType: 'standard' | 'premium'`
- `setFlooringType(type)` action

**`src/constants/materials.ts`** - Expand material options
```typescript
export const FLOORING_RATES = {
  standard: 2,
  premium: 8,
};
```

---

## Implementation Order

1. Create `src/constants/materials.ts` with hardcoded rates
2. Add types to `src/types/index.ts`
3. Create `src/stores/budgetStore.ts`
4. Create `src/hooks/useBudgetCalculation.ts`
5. Create `src/components/ui/BudgetCard.tsx`
6. Modify `src/App.tsx` to render BudgetCard
7. (Phase 2) Add budget cap visual feedback
8. (Phase 3) Create MaterialPanel for material selection

---

## Key Patterns to Follow

**Styling (from Header.tsx:17)**
```
bg-surface/95 backdrop-blur-md border border-white/50 rounded-[2rem] px-8 py-3 shadow-xl ring-1 ring-primary/5
```

**Stats display (from Header.tsx:33-67)**
- Label: `text-[10px] font-bold tracking-wider text-text-muted uppercase`
- Value: `text-accent font-bold` for numbers
- Dividers: `w-px h-6 bg-primary/5`

**Hook pattern**
- Use `useMemo` for derived calculations
- Read from multiple stores via hooks

---

## Verification

1. Run `npm run dev` and create a room
2. Verify BudgetCard appears showing:
   - Flooring: [area] × $2 = $X
   - Walls: [perimeter] × $5 = $Y
   - Total: $Z
3. Run `npx tsc --noEmit` to verify no type errors
4. Create/delete rooms and verify costs update in real-time

