---
description: "FBA Sourcing App - Implementation Plan"
tags: ['research']
raw_file: "fuzzy-twirling-boole.md"
created: 2026-05-17
---

# FBA Sourcing App - Implementation Plan

## Overview

A native macOS + iPhone application for retail arbitrage opportunity detection. The app validates Amazon listings, scrapes source prices, calculates profitability, and tracks purchases through sale.

---

## Architecture

```
┌─────────────────────────────────────────────────────────────────┐
│                        iCloud (CloudKit)                         │
│                    Syncs data between devices                    │
└─────────────────────────────────────────────────────────────────┘
                              ▲
                              │
        ┌─────────────────────┴─────────────────────┐
        │                                           │
        ▼                                           ▼
┌───────────────────┐                     ┌───────────────────┐
│   macOS App       │                     │   iPhone App      │
│   (SwiftUI)       │                     │   (SwiftUI)       │
│                   │                     │                   │
│ • Full features   │                     │ • Read-only       │
│ • Import CSV      │                     │ • View winners    │
│ • Trigger scans   │                     │ • Notifications   │
│ • Purchase entry  │                     │ • Quick stats     │
│ • Receipt photos  │                     │                   │
└────────┬──────────┘                     └───────────────────┘
         │
         │ HTTP (localhost:3847)
         ▼
┌───────────────────┐
│  Node.js Service  │
│  (Scraping Engine)│
│                   │
│ • Playwright      │
│ • Site adapters   │
│ • Price extraction│
│ • Keepa API       │
└───────────────────┘
```

---

## Tech Stack

| Component | Technology |
|-----------|------------|
| Mac/iPhone UI | SwiftUI |
| Database | Core Data + CloudKit |
| Scraping | Node.js + Playwright |
| API Client | Keepa API (cached locally) |
| Notifications | UserNotifications framework |
| Receipt Storage | Local files + iCloud Drive |

---

## Data Model

### Product
| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| asin | String | Amazon identifier |
| productName | String | Product title |
| amazonUrl | String | Computed from ASIN |
| sourceUrl | String | Retailer URL |
| costPrice | Decimal | Source price |
| salePrice | Decimal | Amazon price |
| fbaFee | Decimal | FBA fulfillment fee |
| referralFee | Decimal | Amazon referral fee |
| shippingCost | Decimal | Cost to ship to Amazon |
| profit | Decimal | Calculated |
| profitMargin | Decimal | Calculated |
| roi | Decimal | Calculated |
| estimatedSales | Int | Monthly sales estimate |
| salesRank | Int | BSR |
| status | Enum | active, recheckLater, dead |
| lastChecked | Date | Last validation date |
| recheckDate | Date | When to recheck (if applicable) |
| importDate | Date | Original CSV import date |
| createdAt | Date | Record creation |
| updatedAt | Date | Last modification |

### Purchase
| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| productId | UUID | FK to Product |
| quantity | Int | Units purchased |
| actualCostPerUnit | Decimal | What you paid |
| totalCost | Decimal | Calculated |
| purchaseDate | Date | When purchased |
| receiptImagePath | String | Path to receipt photo |
| notes | String | Optional notes |

### Sale
| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| purchaseId | UUID | FK to Purchase |
| quantity | Int | Units sold |
| actualSalePrice | Decimal | What it sold for |
| amazonFees | Decimal | Actual fees charged |
| actualProfit | Decimal | Real profit |
| saleDate | Date | When sold |

### ScrapeLog
| Field | Type | Description |
|-------|------|-------------|
| id | UUID | Primary key |
| productId | UUID | FK to Product |
| source | String | "amazon" or source domain |
| success | Bool | Did scrape succeed |
| priceFound | Decimal? | Price if found |
| errorMessage | String? | Error if failed |
| timestamp | Date | When attempted |

---

## Phase 1 Features (MVP)

### 1.1 CSV Import
- Parse current CSV format
- Create Product records
- Standardize Amazon URLs from ASIN
- Handle duplicates (update existing by ASIN)

