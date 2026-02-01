---
tags: ["aria-attributes", "catching-rendering-errors-with-an-error-boundary", "component-development", "excursions-table", "react", "traveler-management", "typescript"]
---
## Overview
description: # Overview./
Building a TypeScript React component for managing excursion selections with traveler management in a booking system. This component is part of the booking system and handles the selection of excursions and their associated travelers in a type-safe and user-friendly manner.
description: # Overview./

description: # Overview./
## Initial Implementation
description: # Overview./

description: # Overview./
The initial approach had the traveler selection UI directly in the Persons column:
description: # Overview./

description: # Overview./
```typescript
description: # Overview./
<td className="small fw-bold">
description: # Overview./
  {isSelected && (
description: # Overview./
    <div className="small">
description: # Overview./
      {travelers.map((traveler) => {
description: # Overview./
        // Traveler checkboxes directly in Persons column
description: # Overview./
      })}
description: # Overview./
    </div>
description: # Overview./
  )}
description: # Overview./
</td>
description: # Overview./
```
description: # Overview./

description: # Overview./
## Issues & Solutions
description: # Overview./

description: # Overview./
### Problems Identified
description: # Overview./
- Crowded Persons column with checkbox overflow
description: # Overview./
- Poor user experience
description: # Overview./
- Unclear display of selected travelers
description: # Overview./

description: # Overview./
### Working Solution
description: # Overview./
Implemented a two-row system:
description: # Overview./
```typescript
description: # Overview./
<tr className={isSelected ? '' : 'muted'}>
description: # Overview./
  <td className="small align-middle">
description: # Overview./
    <input type="checkbox" checked={isSelected} onChange={(e) => handleSelect(item, e.target.checked)} />
description: # Overview./
  </td>
description: # Overview./
  <td className="small fw-bold">{item.contractName}</td>
description: # Overview./
  <td className="small fw-bold">{formatCurrency(price)}</td>
description: # Overview./
  <td className="small fw-bold">
description: # Overview./
    {isSelected ? (item.travelerIds?.length || 0) : '-'}
description: # Overview./
  </td>
description: # Overview./
</tr>
description: # Overview./
{isSelected && (
description: # Overview./
  <tr>
description: # Overview./
    <td colSpan={4}>
description: # Overview./
      <div className="small">
description: # Overview./
        {travelers.map((traveler) => (
description: # Overview./
          // Traveler selection checkboxes
description: # Overview./
        ))}
description: # Overview./
      </div>
description: # Overview./
    </td>
description: # Overview./
  </tr>
description: # Overview./
)}
description: # Overview./
```
description: # Overview./

description: # Overview./
## Key Features
description: # Overview./
1. Automatic pre-selection of all travelers when excursion is selected
description: # Overview./
2. Individual traveler selection/deselection
description: # Overview./
3. Clear display of selected traveler count
description: # Overview./
4. TypeScript type safety throughout
description: # Overview./
5. Proper state management for selections
description: # Overview./

description: # Overview./
## Best Practices
description: # Overview./

description: # Overview./
### Do's
description: # Overview./
- Use separate rows for complex selection interfaces
description: # Overview./
- Implement proper TypeScript typing
description: # Overview./
- Show clear count of selected travelers
description: # Overview./
- Handle undefined/null cases properly
description: # Overview./

description: # Overview./
### Don'ts
description: # Overview./
- Don't overcrowd table columns
description: # Overview./
- Don't mix display and selection interfaces
description: # Overview./
- Don't forget type safety
description: # Overview./
- Don't ignore edge cases
description: # Overview./

description: # Overview./
## Future Improvements
description: # Overview./
- [ ] Add loading states
description: # Overview./
- [ ] Implement maximum selection limits
description: # Overview./
- [ ] Add tooltips
description: # Overview./
- [ ] Add bulk selection/deselection
description: # Overview./
- [ ] Improve mobile responsiveness
description: # Overview./

description: # Overview./
## Technical Notes
description: # Overview./
- Uses `useCallback` for memoization
description: # Overview./
- Proper handling of TypeScript interfaces
description: # Overview./
- Clean state management
description: # Overview./
- Consistent error handling
description: # Overview./

