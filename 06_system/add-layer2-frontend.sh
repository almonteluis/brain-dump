#!/bin/bash

# Add Layer 2 Descriptions to Frontend Notes
# Intelligent description generation based on content analysis

FRONTEND_DIR="/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/02_reference/software-engineer/Frontend"

# Stats
total=0
processed=0
skipped=0
errors=0

# Function to generate description based on file content and filename
generate_smart_description() {
    local file="$1"
    local filename
    local relpath
    local desc=""

    filename=$(basename "$file" .md)
    relpath="${file#$FRONTEND_DIR/}"

    # Read first few lines and headings to understand content
    local first_line=$(head -5 "$file" | grep -v "^---$" | head -1)
    local headings=$(grep "^#" "$file" | head -3)

    # Generate description based on content analysis
    case "$filename" in
        # React hooks - specific patterns
        useState*)
            desc="useState is React's state hook for managing component state with functional updates and callback support for previous state values."
            ;;
        useEffect*)
            desc="useEffect is React's hook for handling side effects and lifecycles in functional components with dependency-based execution control and cleanup support."
            ;;
        useRef*)
            desc="useRef creates a mutable ref object that persists across renders without triggering re-renders, useful for direct DOM access and storing previous values."
            ;;
        useCallback*)
            desc="useCallback memoizes callback functions to prevent unnecessary re-renders of child components, especially when passed as props."
            ;;
        useMemo*)
            desc="useMemo caches expensive calculations and only recomputes when dependencies change, optimizing performance for costly operations."
            ;;
        React.memo*)
            desc="React.memo is a higher-order component that prevents unnecessary re-renders when props haven't changed, optimizing performance for functional components."
            ;;
        useContext*)
            desc="useContext provides access to React context data in functional components, avoiding prop drilling and sharing state across component tree."
            ;;
        useReducer*)
            desc="useReducer is an alternative to useState for complex state logic, managing state transitions with predictable reducer functions."
            ;;
        Suspense*)
            desc="React Suspense enables lazy loading and data fetching with fallback UI, improving perceived performance and loading experience."
            ;;

        # React core concepts
        React.md)
            desc="React is a JavaScript library for building user interfaces with components, managing state and rendering updates efficiently."
            ;;
        Components*)
            desc="React components are reusable UI building blocks that accept inputs (props) and return JSX to define what should be rendered."
            ;;
        Props*)
            desc="Props in React are read-only inputs passed from parent components to child components, enabling component composition and data flow."
            ;;
        JSX*)
            desc="JSX is a syntax extension for JavaScript that allows writing HTML-like code in JavaScript files, which React compiles to function calls."
            ;;
        Virtual*)
            desc="Virtual DOM is a lightweight JavaScript representation of the real DOM that React uses to optimize rendering by minimizing direct DOM manipulation."
            ;;

        # React patterns
        "Higher-Order Components"*)
            desc="Higher-order components are functions that take a component and return a new component with enhanced functionality or props."
            ;;
        "Controlled Components"*)
            desc="Controlled components receive their current value and an update callback function, giving parent full control over component state."
            ;;
        "Uncontrolled Components"*)
            desc="Uncontrolled components manage their own internal state using refs, useful for simple form inputs where precise control isn't needed."
            ;;
        "Custom Hooks"*)
            desc="Custom hooks are reusable functions that encapsulate stateful logic, can be called from functional components to share behavior."
            ;;

        # Patterns
        "Design Patterns"*)
            desc="Design patterns are reusable solutions to common problems in software design, providing proven templates for component architecture."
            ;;
        "Code Splitting"*)
            desc="Code splitting divides code into smaller chunks loaded on demand, reducing initial bundle size and improving load performance."
            ;;
        "Debounce"*)
            desc="Debouncing limits function execution rate by waiting for a pause after the last call, preventing excessive execution during rapid events."
            ;;
        "Throttle"*)
            desc="Throttling limits function execution to once per time interval, ensuring functions don't fire more frequently than specified period."
            ;;
        "Tree Shaking"*)
            desc="Tree shaking eliminates dead code from bundles during build, reducing final bundle size by removing unused exports."
            ;;

        # Languages
        "TypeScript"*)
            desc="TypeScript is a typed superset of JavaScript that adds static type checking, improving code quality and developer experience."
            ;;
        "JavaScript"*)
            desc="JavaScript is the programming language of the web, enabling dynamic and interactive content in browsers."
            ;;

        # Frontend technologies
        "CSS"*)
            desc="CSS (Cascading Style Sheets) is the styling language for the web, controlling layout, colors, fonts, and responsive design."
            ;;
        "HTML"*)
            desc="HTML (HyperText Markup Language) is the standard markup language for creating web pages and defining their structure and content."
            ;;
        "Browser"*)
            desc="Browser technologies cover DOM manipulation, storage APIs, rendering engines, and web platform capabilities."
            ;;
        "API"*)
            desc="API (Application Programming Interface) defines methods for communication between software components, especially HTTP requests for data fetching."
            ;;
        "Performance"*)
            desc="Performance optimization techniques focus on improving load times, rendering efficiency, resource usage, and user experience."
            ;;

        # Generic fallback - try to extract from content
        *)
            # Extract first heading or question
            if [ -n "$headings" ]; then
                desc=$(echo "$headings" | head -1 | sed 's/^#[[:space:]]*//' | sed 's/[[:space:]]/ /g')
                desc="${desc}."
            fi

            # If still empty, use filename as fallback
            if [ -z "$desc" ]; then
                # Convert kebab-case or spaces to sentence
                desc=$(echo "$filename" | sed 's/-/ /g' | sed 's/\([A-Z]\)/ \1/g')
                desc="Notes and reference material about $desc."
            fi
            ;;
    esac

    echo "$desc"
}