### 1.2 Product Validation
- Check Amazon listing exists (via scrape)
- Check source URL loads
- Extract current prices from both
- Flag failures for manual review

### 1.3 Profit Calculation
- FBA fee estimation (use Keepa or hardcoded category rates)
- Referral fee (15% default, category-specific)
- Shipping to Amazon ($0.50/unit)
- Calculate: profit, margin, ROI

### 1.4 Business Logic Filters
```
Winners criteria:
- profit_margin >= 10%
- estimated_sales >= 300
- sales_rank <= 150,000
- roi >= 20%
- status = active
- source_in_stock = true
```

### 1.5 Dashboard Tabs
- **Winners** - Products meeting all criteria
- **Recheck Later** - Negative/low profit, check in 2 weeks
- **All Products** - Full list with filters

### 1.6 Product Detail View
- Amazon link (clickable)
- Source link (clickable)
- Cost breakdown (fees, shipping, profit)
- Price history chart (local data only)
- "Mark as Purchased" button

### 1.7 Purchase Tracking
- Enter quantity + actual price paid
- Attach receipt photo
- Calculate expected profit based on actuals

### 1.8 Sale Entry (Manual)
- Enter quantity sold + actual sale price
- Record actual Amazon fees
- Calculate real profit vs expected

### 1.9 Scraping Engine (Node.js)
Site-specific adapters for:
- Walmart
- Kohls
- Target
- CVS
- Nike.com
- Lululemon
- Generic fallback (attempt price extraction)

Failure handling:
- Retry with 30-60s delay
- Rotate user agents
- Flag for manual review after 3 failures

### 1.10 Notifications
- macOS: When scan completes, new winners found
- iPhone: Push notification for new winners

### 1.11 Reports (In-App)
- Total profit (expected vs actual)
- Win rate (products profitable vs not)
- Top performers
- Money invested vs returned

---

## Phase 2 Features (Future)

- Amazon SP-API integration (auto-pull sales data)
- Keepa historical price charts
- Scheduled daily scans
- Export to CSV/PDF
- Multiple buy lists with tags
- Proxy rotation for scraping
- CAPTCHA solving integration

---

## Project Structure

```
FBASourcing/
├── FBASourcingApp/              # Shared SwiftUI code
│   ├── App/
│   │   ├── FBASourcingApp.swift
│   │   └── AppDelegate.swift
│   ├── Models/
│   │   ├── Product.swift
│   │   ├── Purchase.swift
│   │   ├── Sale.swift
│   │   └── ScrapeLog.swift
│   ├── Views/
│   │   ├── Dashboard/
│   │   │   ├── DashboardView.swift
│   │   │   ├── WinnersTab.swift
│   │   │   ├── RecheckTab.swift
│   │   │   └── AllProductsTab.swift
│   │   ├── ProductDetail/
│   │   │   ├── ProductDetailView.swift
│   │   │   ├── CostBreakdownView.swift
│   │   │   └── PriceHistoryChart.swift
│   │   ├── Purchase/
│   │   │   ├── PurchaseEntryView.swift
│   │   │   └── ReceiptCaptureView.swift
│   │   ├── Sales/
│   │   │   └── SaleEntryView.swift
│   │   ├── Reports/
│   │   │   ├── ReportsView.swift
│   │   │   └── ProfitSummaryView.swift
│   │   └── Settings/
│   │       └── SettingsView.swift
│   ├── Services/
│   │   ├── CSVImporter.swift
│   │   ├── ScrapingClient.swift      # Talks to Node service
│   │   ├── ProfitCalculator.swift
│   │   ├── NotificationManager.swift
│   │   └── CloudKitSync.swift
│   ├── CoreData/
│   │   ├── FBASourcing.xcdatamodeld
│   │   └── PersistenceController.swift
│   └── Resources/
│       └── Assets.xcassets
│
├── FBASourcingMac/              # macOS-specific
│   ├── MacApp.swift
│   └── MenuBarExtra.swift       # Optional menu bar icon
│
├── FBASourcingIPhone/           # iPhone-specific
│   └── iPhoneApp.swift
│
└── scraping-service/            # Node.js service
    ├── package.json
    ├── src/
    │   ├── index.ts             # Express server
    │   ├── scraper.ts           # Playwright orchestration
    │   ├── adapters/
    │   │   ├── amazon.ts
    │   │   ├── walmart.ts
    │   │   ├── kohls.ts
    │   │   ├── target.ts
    │   │   ├── cvs.ts
    │   │   ├── nike.ts
    │   │   ├── lululemon.ts
    │   │   └── generic.ts
    │   ├── keepa/
    │   │   └── client.ts
    │   └── utils/
    │       ├── userAgents.ts
    │       └── retry.ts
    └── tsconfig.json
```

