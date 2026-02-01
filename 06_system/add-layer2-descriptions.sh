#!/bin/bash

# Add Layer 2 YAML Descriptions to All Notes
# Adds description field to YAML frontmatter for notes that don't have one

VAULT_DIR="/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook"

# Stats
total=0
processed=0
skipped=0
errors=0

# Function to generate description from filename
generate_description() {
    local file="$1"
    local filename
    local desc=""

    filename=$(basename "$file" .md)

    # Handle daily notes (inbox/daily/)
    if [[ "$file" =~ 00_inbox/daily ]]; then
        desc="Daily note captured on ${filename//.md/}"
    # Handle templates
    elif [[ "$file" =~ templates ]]; then
        desc="Template for creating notes of this type."
    # Handle README files
    elif [[ "$file" =~ README ]]; then
        desc="Documentation and overview of this directory or project."
    # Handle files with questions
    elif [[ "$file" =~ \?$ ]]; then
        desc="Question and answer about ${filename//\?/.md/}."
    # Claim-based titles (good ones)
    elif [[ "$file" =~ [A-Z] ]] && [[ ! "$file" =~ [0-9]{4}-[0-9]{2} ]]; then
        # Already claim-based, try to convert to description
        desc="Notes about ${filename//.md/}."
    else
        # Fallback
        desc="Notes and reference material about ${filename//.md/}."
    fi

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
    local priority="$2"

    echo "Processing $dir (priority: $priority)..."
    local count=0

    find "$VAULT_DIR/$dir" -name "*.md" -type f | while read file; do
        # Skip if already has description
        if grep -q "^description:" "$file" 2>/dev/null; then
            ((skipped++))
            continue
        fi

        ((total++))
        desc=$(generate_description "$file")

        if add_description "$file" "$desc" > /dev/null; then
            ((processed++))
            ((count++))
        else
            ((errors++))
        fi
    done

    echo "  → Processed $count notes in $dir"
}

# Main
echo "=== Adding Layer 2 YAML Descriptions ==="
echo ""

# Priority order based on importance
echo "Priority 1: 02_reference/tools/"
process_directory "02_reference/tools" 1

echo ""
echo "Priority 2: 02_reference/approaches/"
process_directory "02_reference/approaches" 2

echo ""
echo "Priority 3: 02_reference/software-engineer/"
process_directory "02_reference/software-engineer" 3

echo ""
echo "Priority 4: 06_system/templates/"
process_directory "06_system/templates" 4

echo ""
echo "Priority 5: 00_inbox/ (excluding daily/)"
find "$VAULT_DIR/00_inbox" -name "*.md" -type f ! -path "*/daily/*" | while read file; do
    if ! grep -q "^description:" "$file" 2>/dev/null; then
        ((total++))
        desc=$(generate_description "$file")
        if add_description "$file" "$desc" > /dev/null; then
            ((processed++))
            echo "  → $(basename "$file")"
        else
            ((errors++))
        fi
    else
        ((skipped++))
    fi
done

echo ""
echo "Priority 6: 03_creating/drafts/"
process_directory "03_creating/drafts" 6

echo ""
echo "Priority 7: 04_published/"
process_directory "04_published" 7

echo ""
echo "=== Summary ==="
echo "Total files checked: $total"
echo "Processed: $processed"
echo "Skipped (already has description): $skipped"
echo "Errors: $errors"
echo ""
echo "Done! Run './vault-ops.sh validate' to verify all notes have descriptions."