description: # Overview./
## References
description: # Overview./
- [[Improvements for Excusions Table component]]
description: # Overview./
- [Kent C. Dodds - State Colocation](https://kentcdodds.com/blog/state-colocation-will-make-your-react-app-faster)
description: # Overview./
- [React Official Docs - Lifting State Up](https://react.dev/learn/sharing-state-between-components)
description: # Overview./
- [React Docs - [[useMemo]]](https://react.dev/reference/react/useMemo)
description: # Overview./
- [Dan Abramov's Blog - Before You memo()](https://overreacted.io/before-you-memo/)
description: # Overview./
- [React Patterns - Container/Presentational](https://www.patterns.dev/react/container-presentational)
description: # Overview./
- [React TypeScript Cheatsheet](https://react-typescript-cheatsheet.netlify.app/docs/basic/getting-started/function_components/)
description: # Overview./
- [Testing Library - Best Practices](https://testing-library.com/docs/react-testing-library/intro/)
description: # Overview./
- [Jest Documentation](https://jestjs.io/docs/tutorial-react)
description: # Overview./
- [React Accessibility Guide](https://react.dev/reference/react-dom/components/common#aria-attributes)
description: # Overview./
- [WAI-ARIA Practices](https://www.w3.org/WAI/ARIA/apg/patterns/checkbox/)
description: # Overview./
- [TypeScript Handbook](https://www.typescriptlang.org/docs/handbook/intro.html)
description: # Overview./
- [Matt Pocock's TypeScript Tips](https://www.totaltypescript.com/tutorials)
description: # Overview./
- [React Error Boundary Documentation](https://react.dev/reference/react/Component#catching-rendering-errors-with-an-error-boundary)
description: # Overview./
- [React Error Boundary npm package](https://www.npmjs.com/package/react-error-boundary)
description: # Overview./
- [Web Performance API Documentation](https://developer.mozilla.org/en-US/docs/Web/API/Performance)
description: # Overview./
- [React Performance Monitoring](https://react.dev/reference/react/Profiler)
description: # Overview./
- [CSS Modules](https://github.com/css-modules/css-modules)
description: # Overview./
- [Styled Components Documentation](https://styled-components.com/docs)
description: # Overview./
- [React Official Blog](https://react.dev/blog)
description: # Overview./
- [React Patterns by kcd](https://kentcdodds.com/blog/javascript-to-know-for-react)
description: # Overview./

description: # Overview./
## Learnings & Best Practices
description: # Overview./

description: # Overview./
- **Do's**:
description: # Overview./
    - Use separate rows for complex selection interfaces
description: # Overview./
    - Implement proper TypeScript typing for callbacks
description: # Overview./
    - Pre-select all travelers when excursion is selected
description: # Overview./
    - Show clear count of selected travelers
description: # Overview./
- **Don'ts**:
description: # Overview./
    - Don't overcrowd table columns with complex UI elements
description: # Overview./
    - Don't mix display and selection interfaces in the same cell
description: # Overview./
    - Don't forget to handle undefined/null cases
description: # Overview./

description: # Overview./
## Follow-up Tasks
description: # Overview./

description: # Overview./
- [ ]  Add loading states for async operations
description: # Overview./
- [ ]  Consider adding validation for maximum traveler selections
description: # Overview./
- [ ]  Add tooltips for better UX
description: # Overview./
- [ ]  Consider adding bulk selection/deselection options
description: # Overview./

description: # Overview./
## Metadata
description: # Overview./

description: # Overview./
### Model-Specific Notes
description: # Overview./

description: # Overview./
- Component handles TypeScript type safety well
description: # Overview./
- Successfully manages complex state updates
description: # Overview./
- Properly handles optional chaining and null checks
description: # Overview./

description: # Overview./
### Tags
description: # Overview./

description: # Overview./
#react #typescript #component-development #excursions-table #traveler-management
description: # Overview./

description: # Overview./
---
description: # Overview./

Last Updated: 2025-01-11

Here are specific references for the suggestions I provided: