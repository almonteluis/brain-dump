#!/bin/bash

# Vault Operations Script
# Unified command interface for Obsidian vault tasks
# Usage: ./vault-ops.sh [command] [options]

VAULT_DIR="/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook"

show_help() {
    echo "Vault Operations Script"
    echo "====================="
    echo ""
    echo "Usage: $0 [command] [options]"
    echo ""
    echo "Commands:"
    echo "  tree           Show vault structure (Layer 1: File Tree)"
    echo "  find           Search notes by description (Layer 2: YAML Descriptions)"
    echo "  outline         Show headings of a note (Layer 3: Outline)"
    echo "  process         List all #to-process items in inbox"
    echo "  orphans         Find notes with no wiki-links"
    echo "  broken          Find broken wiki-links"
    echo "  validate        Check YAML frontmatter and descriptions"
    echo "  edit           Process spatial edits {instructions} in files"
    echo "  help           Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 tree"
    echo "  $0 find 'claim'"
    echo "  $0 outline '00_inbox/Links/link-template.md'"
    echo "  $0 process"
    echo "  $0 edit '01_thinking/notes/draft.md'"
}

show_tree() {
    "$VAULT_DIR/06_system/vault-tree-generator.sh"
}

find_notes() {
    local query="$1"
    if [ -z "$query" ]; then
        echo "Usage: $0 find \"[search term]\""
        return 1
    fi

    echo "=== Notes matching: $query ==="
    echo ""

    find "$VAULT_DIR" -name "*.md" -exec grep -l "description:" {} \; | while read file; do
        description=$(grep "description:" "$file" | head -1 | sed 's/description: *//')
        if echo "$description" | grep -i "$query" > /dev/null; then
            relative_path="${file#$VAULT_DIR/}"
            echo "📄 $relative_path"
            echo "   $description"
            echo ""
        fi
    done
}

show_outline() {
    local note="$1"
    if [ -z "$note" ]; then
        echo "Usage: $0 outline \"[note path]\""
        return 1
    fi

    if [ ! -f "$VAULT_DIR/$note" ]; then
        echo "Error: Note not found: $note"
        return 1
    fi

    echo "=== Outline: $note ==="
    echo ""

    grep "^#" "$VAULT_DIR/$note" | sed 's/^#/   /'
}

list_process() {
    echo "=== Items to Process (#to-process) ==="
    echo ""

    find "$VAULT_DIR" -name "*.md" -exec grep -l "#to-process" {} \; | while read file; do
        relative_path="${file#$VAULT_DIR/}"
        echo "📋 $relative_path"
    done

    echo ""
    echo "Run: $0 validate to check YAML frontmatter"
}

find_orphans() {
    echo "=== Potential Orphan Notes (no incoming links) ==="
    echo ""

    # Find all .md files
    all_files=$(find "$VAULT_DIR" -name "*.md" -type f)

    for file in $all_files; do
        filename=$(basename "$file" .md)
        relative_path="${file#$VAULT_DIR/}"

        # Check if this filename is linked anywhere
        if ! grep -r "\\[\\[$filename\\]\\]" "$VAULT_DIR" --exclude-dir=".git" --exclude-dir=".obsidian" > /dev/null 2>&1 | grep -v "^$file"; then
            if [ ! "$filename" = "CLAUDE" ] && [ ! "$filename" = "README" ]; then
                echo "👻 $relative_path"
            fi
        fi
    done
}

find_broken() {
    echo "=== Broken Wiki-Links ==="
    echo ""

    # Extract all wiki-links from notes
    find "$VAULT_DIR" -name "*.md" -exec grep -oh "\\[\\[.*\\]\\]" {} \; | \
        grep -o "\\[\\[[^\\]]*\\]\\]" | \
        sort -u | while read link; do
            # Extract filename part
            filename=$(echo "$link" | sed 's/\\[\\[\\(.*\\).*/\\1/')

            # Check if file exists
            if ! find "$VAULT_DIR" -name "$filename.md" | grep -q .; then
                # Find which notes link to this
                find "$VAULT_DIR" -name "*.md" -exec grep -l "$link" {} \; | while read source_file; do
                    relative_path="${source_file#$VAULT_DIR/}"
                    echo "❌ $link in: $relative_path"
                done
            fi
        done
}

validate_vault() {
    echo "=== Vault Validation ==="
    echo ""

    errors=0
    warnings=0

    # Check for .md files without YAML description
    echo "Checking YAML frontmatter..."
    find "$VAULT_DIR" -name "*.md" ! -path "*/.git/*" ! -path "*/.obsidian/*" | while read file; do
        if ! grep -q "^description:" "$file"; then
            relative_path="${file#$VAULT_DIR/}"
            echo "⚠️  Missing description: $relative_path"
            ((warnings++))
        fi
    done

    # Check for claim-based titles (not just topics)
    echo ""
    echo "Checking note titles..."
    find "$VAULT_DIR" -name "*.md" ! -path "*/.git/*" ! -path "*/.obsidian/*" ! -path "*/00_inbox/*" ! -path "*/05_archive/*" | while read file; do
        filename=$(basename "$file" .md)
        relative_path="${file#$VAULT_DIR/}"

        # Check for topic-based titles (ending in common topic words)
        if echo "$filename" | grep -qiE "^(notes|thoughts|ideas|research|study|reading|draft|temp|test)$"; then
            echo "⚠️  Topic-based title: $relative_path"
            echo "   → Consider renaming to a claim"
            ((warnings++))
        fi
    done

    echo ""
    echo "=== Validation Complete ==="
    echo "Errors: $errors"
    echo "Warnings: $warnings"
}

spatial_edit() {
    # Delegate to spatial-edit.sh
    "$VAULT_DIR/06_system/spatial-edit.sh" "$@"
}

# Main
case "$1" in
    tree)
        show_tree
        ;;
    find)
        find_notes "$2"
        ;;
    outline)
        show_outline "$2"
        ;;
    process)
        list_process
        ;;
    orphans)
        find_orphans
        ;;
    broken)
        find_broken
        ;;
    validate)
        validate_vault
        ;;
    edit)
        shift
        spatial_edit "$@"
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        echo "Unknown command: $1"
        echo ""
        show_help
        exit 1
        ;;
esac