# Function to add description to a file
add_description() {
    local file="$1"
    local desc="$2"

    # Check if file has YAML frontmatter
    if grep -q "^---" "$file" 2>/dev/null; then
        # Has frontmatter, check if it has description
        if grep -q "^description:" "$file" 2>/dev/null; then
            return 0  # Already has description
        else
            # Add description after the first ---
            sed -i "0,/^---$/a description: $desc/" "$file"
            return 1
        fi
    else
        # No frontmatter, add it
        sed -i "1i\\
---\\
description: $desc\\
---\\
" "$file"
        return 2
    fi
}

# Function to process directory
process_directory() {
    local dir="$1"
    local count=0

    echo "Processing $dir/..."

    find "$dir" -name "*.md" -type f | sort | while read file; do
        # Skip if already has description
        if grep -q "^description:" "$file" 2>/dev/null; then
            ((skipped++))
            continue
        fi

        ((total++))
        desc=$(generate_smart_description "$file")
        relpath="${file#$FRONTEND_DIR/}"

        if add_description "$file" "$desc" > /dev/null; then
            ((processed++))
            ((count++))
            echo "  ✅ $(basename "$file")"
            echo "     → $desc"
        else
            ((errors++))
            echo "  ❌ $(basename "$file") - failed to add description"
        fi
    done

    echo ""
    echo "  → Processed $count notes in $dir/"
}

# Main
echo "=== Adding Layer 2 Descriptions to Frontend Notes ==="
echo ""

# Process all subdirectories in frontend
for subdir in React CSS JavaScript "Backend APIs" Backend Node.js Cloud DevOps Architecture Patterns Quick Reference; do
    if [ -d "$FRONTEND_DIR/$subdir" ]; then
        echo "---"
        process_directory "$FRONTEND_DIR/$subdir"
    fi
done

# Process root-level files in frontend
echo "---"
echo "Processing root-level files..."
root_count=0
find "$FRONTEND_DIR" -maxdepth 1 -name "*.md" -type f | sort | while read file; do
    if ! grep -q "^description:" "$file" 2>/dev/null; then
        ((total++))
        desc=$(generate_smart_description "$file")
        relpath="${file#$FRONTEND_DIR/}"

        if add_description "$file" "$desc" > /dev/null; then
            ((processed++))
            ((root_count++))
            echo "  ✅ $(basename "$file")"
            echo "     → $desc"
        else
            ((errors++))
            echo "  ❌ $(basename "$file") - failed to add description"
        fi
    else
        ((skipped++))
    fi
done

echo ""
echo "=== Summary ==="
echo "Total files checked: $total"
echo "Processed: $processed"
echo "Skipped (already has description): $skipped"
echo "Errors: $errors"
echo ""
echo "Done! Run './vault-ops.sh validate' to verify all notes have descriptions."
