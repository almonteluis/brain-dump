---
description: "Tiny House Design & Solve - React + Three.js Implementation Plan"
tags: ['research']
raw_file: "buzzing-prancing-plum.md"
created: 2026-05-17
---

# Tiny House Design & Solve - React + Three.js Implementation Plan

## Overview
Build an educational web app for teaching area/perimeter math through interactive tiny house floorplan design using React, TypeScript, and Three.js.

## Tech Stack

| Layer | Technology | Rationale |
|-------|------------|-----------|
| Framework | React 18 + TypeScript | Type safety, component architecture |
| Build | Vite | Fast dev server, optimized builds |
| 3D Rendering | Three.js + @react-three/fiber | React-friendly Three.js integration |
| 3D Helpers | @react-three/drei | Useful primitives (OrbitControls, Grid, etc.) |
| State | Zustand | Lightweight, no boilerplate, great for undo/redo |
| Styling | Tailwind CSS | Rapid UI development, matches GDD color system |
| Icons | Lucide React | Clean SVG icons for tools |
| Math | N/A (built-in) | Area/perimeter calculations are simple |

## Project Structure

```
tiny-homes/
├── index.html
├── package.json
├── tsconfig.json
├── tailwind.config.js
├── vite.config.ts
├── src/
│   ├── main.tsx                    # Entry point
│   ├── App.tsx                     # Root component with routing
│   ├── index.css                   # Tailwind imports + custom styles
│   │
│   ├── components/
│   │   ├── canvas/                 # Three.js components
│   │   │   ├── Scene.tsx           # Main R3F Canvas wrapper
│   │   │   ├── Grid.tsx            # Interactive grid floor
│   │   │   ├── Cell.tsx            # Individual grid cell (wall/floor/etc)
│   │   │   ├── Room.tsx            # Room fill rendering
│   │   │   ├── Furniture.tsx       # Furniture 3D models/shapes
│   │   │   ├── Door.tsx            # Door element
│   │   │   ├── Window.tsx          # Window element
│   │   │   └── CameraControls.tsx  # Zoom/pan/orbit controls
│   │   │
│   │   ├── ui/                     # DOM-based UI components
│   │   │   ├── Menu.tsx            # Main menu screen
│   │   │   ├── Toolbar.tsx         # Tool selection panel
│   │   │   ├── FurnitureLibrary.tsx # Draggable furniture panel
│   │   │   ├── QuestionCreator.tsx # Area/perimeter question UI
│   │   │   ├── ProgressBar.tsx     # Student progress indicator
│   │   │   ├── ControlsHint.tsx    # Persistent controls legend
│   │   │   ├── PauseOverlay.tsx    # Pause menu
│   │   │   ├── TutorialOverlay.tsx # First-time tutorial
│   │   │   ├── Snackbar.tsx        # Toast notifications
│   │   │   └── ExportModal.tsx     # Teacher export dialog
│   │   │
│   │   └── shared/                 # Reusable UI primitives
│   │       ├── Button.tsx
│   │       ├── IconButton.tsx
│   │       └── Panel.tsx
│   │
│   ├── stores/
│   │   ├── designStore.ts          # Grid state, cells, rooms, furniture
│   │   ├── toolStore.ts            # Current tool, tool settings
│   │   ├── historyStore.ts         # Undo/redo stack (30+ steps)
│   │   ├── gameStateStore.ts       # menu/playing/paused/gameover
│   │   ├── progressStore.ts        # Student progress metrics
│   │   └── questionStore.ts        # Generated questions state
│   │
│   ├── hooks/
│   │   ├── useGridInteraction.ts   # Pointer/touch grid editing
│   │   ├── useUndo.ts              # Undo/redo keyboard shortcuts
│   │   ├── useLocalStorage.ts      # Persistence helpers
│   │   └── useTouchGestures.ts     # Pinch-zoom, pan detection
│   │
│   ├── utils/
│   │   ├── geometry.ts             # Area/perimeter calculations
│   │   ├── validation.ts           # Room enclosure detection
│   │   ├── storage.ts              # localStorage with THDS_ keys
│   │   └── export.ts               # JSON export for teachers
│   │
│   ├── types/
│   │   └── index.ts                # TypeScript interfaces
│   │
│   └── constants/
│       ├── colors.ts               # GDD color palette
│       ├── houseTypes.ts           # Shipping Container, Cabin, School Bus
│       └── furniture.ts            # Furniture library definitions
```

## Color System (from GDD)

```typescript
export const colors = {
  primary: '#0B57A4',      // Action buttons, selection
  success: '#1FA65A',      // Saved, valid
  warning: '#FFB020',      // Highlights, tool active
  danger: '#E4572E',       // Invalid, delete
  background: '#F6F7F9',   // Main background
  gridMinor: '#E2E6EA',    // Grid lines
  gridMajor: '#C5D0D6',    // Major grid lines (every 4ft)
  text: '#2D2D2D',         // Primary text
  panel: '#FFFFFF',        // Cards, panels

  // Room fill palette (8 colors)
  rooms: ['#E8E0F0', '#B2D8D8', '#E8DCC8', '#C8E6C9',
          '#FFCCBC', '#BBDEFB', '#F5F5DC', '#E0E0E0']
};
```

