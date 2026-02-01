#!/usr/bin/env python3

import os
import re

react_dir = "02_reference/software-engineer/Frontend"
total = 0
processed = 0

# React hooks - specific patterns
hooks_mapping = {
    "useState.md": "useState is React's state hook for managing component state with functional updates and callback support for previous state values.",
    "useEffect.md": "useEffect is React's hook for handling side effects and lifecycles in functional components with dependency-based execution control and cleanup support.",
    "useRef.md": "useRef creates a mutable ref object that persists across renders without triggering re-renders, useful for direct DOM access and storing previous values.",
    "useCallback.md": "useCallback memoizes callback functions to prevent unnecessary re-renders of child components, especially when passed as props.",
    "useMemo.md": "useMemo caches expensive calculations and only recomputes when dependencies change, optimizing performance for costly operations.",
    "useContext.md": "useContext provides access to React context data in functional components, avoiding prop drilling and sharing state across component tree.",
    "useReducer.md": "useReducer is an alternative to useState for complex state logic, managing state transitions with predictable reducer functions.",
    "React.memo.md": "React.memo is a higher-order component that prevents unnecessary re-renders when props haven't changed, optimizing performance for functional components.",
    "Context.md": "Context provides a way to pass data through the component tree without manually passing props at every level.",
    "Custom Hooks.md": "Custom hooks are reusable functions that encapsulate stateful logic, can be called from functional components to share behavior.",
    "Suspense.md": "React Suspense enables lazy loading and data fetching with fallback UI, improving perceived performance and loading experience.",
    "Suspense Fundamentals.md": "React Suspense fundamentals covering lazy loading, data fetching patterns, and error boundaries with fallback UI."
}

# General React concepts
concepts_mapping = {
    "React.md": "React is a JavaScript library for building user interfaces with components, managing state and rendering updates efficiently.",
    "Components.md": "React components are reusable UI building blocks that accept inputs (props) and return JSX to define what should be rendered.",
    "Props.md": "Props in React are read-only inputs passed from parent components to child components, enabling component composition and data flow.",
    "React Fundamentals Flashcards.md": "React fundamentals flashcards covering core concepts, hooks, components, and patterns for interview preparation.",
    "Hooks.md": "React hooks are functions that let you use state and other React features without writing a class, providing simpler code with better logic reuse.",
    "useCallBack.md": "useCallback is React's hook for memoizing callback functions to prevent unnecessary re-renders, improving performance.",
    "useEffect quiz.md": "Quiz and practice questions for understanding useEffect hook patterns, edge cases, and best practices."
}

# Patterns and best practices
patterns_mapping = {
    "Best Practices for Hooks.md": "Best practices for using React hooks including dependency management, cleanup, and avoiding common pitfalls.",
    "Common Patterns for useEffect.md": "Common patterns for using useEffect including data fetching, event listeners, and cleanup functions.",
    "Props.md": "Props documentation covering controlled/uncontrolled components, prop types, and prop drilling solutions.",
    "Meta React Performance.md": "Meta React performance patterns and optimization techniques for improving application rendering speed and efficiency.",
    "Performance Patterns.md": "Collection of performance patterns and optimization techniques for frontend applications.",
}

# Performance
performance_mapping = {
    "handle loading and error states.md": "Pattern for handling loading and error states in React data fetching with user-friendly UI feedback.",
    "Meta React Performance.md": "Performance patterns and techniques for React applications including rendering optimization and bundle size reduction.",
    "Performance Patterns.md": "Collection of performance patterns and optimization techniques for frontend applications.",
}

# Other
other_mapping = {
    "getDerivedStateFromProps.md": "getDerivedStateFromProps is a static lifecycle method for deriving state from props before rendering.",
    "shouldComponentUpdate.md": "shouldComponentUpdate is a lifecycle method that prevents re-renders by comparing previous and next props.",
    "Collette Travel Booking Engine Step 2 Customizations Implementation React.md": "Collette travel booking customization implementation using React.",
    "turning UI into react components.md": "Guide on converting existing UI designs into reusable React components.",
    "mental model for React.md": "Mental model for understanding React's rendering cycle, component lifecycle, and state management patterns.",
}

