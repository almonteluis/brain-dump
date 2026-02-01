#!/bin/bash

# Spatial Edit Script for Obsidian Vault
# Processes inline edit instructions in curly braces {like this}
# Usage: ./spatial-edit.sh [file1.md] [file2.md] ...
#
# If no files specified, searches vault for {thought} patterns and lists them

VAULT_DIR="/Users/lalmonte/Library/Mobile Documents/iCloud~md~obsidian/Documents/Software Engineering Notebook"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

show_help() {
    cat << EOF
${CYAN}Spatial Edit${NC} — Process inline edit instructions in markdown files

${YELLOW}USAGE:${NC}
    ./spatial-edit.sh [file1.md] [file2.md] ...
    ./spatial-edit.sh --all
    ./spatial-edit.sh --interactive

${YELLOW}DESCRIPTION:${NC}
    Finds and processes inline edit instructions marked with curly braces.
    Each comment applies to its surrounding text.

${GREEN}  EXAMPLE INLINE EDITS:${NC}
      "This feels vague {be more specific}"      → expands with details
      "Too wordy {tighten}"                      → makes concise
      "Add link to [[concept]]"                  → inserts wiki-link

${YELLOW}OPTIONS:${NC}
    ${CYAN}--all${NC}           Process all files with {thoughts} in vault
    ${CYAN}--interactive${NC}   Show files and let you pick which to edit
    ${CYAN}--list${NC}          List all files with {thoughts} (no edits)
    ${CYAN}--help${NC}          Show this help message

${YELLOW}EXAMPLES:${NC}
    # Edit specific files
    ./spatial-edit.sh "01_thinking/notes/draft.md"

    # List all files needing edits
    ./spatial-edit.sh --list

    # Interactive mode - pick which files to edit
    ./spatial-edit.sh --interactive

    # Process everything (brave!)
    ./spatial-edit.sh --all
EOF
}

# Find all markdown files containing curly brace patterns
find_files_with_edits() {
    find "$VAULT_DIR" -name "*.md" \
        ! -path "*/.git/*" \
        ! -path "*/.obsidian/*" \
        ! -path "*/node_modules/*" \
        -exec grep -l "{[^}]*}" {} \; 2>/dev/null
}

# Count edit instructions in a file
count_edits() {
    local file="$1"
    grep -o "{[^}]*}" "$file" 2>/dev/null | wc -l | tr -d ' '
}

# List all files with edit counts
list_editable_files() {
    echo -e "${BLUE}=== Files with Spatial Edits ===${NC}\n"

    local found=false
    local total_files=0
    local total_edits=0

    while IFS= read -r file; do
        if [ -f "$file" ]; then
            relative_path="${file#$VAULT_DIR/}"
            edit_count=$(count_edits "$file")

            if [ "$edit_count" -gt 0 ]; then
                echo -e "${CYAN}📝 $relative_path${NC}"
                echo "   ${YELLOW}$edit_count${NC} edit(s) found"
                echo ""
                total_files=$((total_files + 1))
                total_edits=$((total_edits + edit_count))
                found=true
            fi
        fi
    done < <(find_files_with_edits)

    if [ "$found" = false ]; then
        echo -e "${GREEN}✓ No files with edit instructions found.${NC}"
    else
        echo -e "${BLUE}Total: $total_files files, $total_edits edits${NC}"
    fi
}

# Interactive file selection
interactive_mode() {
    local files=()
    local index=1

    while IFS= read -r file; do
        if [ -f "$file" ]; then
            edit_count=$(count_edits "$file")
            if [ "$edit_count" -gt 0 ]; then
                relative_path="${file#$VAULT_DIR/}"
                files+=("$file")
                echo -e "${CYAN}[$index]${NC} $relative_path ${YELLOW}($edit_count edits)${NC}"
                index=$((index + 1))
            fi
        fi
    done < <(find_files_with_edits)

    if [ ${#files[@]} -eq 0 ]; then
        echo -e "${GREEN}No files with edit instructions found.${NC}"
        return 0
    fi

    echo ""
    echo -e "${YELLOW}Enter file numbers to edit (comma-separated, or 'all'):${NC} "
    read -r selection

    if [ "$selection" = "all" ]; then
        for file in "${files[@]}"; do
            process_file "$file"
        done
    else
        IFS=',' read -ra selected_indices <<< "$selection"
        for idx in "${selected_indices[@]}"; do
            idx=$((idx - 1))
            if [ $idx -ge 0 ] && [ $idx -lt ${#files[@]} ]; then
                process_file "${files[$idx]}"
            fi
        done
    fi
}

# Process a single file - outputs instructions for Claude
process_file() {
    local file="$1"
    local relative_path="${file#$VAULT_DIR/}"
    local edit_count=$(count_edits "$file")

    echo -e "\n${BLUE}=== Processing: $relative_path ===${NC}"
    echo -e "${YELLOW}Found $edit_count edit instruction(s)${NC}\n"

    # Create a temp file with instructions
    local tmp_instructions=$(mktemp)
    cat > "$tmp_instructions" << EOF
# Spatial Edit Request

Please process the spatial edit instructions in the following markdown file.

**File:** \`$relative_path\`

**Instructions:**
- Curly braces \`{...}\}` contain edit instructions for the surrounding text
- Apply each instruction to improve the text
- Remove the curly braces after applying
- Preserve the original markdown structure and formatting
- Keep wiki-links, YAML frontmatter, and tags intact

**Output format:**
After editing, provide a summary like:
\`\`\`
processed N edits in filename.md:
1. "{instruction}" → brief description of change
2. "{instruction}" → brief description of change
...
\`\`\`

---

**File content:**
EOF

    # Output combined instructions + file content
    cat "$tmp_instructions"
    cat "$file"
    rm "$tmp_instructions"

    echo -e "\n${GREEN}--- End of file — please process the edits above ---${NC}\n"
}

# Main execution
case "${1:-}" in
    --help|-h)
        show_help
        ;;
    --list)
        list_editable_files
        ;;
    --interactive|-i)
        interactive_mode
        ;;
    --all)
        echo -e "${BLUE}=== Processing all files with edits ===${NC}\n"
        while IFS= read -r file; do
            if [ -f "$file" ]; then
                process_file "$file"
            fi
        done < <(find_files_with_edits)
        ;;
    "")
        # No arguments - show list
        list_editable_files
        echo ""
        echo -e "${YELLOW}Tip: Run './spatial-edit.sh --interactive' to pick files to edit${NC}"
        ;;
    *)
        # Process specific files
        for arg in "$@"; do
            if [[ "$arg" == *.md ]]; then
                if [ -f "$VAULT_DIR/$arg" ]; then
                    process_file "$VAULT_DIR/$arg"
                elif [ -f "$arg" ]; then
                    process_file "$arg"
                else
                    echo -e "${RED}Error: File not found: $arg${NC}"
                fi
            else
                echo -e "${RED}Error: Not a markdown file: $arg${NC}"
            fi
        done
        ;;
esac
