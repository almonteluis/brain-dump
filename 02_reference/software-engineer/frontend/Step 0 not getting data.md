---
description: # Issue Summary.
tags: #debugging #data-fetching #frontend #troubleshooting #notes
---

<think>Let me summarize the debugging process and the solution to the issue where the mock tour dates weren't being loaded.

1. Initial Issue:
   - The application wasn't displaying any tour dates despite having a mock file with tour date data

2. Steps taken during debugging:
   - First checked if the mock file existed and contained proper data
   - Examined how the mock data was being used in the application
   - Identified that useInitTourDates was commented out in the Step0 component
   - Added logging at various levels to trace the data flow
   - Discovered that landingPageId and siteName were empty strings
   - Found that getTourDates had a conditional check that returned early with empty arrays when these values were empty
   - Provided default values for landingPageId and siteName and removed the early return

3. Crucial code fixes:
   - Uncommented useInitTourDates hook call
   - Added default values for landingPageId and siteName 
   - Removed the conditional early return in getTourDates
   - Added proper type definition to the mockTourDates function
   - Added error handling and UI feedback for loading state

I'll provide code snapshots showing the changes made to resolve this issue.</think># Mock Tour Dates Loading Issue: Debug Process & Solution

## Issue Summary
The application wasn't loading or displaying tour dates from the mock data despite having a complete mock file with properly structured tour date data.

## Debugging Process & Solution

### Step 1: Identified the commented hook call
The first issue discovered was that the `useInitTourDates` hook call in the Step0 component was commented out, preventing the data fetch from happening.

**Before:**
```tsx
const { updateStepLocked, landingPageId, siteName } = useBookingStep();
// useInitTourDates(landingPageId, siteName);
```

**After:**
```tsx
const { updateStepLocked, landingPageId, siteName, setLandingPageId, setSiteName } = useBookingStep();
useInitTourDates(landingPageId || 'default-landing-page-id', siteName || 'default-site-name');
```

### Step 2: Discovered empty parameters issue
We found that `landingPageId` and `siteName` parameters were initialized as empty strings in the `useBookingStep` hook. The API function `getTourDates` had a guard clause that returned empty arrays when these values were empty.

**Before (in tour/index.ts):**
```typescript
export const getTourDates = async (landingPageId: string, siteName: string) => {
  // console.log(`inside tour index.ts ${mockTourDates}`);
  try {
    if (!landingPageId || !siteName) {
      return {
        tourDateItems: [],
        tourDateFilters: [],
      };
    }
    // API call code...
    const res: any = await mockTourDates();
    return res.data;
  } catch (error) {
    console.error('Error fetching tour dates:', error);
    throw error;
  }
};
```

**After:**
```typescript
export const getTourDates = async (landingPageId: string, siteName: string) => {
  console.log(`getTourDates called with landingPageId: ${landingPageId}, siteName: ${siteName}`);
  try {
    // During development, always return mock data even if landingPageId or siteName are empty
    // if (!landingPageId || !siteName) {
    //   return {
    //     tourDateItems: [],
    //     tourDateFilters: [],
    //   };
    // }
    
    // API call code...
    const res: { data: GetTourDatesResponse } = await mockTourDates();
    console.log('Mock data returned:', res.data);
    return res.data;
  } catch (error) {
    console.error('Error fetching tour dates:', error);
    throw error;
  }
};
```

### Step 3: Added default values for empty parameters
To ensure the hook could properly fetch data during development, we added default values for empty parameters and added an effect to set default values if needed.

**Added to Step0.tsx:**
```typescript
// Set default values for landingPageId and siteName if they're empty
useEffect(() => {
  console.log('landingPageId:', landingPageId, 'siteName:', siteName);
  if (!landingPageId) {
    setLandingPageId('default-landing-page-id');
  }
  if (!siteName) {
    setSiteName('default-site-name');
  }
}, [landingPageId, siteName, setLandingPageId, setSiteName]);

useInitTourDates(
  landingPageId || 'default-landing-page-id',
  siteName || 'default-site-name'
);
```

### Step 4: Added proper type definition to mock function
The mock function lacked proper type definitions, which could cause type errors.

**Before:**
```typescript
export const mockTourDates = () => {
  return new Promise((resolve) => {
    // ...
    resolve({ data });
  });
};
```

**After:**
```typescript
export const mockTourDates = (): Promise<{ data: GetTourDatesResponse }> => {
  return new Promise((resolve) => {
    // ...
    resolve({ data });
  });
};
```

### Step 5: Added extensive debugging logs
We added detailed console logs throughout the data flow to track where issues might occur.

```typescript
// In useInitTourDates
console.log('useInitTourDates called with:', { landingPageId, siteName });
console.log('Fetching tour dates...');
console.log('Tour data received:', data);
console.log('Tour date items length:', data.tourDateItems?.length);
console.log('Tour date filters:', data.tourDateFilters);

// In getTourDates
console.log(`getTourDates called with landingPageId: ${landingPageId}, siteName: ${siteName}`);
console.log('Mock data returned:', res.data);
```

### Step 6: Added conditional rendering for loading state
To provide a better user experience, we added a loading indicator when tour date filters weren't available yet.

**Before:**
```tsx
<Tabs defaultActiveKey="0" className={'year-tabs'}>
  {tourDateFilters.map((year, index) => {
    // ...
  })}
</Tabs>
```

**After:**
```tsx
{tourDateFilters && tourDateFilters.length > 0 ? (
  <Tabs defaultActiveKey="0" className={'year-tabs'}>
    {tourDateFilters.map((year, index) => {
      // ...
    })}
  </Tabs>
) : (
  <div className="text-center my-4">Loading tour dates...</div>
)}
```

## Root Causes Summary

1. **Missing Hook Call**: The `useInitTourDates` hook was commented out in the component
2. **Empty Required Parameters**: The application was using empty strings for `landingPageId` and `siteName` 
3. **Early Return Guard Clause**: The `getTourDates` function had a guard clause that returned empty arrays when parameters were empty
4. **Type Safety Issues**: The mock function lacked proper TypeScript return type definitions

These issues combined to prevent the mock tour date data from appearing in the UI. By addressing all of them, we ensured that the mock data could flow correctly through the application even during local development without real API endpoints.
