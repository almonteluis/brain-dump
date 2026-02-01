#!/bin/bash

# Vault Tree Generator
# Generates file tree structure for agent orientation at session start
# This gives agents a map before they start exploring the vault

VAULT_DIR="$(dirname "$0")/.."

# Simple readable format for agent consumption
echo "=== VAULT STRUCTURE ==="
echo ""

# Show numbered folders first (PARA system)
cd "$VAULT_DIR"
find . -maxdepth 1 -type d -name '[0-9]*' -o -name 'attachments' | sort | while read dir; do
    echo "   $dir"
    find "$dir" -maxdepth 1 -type d | tail -n +2 | while read subdir; do
        echo "      $subdir"
    done
done

echo ""
echo "=== ROOT FILES ==="
find . -maxdepth 1 -type f -name "*.md" | xargs -n 1 basename 2>/dev/null | sort | while read file; do
    echo "   $file"
done
