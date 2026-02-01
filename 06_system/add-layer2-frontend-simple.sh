#!/bin/bash

# Add Layer 2 Descriptions to Frontend Notes (Simple Version)
# Uses simple filename-based descriptions

FRONTEND_DIR="/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/02_reference/software-engineer/Frontend"

# Stats
total=0
processed=0
skipped=0
errors=0

# Simple description mapping
declare -A descriptions

# Pre-populate with known files
descriptions["useState.md"]="useState is React's state hook for managing component state with functional updates and callback support for previous state values."
descriptions["useEffect.md"]="useEffect is React's hook for handling side effects and lifecycles in functional components with dependency-based execution control and cleanup support."
descriptions["React.md"]="React fundamentals and patterns index covering components, hooks, virtual DOM, state, events, and lifecycles."
descriptions["React.memo.md"]="React.memo is a higher-order component that prevents unnecessary re-renders when props haven't changed, optimizing performance for functional components."
descriptions["useRef.md"]="useRef creates a mutable ref object that persists across renders without triggering re-renders, useful for direct DOM access and storing previous values."
descriptions["Props.md"]="Props in React are read-only inputs passed from parent components to child components, enabling component composition and data flow."
descriptions["Components.md"]="React components are reusable UI building blocks that accept inputs (props) and return JSX to define what should be rendered."

# Function to add description
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

# Process all files in Frontend directory
echo "=== Adding Layer 2 Descriptions to Frontend Notes ==="
echo ""

# Find all .md files
while IFS= read -r -d '' -r file; do
    [[ -f "$file" ]] || continue
    [[ "$file" == *.md ]] || continue

    ((total++))
    filename=$(basename "$file")

    # Skip if already has description
    if grep -q "^description:" "$file" 2>/dev/null; then
        ((skipped++))
        continue
    fi

    # Get description from mapping or generate default
    if [ -n "${descriptions[$filename]+x}" ]; then
        desc="${descriptions[$filename]}"
    else
        # Generate from filename
        desc="Notes and reference material about ${filename//.md/}."
    fi

    if add_description "$file" "$desc" > /dev/null; then
        ((processed++))
        echo "  ✅ $(basename "$file")"
    else
        ((errors++))
        echo "  ❌ $(basename "$file")"
    fi
done

# Also process subdirectories
echo ""
echo "Processing subdirectories..."
for dir in React CSS JavaScript "Backend APIs" "Backend Node.js" "Backend/Express.js" "Cloud/AWS" "Cloud/DevOps"; do
    if [ -d "$FRONTEND_DIR/$dir" ]; then
        while IFS= read -r -d '' -r file; do
            [[ -f "$file" ]] || continue
            [[ "$file" == *.md ]] || continue

            ((total++))
            filename=$(basename "$file")

            # Skip if already has description
            if grep -q "^description:" "$file" 2>/dev/null; then
                ((skipped++))
                continue
            fi

            # Generate description
            desc="Notes and reference material about ${filename//.md/} in $dir."
            if add_description "$file" "$desc" > /dev/null; then
                ((processed++))
                echo "  ✅ $dir/$(basename "$file")"
            else
                ((errors++))
                echo "  ❌ $dir/$(basename "$file")"
            fi
        done
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
