---
description: Step-by-step methods to measure and document current build output sizes — essential baseline before tree-shaking optimization work.
tags: ["build", "bundle-size", "metrics", "vite", "rollup", "performance"]
created: 2026-01-31
---

# Document Current Build Output Sizes

> Use multiple methods below to get an average baseline. Document results before making tree-shaking changes.

---

## Method 1: rollup-plugin-visualizer (Recommended)

### Setup

```bash
npm install -D rollup-plugin-visualizer
```

**vite.config.ts:**
```typescript
import { visualizer } from 'rollup-plugin-visualizer';

export default defineConfig({
  plugins: [
    visualizer({
      open: true,
      gzipSize: true,
      brotliSize: true,
      filename: 'stats.html'
    })
  ]
});
```

### Generate Report

```bash
npm run build
```

### Read Results

After build completes, `stats.html` opens automatically showing:
- **Treemap view** — rectangles sized by module size
- **Sunburst view** — circular breakdown
- **Network view** — dependency graph (green = dependencies, blue = your code)

**Key metrics to capture:**
- Total bundle size (gzipped)
- Largest modules (identify top 5)
- Chunk count
- Vendor vs app ratio

---

## Method 2: CLI Size Analysis

### Get File Sizes

```bash
# Navigate to build output
cd dist/assets

# List all JS files with sizes (human-readable)
ls -lh *.js

# List all JS files with sizes (bytes, sortable)
ls -l *.js | awk '{print $5, $9}' | sort -n

# Get total bundle size
du -sh . | sort -h

# Get gzipped size of each file
for file in *.js; do
  echo "$file: $(gzip -c "$file" | wc -c) bytes gzipped"
done

# Get brotli size (if you have brotli)
for file in *.js; do
  echo "$file: $(brotli "$file" | wc -c) bytes brotli"
done
```

### Summary Script

```bash
#!/bin/bash
# build-size-summary.sh

echo "=== Bundle Size Summary ==="
echo ""
echo "Raw sizes:"
ls -lh dist/assets/*.js 2>/dev/null | awk '{print $9, $5}'
echo ""
echo "Gzipped sizes:"
for f in dist/assets/*.js; do
  if [ -f "$f" ]; then
    size=$(gzip -c "$f" | wc -c | tr -d ' ')
    kb=$(echo "scale=2; $size / 1024" | bc)
    echo "$f: ${kb} KB gzipped"
  fi
done
echo ""
echo "Total bundle size:"
du -sh dist/
```

---

## Method 3: Vite Built-in Stats

### Enable Stats Mode

**vite.config.ts:**
```typescript
export default defineConfig({
  build: {
    rollupOptions: {
      output: {
        // Stats output for analysis
        globals: true
      }
    }
  }
});
```

### Build with Stats

```bash
npm run build -- --mode production
```

### Parse Output

Vite outputs build info to console. Capture it:
```bash
npm run build 2>&1 | tee build-log.txt
```

Look for lines showing:
```
✓ built in 2.34s
file index-abc123.js 87.32 KiB / gzip: 28.45 KiB / brotli: 25.12 KiB
```

---

## Method 4: Bundle Size CLI Tool

```bash
# Install bundle-size analyzer
npm install -D bundlesize

# Add to package.json scripts
"scripts": {
  "analyze": "bundlesize"
}

# Configure your bundles
# package.json
{
  "bundlesize": {
    "files": [
      {
        "path": "./dist/assets/*.js",
        "maxSize": "200 kB"
      }
    ]
  }
}

# Run analysis
npm run analyze
```

---

## Method 5: packagesize

```bash
npm install -g packagesize

# Analyze build output
packagesize ./dist --json > size-report.json

# Readable output
packagesize ./dist
```

---

## Method 6: Webpack/Vite Stats JSON

### Generate Stats File

**vite.config.ts:**
```typescript
export default defineConfig({
  build: {
    rollupOptions: {
      output: {
        // Generate stats.json for analysis
        amd: {
          id: 'vite'
        }
      }
    }
  }
});
```

### Build and Parse

```bash
npm run build

# The build will output stats
# Use webpack-bundle-analyzer-compatible tools
npx rollup-plugin-visualizer --template raw-data stats.html
```

---

## Method 7: Lighthouse CI

```bash
npm install -g lighthouse

# Build your app
npm run build

# Serve locally (or use preview server)
npm run preview

# In another terminal:
lighthouse http://localhost:4173 --view --output=lighthouse-report.html
```

**Key metrics from Lighthouse:**
- Performance score
- Total blocking time
- Largest Contentful Paint (LCP)
- Cumulative Layout Shift (CLS)
- Time to Interactive (TTI)
- JavaScript bottlenecks

---

## Method 8: Compare Builds Script

```bash
#!/bin/bash
# compare-builds.sh

echo "=== Before and After Build Comparison ==="
echo ""
echo "Current build info:"
npm run build 2>&1 | tee build-current.txt

echo ""
echo "=== File Sizes ==="
ls -lh dist/assets/*.js | awk '{printf "%-50s %10s\n", $9, $5}'

echo ""
echo "=== Total Bundle Size ==="
du -sh dist/

echo ""
echo "=== Gzipped Sizes ==="
for f in dist/assets/*.js; do
  if [ -f "$f" ]; then
    size=$(gzip -c "$f" | wc -c | tr -d ' ')
    printf "%-50s %10d bytes\n" "$f" "$size"
  fi
done
```

---

## Documentation Template

### Baseline Recording

Create `docs/baseline-bundle-size-YYYY-MM-DD.md`:

```markdown
# Build Baseline: YYYY-MM-DD

## Environment
- Vite version: `npm list vite`
- Node version: `node --version`
- Branch: `git branch`
- Commit: `git rev-parse --short HEAD`

## Bundle Sizes

| File | Raw | Gzip | Brotli |
|------|-----|-------|--------|
| main-[hash].js | _ kb | _ kb | _ kb |
| vendor-[hash].js | _ kb | _ kb | _ kb |
| index.html | _ kb | _ kb | _ kb |

## Total Metrics
| Metric | Value |
|--------|-------|
| Total JS (gzipped) | _ kb |
| Initial Load | _ kb |
| Chunk count | _ |
| Largest module | _ kb |

## Lighthouse Scores
| Metric | Score |
|--------|-------|
| Performance | _/100 |
| First Contentful Paint | _ ms |
| Time to Interactive | _ ms |
| Total Blocking Time | _ ms |

## Visualizer
- stats.html attached
- Top 5 largest modules:
  1.
  2.
  3.
  4.
 5.
```

---

## Quick One-Liner Commands

```bash
# All JS files sorted by size (human-readable)
ls -lh dist/assets/*.js | awk '{print $5, $9}' | sort -rh

# Total bundle size
du -sh dist/

# Sum of all gzipped JS
find dist/assets -name "*.js" -exec gzip -c {} \; | wc -c

# Count total number of chunks
ls dist/assets/*.js | wc -l

# Find largest file
ls -lS dist/assets/*.js | head -1
```

---

## Related

[[vite-rollup-tree-shaking-guide]]
[[Vite 4.4.1 to 7.x Upgrade Gameplan]]
[[Performance Optimization]]