## Core Architecture Decisions

### 1. Three.js Grid Approach
- Use orthographic camera for true 2D feel with 3D capabilities
- Grid rendered as plane geometry with custom shader for lines
- Each cell is a mesh that can be clicked/modified
- Raycasting for pointer detection on grid
- Room fills rendered as extruded shapes for visual depth

### 2. State Management (Zustand)
```typescript
// designStore.ts - Core design state
interface DesignState {
  gridWidth: number;      // in feet
  gridHeight: number;
  cells: Map<string, CellData>;  // "x,y" -> cell data
  rooms: Room[];
  furniture: FurnitureItem[];
  doors: Door[];
  windows: Window[];

  // Actions
  paintCell: (x: number, y: number, type: CellType) => void;
  eraseCell: (x: number, y: number) => void;
  addFurniture: (item: FurnitureItem) => void;
  // ... etc
}

// historyStore.ts - Undo/redo with 30+ step limit
interface HistoryState {
  past: DesignState[];
  future: DesignState[];

  pushState: (state: DesignState) => void;
  undo: () => void;
  redo: () => void;
}
```

### 3. House Types (Grid Sizes)
| Type | Grid Size (ft) | Pixel Size (48px/cell) |
|------|---------------|------------------------|
| Shipping Container | 8 x 20 | 384 x 960 |
| Cabin | 12 x 16 | 576 x 768 |
| School Bus | 8 x 35 | 384 x 1680 |

### 4. Tool System
```typescript
type Tool = 'wall' | 'erase' | 'door' | 'window' | 'furniture' | 'label' | 'select';

// Tool behaviors handled in useGridInteraction hook
// Each tool has: cursor icon, click behavior, drag behavior
```

## Implementation Phases

### Phase 1: Foundation (Setup + Grid)
1. Initialize Vite + React + TypeScript project
2. Install dependencies (three, @react-three/fiber, @react-three/drei, zustand, tailwindcss, lucide-react)
3. Configure Tailwind with GDD color palette
4. Create basic Scene component with orthographic camera
5. Implement interactive Grid with cell highlighting
6. Add basic CameraControls (zoom/pan)

### Phase 2: Core Design Tools
1. Implement designStore with cell painting
2. Build Toolbar component with tool icons
3. Create useGridInteraction hook for pointer/touch
4. Implement wall/erase/select tools
5. Add room fill detection and coloring
6. Build historyStore with undo/redo (Ctrl+Z/Y)

### Phase 3: UI & Navigation
1. Create Menu screen with house type selection
2. Build gameStateStore for state transitions
3. Implement PauseOverlay
4. Add ControlsHint panel
5. Create TutorialOverlay for first-time users
6. Add ProgressBar component

### Phase 4: Advanced Features
1. Implement door/window placement tools
2. Build FurnitureLibrary with drag-to-place
3. Add furniture snapping and rotation
4. Create QuestionCreator for area/perimeter
5. Implement validation (enclosure detection)
6. Add near-miss feedback system

### Phase 5: Persistence & Polish
1. Implement localStorage save/load
2. Build teacher export (JSON)
3. Add animations and "juice" effects
4. Implement touch gestures (pinch-zoom, two-finger pan)
5. Add accessibility (keyboard nav, ARIA labels, high-contrast)
6. Mobile responsive layout

## Key Files to Create

| File | Purpose | Priority |
|------|---------|----------|
| `src/components/canvas/Scene.tsx` | R3F Canvas, camera, lighting | P0 |
| `src/components/canvas/Grid.tsx` | Interactive grid floor | P0 |
| `src/stores/designStore.ts` | Core design state | P0 |
| `src/hooks/useGridInteraction.ts` | Pointer/touch handling | P0 |
| `src/components/ui/Toolbar.tsx` | Tool selection | P1 |
| `src/components/ui/Menu.tsx` | Main menu | P1 |
| `src/stores/historyStore.ts` | Undo/redo | P1 |

## Verification Plan

1. **Dev Server**: `npm run dev` should start without errors
2. **Grid Interaction**: Click/drag on grid paints cells
3. **Tools**: Each tool works correctly (wall, erase, door, window, furniture)
4. **Undo/Redo**: Ctrl+Z/Y works for 30+ steps
5. **Save/Load**: Designs persist in localStorage
6. **Touch**: Pinch-zoom and pan work on tablet
7. **Menu Flow**: Can navigate menu -> design -> pause -> menu
8. **Questions**: Can create area/perimeter questions from selected regions
9. **Export**: Teacher can download JSON of design + questions

## Questions for Clarification

1. **3D vs 2D**: Should the Three.js view be purely top-down 2D, or allow some 3D perspective/tilt for visual interest?

2. **Furniture Models**: Should furniture be:
   - Simple 2D shapes/icons (faster to implement)
   - Basic 3D primitives (boxes, cylinders)
   - Detailed 3D models (requires GLTF assets)

3. **Mobile Priority**: Is tablet/mobile a primary target, or desktop-first?

