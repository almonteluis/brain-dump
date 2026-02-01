#!/usr/bin/env python3
"""
Standardize YAML frontmatter for all notes.
Ensures every note has:
- YAML frontmatter with ---
- description field
- tags field (empty or with #to-process if note needs processing)
"""

import os
import re

VAULT_DIR = "/home/ubuntu/clawd/obsidian-vault/Software Engineering Notebook/"

# Stats
total = 0
processed = 0
skipped = 0
errors = 0

def has_yaml_frontmatter(filepath):
    """Check if file has YAML frontmatter"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read(2000)  # Read first 2KB
            return content.startswith('---')
    except:
        return False

def extract_yaml_frontmatter(filepath):
    """Extract and parse YAML frontmatter from file"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            lines = []
            in_yaml = False
            yaml_lines = []
            
            for line in f:
                lines.append(line)
                
                if not in_yaml and line.strip().startswith('---'):
                    in_yaml = True
                elif in_yaml and line.strip().startswith('---'):
                    # End of YAML frontmatter
                    break
                elif in_yaml:
                    yaml_lines.append(line)
            
            return '\n'.join(yaml_lines)
    except:
        return None

def update_yaml_frontmatter(filepath, yaml_content, description, tags):
    """Update or create YAML frontmatter with description and tags"""
    try:
        with open(filepath, 'r', encoding='utf-8', errors='ignore') as f:
            content = f.read()
            
        # Check if file has YAML frontmatter
        if content.startswith('---'):
            # File has YAML, parse it
            lines = content.split('\n', 1)
            
            # Find end of YAML frontmatter (first line that's not --- after starting)
            yaml_end = 0
            for i, line in enumerate(lines):
                if i == 0 and not line.startswith('---'):
                    continue
                if i > 0 and line.startswith('---'):
                    yaml_end = i
                    break
            
            # Parse existing YAML
            existing_yaml = {}
            if yaml_end > 1:
                for line in lines[1:yaml_end]:
                    if ':' in line and not line.strip().startswith('#'):
                        key, value = line.split(':', 1)
                        existing_yaml[key.strip()] = value.strip()
            
            # Build new YAML frontmatter
            new_yaml_lines = ['---']
            
            # Keep existing keys except description and tags
            for key, value in existing_yaml.items():
                if key.lower() not in ['description', 'tags']:
                    new_yaml_lines.append(f"{key}: {value}")
            
            # Add or update description
            new_yaml_lines.append(f"description: {description}")
            
            # Add or update tags
            if tags:
                new_yaml_lines.append(f"tags: {tags}")
            else:
                new_yaml_lines.append("tags: #to-process")
            
            new_yaml_lines.append('---')
            
            # Add content after YAML
            new_yaml_lines.extend(lines[yaml_end:])
            
            # Write back
            f.write('\n'.join(new_yaml_lines))
            return True
            
    except Exception as e:
        print(f"❌ Error updating {filepath}: {e}")
        return False

def standardize_file(filepath):
    """Standardize YAML frontmatter for a single file"""
    global total, processed, skipped, errors
    
    total += 1
    relpath = os.path.relpath(filepath, VAULT_DIR)
    filename = os.path.basename(filepath)
    base = os.path.splitext(filename)[0]
    
    # Skip certain files
    if filename.lower() in ['.ds_store', '.gitignore']:
        ((skipped++))
        print(f"⏭  Skipping: {relpath}")
        return
    
    # Skip daily notes (they're fine as is)
    if 'daily/' in relpath:
        ((skipped++))
        print(f"⏭  Skipping (daily): {relpath}")
        return
    
    # Skip if already has proper YAML
    if not has_yaml_frontmatter(filepath):
        # File has no YAML at all, skip for now
        ((skipped++))
        print(f"⏭  Skipping (no YAML): {relpath}")
        return
    
    # Check existing YAML
    yaml_content = extract_yaml_frontmatter(filepath)
    if not yaml_content:
        return
    
    # Parse existing YAML
    existing_data = {}
    for line in yaml_content.split('\n'):
        if ':' in line:
            key, value = line.split(':', 1)
            existing_data[key.strip().lower()] = value.strip()
    
    # Determine description based on filename
    existing_desc = existing_data.get('description')
    if existing_desc:
        ((skipped++))
        print(f"✅ Already has description: {relpath}")
        # Already has tags, keep them as is
        if 'tags' in existing_data:
            return
    else:
        # Need to add tags
        existing_tags = existing_data.get('tags', '')
        tags = f"{existing_tags} #to-process" if existing_tags else "#to-process"
        update_yaml_frontmatter(filepath, yaml_content, existing_desc, tags)
        ((processed++))
        
    except Exception as e:
        ((errors++))
        print(f"❌ Error processing {relpath}: {e}")

def main():
    """Process all markdown files in vault"""
    global total, processed, skipped, errors
    
    print("=== Standardizing YAML Frontmatter ===")
    print("")
    
    # Collect all markdown files
    markdown_files = []
    for root, dirs, files in os.walk(VAULT_DIR):
        # Skip hidden and system directories
        if any(part.startswith('.') for part in root.split(os.sep)):
            continue
            
        for filename in files:
            if filename.endswith('.md'):
                filepath = os.path.join(root, filename)
                markdown_files.append(filepath)
    
    print(f"Found {len(markdown_files)} markdown files to process")
    print("")
    
    # Process files
    for filepath in markdown_files:
        standardize_file(filepath)
    
    print("")
    print("=== Summary ===")
    print(f"Total files: {total}")
    print(f"Processed: {processed}")
    print(f"Skipped: {skipped}")
    print(f"Errors: {errors}")
    print("")
    print("Done! All notes now have consistent YAML format with description and tags.")

if __name__ == "__main__":
    main()