# Combine all mappings
all_mappings = {**hooks_mapping, **concepts_mapping, **patterns_mapping, **performance_mapping, **other_mapping}

for root, dirs, files in os.walk(react_dir):
    for filename in files:
        if not filename.endswith(".md"):
            continue
            
        filepath = os.path.join(root, filename)
        
        total += 1
        
        # Skip if already has description
        try:
            with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
                if 'description:' in f.read():
                    continue
        except:
            pass
        
        # Get description from mappings
        desc = None
        for mapping in all_mappings.values():
            if filename in mapping:
                desc = mapping[filename]
                break
        
        # Fallback: generate from filename if not in mapping
        if not desc:
            # Extract key concepts from filename
            filename_base = filename[:-3]  # remove .md
            
            # Hooks
            if "use" in filename and filename.endswith(".md"):
                hook_name = filename_base.replace("use", "")
                desc = f"React's {hook_name} hook for managing specific {hook_name} functionality in functional components."
            elif "Custom Hooks" in filename:
                desc = "Collection of custom React hooks that encapsulate reusable stateful logic for sharing across components."
            elif "Hooks.md" in filename:
                desc = "Comprehensive guide to React hooks for state management, side effects, and lifecycle patterns in functional components."
            
            # Concepts
            elif "Components" in filename:
                desc = "React component patterns and best practices for building reusable UI elements and component composition."
            elif "Props" in filename:
                desc = "Props enable data flow between parent and child components, supporting controlled and uncontrolled patterns."
            elif "Controlled" in filename or "Uncontrolled" in filename:
                desc = "Controlled and uncontrolled component patterns for managing form inputs and component state in React."
            elif "Virtual" in filename or "Virtual DOM" in filename:
                desc = "Virtual DOM is React's optimization technique for efficient rendering by minimizing direct DOM manipulations."
            
            # Patterns
            elif "Pattern" in filename:
                desc = "Reusable React design patterns for solving common component architecture and state management problems."
            elif "Performance" in filename:
                desc = "React performance optimization techniques including rendering optimization, memoization, and bundle size reduction."
            elif "Optimization" in filename:
                desc = "Strategies for optimizing React application performance including code splitting, lazy loading, and memoization."
            elif "Best" in filename:
                desc = "Best practices and guidelines for writing clean, maintainable, and performant React code."
            elif "Common" in filename:
                desc = "Common patterns and solutions for frequently encountered React development challenges and scenarios."
            elif "Implementation" in filename:
                desc = "Implementation details and code examples for specific React features and patterns."
            
            # Technologies
            elif "Type" in filename:
                desc = "Type safety and type checking in React applications using TypeScript for improved code quality."
            elif "TypeScript" in filename:
                desc = "TypeScript adds static type checking to JavaScript, preventing runtime errors and improving developer experience."
            elif "JavaScript" in filename:
                desc = "JavaScript fundamentals and patterns used in React development and modern web applications."
            
            # API-related
            elif "API" in filename or "Fetch" in filename or "Axios" in filename:
                desc = "API integration and data fetching patterns for communicating with backend services in React applications."
            elif "Authentication" in filename:
                desc = "User authentication and authorization patterns for securing React applications and managing user sessions."
            elif "State" in filename:
                desc = "React state management patterns including hooks, context, and external libraries like Redux or Zustand."
            
            # Architecture
            elif "Architecture" in filename:
                desc = "React application architecture patterns including component hierarchy, data flow, and state management strategies."
            
            # Generic fallback
            else:
                desc = f"React notes and reference material about {filename_base}."

        # Add description
        try:
            with open(filepath, 'r', encoding='utf-8') as f:
                content = f.read()
                
            if '---' in content:
                # Has frontmatter, add description after first ---
                lines = content.split('\n')
                new_lines = []
                inserted = False
                
                for line in lines:
                    new_lines.append(line)
                    if line.strip() == '---' and not inserted:
                        new_lines.append(f"description: {desc}")
                        inserted = True
                
                with open(filepath, 'w', encoding='utf-8') as f:
                    f.write('\n'.join(new_lines))
                    
                processed += 1
                print(f"✅ {filename}")
                
        except Exception as e:
            print(f"❌ {filename} - {e}")

print(f"\nDone! Processed {processed}/{total} files.")