---

## Implementation Order

### Week 1: Foundation
1. Create Xcode project (multiplatform SwiftUI)
2. Set up Core Data model
3. Implement CSV importer
4. Basic dashboard UI with tabs

### Week 2: Scraping Service
5. Set up Node.js project with Playwright
6. Build Amazon adapter (price, availability)
7. Build Walmart adapter
8. Build Kohls adapter
9. Express API endpoints

### Week 3: Integration
10. ScrapingClient in Swift (calls Node service)
11. Profit calculator with fee estimation
12. Product detail view with cost breakdown
13. Manual scan trigger

### Week 4: Purchase Tracking
14. Purchase entry form
15. Receipt photo capture
16. Sale entry form
17. Profit tracking (expected vs actual)

### Week 5: Polish
18. CloudKit sync setup
19. Notifications (Mac + iPhone push)
20. Reports view with charts
21. Recheck scheduler (2-week cycle)

### Week 6: Testing & Refinement
22. Build remaining site adapters (Target, CVS, Nike, Lululemon)
23. Test with real CSV data
24. Handle edge cases
25. App signing for direct distribution

---

## Verification Plan

### Manual Testing
1. Import sample CSV → Products appear in All tab
2. Trigger scan → Prices update, scrape logs recorded
3. Check Winners tab → Only qualifying products shown
4. Click Amazon link → Opens in browser
5. Mark product as purchased → Purchase record created
6. Enter sale → Profit calculated correctly
7. Check Reports → Totals accurate
8. Open iPhone app → Same data visible
9. Add product on Mac → Appears on iPhone (iCloud sync)

### Automated Tests
- Unit tests for ProfitCalculator
- Unit tests for CSVImporter parsing
- Integration tests for scraping adapters (mock responses)

---

## Open Questions Resolved

| Question | Decision |
|----------|----------|
| Desktop tech | SwiftUI (native) |
| Scraping tech | Node.js + Playwright |
| Database | Core Data + CloudKit |
| Fee calculation | Keepa API (cached) + fallback rates |
| Profit margin threshold | 10% |
| Min monthly sales | 300 |
| Max sales rank | 150,000 |
| Min ROI | 20% |
| Recheck period | 2 weeks |
| Shipping cost | $0.50/unit |
| iPhone features | Read-only |
| Distribution | Direct (Developer ID signed) |

---

## Dependencies

### macOS/iOS
- Xcode 15+
- Swift 5.9+
- Apple Developer account (for signing + CloudKit)

### Node.js Service
- Node.js 20+
- Playwright
- Express
- TypeScript
- Keepa API key (~$20/month, used sparingly)

---

## Risks & Mitigations

| Risk | Mitigation |
|------|------------|
| Sites block scraping | User agent rotation, retry logic, manual fallback |
| Keepa costs | Cache data aggressively, use sparingly |
| CloudKit complexity | Start with local-only, add sync after MVP works |
| App Store rejection | Direct distribution only, no App Store |
| Price selectors change | Site-specific adapters, easy to update |

