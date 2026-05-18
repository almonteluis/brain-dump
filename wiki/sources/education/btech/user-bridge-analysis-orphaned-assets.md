---
description: Graph-based cross-community coupling analysis of the User entity plus orphaned asset detection in the NC codebase
tags: ["new-classrooms", "architecture", "god-object", "dead-code", "knowledge-graph"]
sources: ["User Bridge Analysis and Orphaned Assets.md"]
created: 2026-04-28
updated: 2026-04-28
---

# User Bridge Analysis and Orphaned Assets

**Source:** `User Bridge Analysis and Orphaned Assets.md`
**Date ingested:** 2026-04-28
**Type:** Architecture analysis / dead code detection
**Branch:** feature/TEAME-218-LTS-Brain-Break

## Summary

Two separate findings from a graph analysis of the NC codebase:

1. **User Cross-Community Bridge:** The `User` entity in `Nc.Shared` acts as a structural bridge connecting three distinct communities. This creates tight cross-domain coupling that is a design concern.
2. **Orphaned Assets:** Four PNG image files in `frontend/src/assets/mapInformation/` are confirmed orphaned and safe to delete.

## Part 1 — User Cross-Community Bridge

### User Entity Structure

The `User` entity lives at `shared/Nc.Shared/Entities/User.cs`:

```csharp
public class User : BaseEntity, IActivatable, IOwned, IObfuscatable
```

**Core fields:** `Id`, `PublicUserId`, `FirstName`, `LastName`, `Email`, `IsActive`, `IsObfuscated`

**Relationship collections (the bridge mechanism):**

```csharp
public virtual ICollection<Role> Roles { get; set; }
public virtual ICollection<UserRole> UserRoles { get; set; }
public virtual ICollection<Site> Sites { get; set; }
public virtual ICollection<UserSite> UserSites { get; set; }
public virtual ICollection<Class> Classes { get; set; }
public virtual ICollection<UserClass> UserClasses { get; set; }
public virtual ICollection<GradeLevel> GradeLevels { get; set; }
public virtual IEnumerable<StudentSkillDiagnostic> Diagnostics { get; set; }
public virtual IEnumerable<StudentSkillAssessment> Assessments { get; set; }
public virtual IEnumerable<LearnosityExitSlipSession> LearnosityExitSlipSessions { get; set; }
public virtual IEnumerable<StudentTargetGroup> StudentTargetGroups { get; set; }
public virtual IEnumerable<ExperimentsFlagHistory> ExperimentsFlagHistories { get; set; }
public virtual IEnumerable<ExperimentsObservation> ExperimentsObservations { get; set; }
```

### Three Communities Connected Through User

```
┌─────────────────────────────┐
│  Shared Domain Entities     │  ← User.cs, BaseEntity.cs, Role.cs, Site.cs
│  (core domain model)        │
└─────────────┬───────────────┘
              │ User is inherited by BaseEntity (CreatedBy, ModifiedBy)
              │ User is referenced by Role, Site, Class, StudentSkill, etc.
┌─────────────▼───────────────┐
│  Clever API & External Sync │  ← UserImporter.cs, Repository.cs
│  (integration boundary)     │
└─────────────┬───────────────┘
              │ LookupUserByCleverId resolves ExternalSync → User
┌─────────────▼───────────────┐
│  Django CMS Migrations      │  ← users/models.py, roadmaps/models.py
│  (content management)       │
└─────────────────────────────┘
              │ UserProfile.roadmaps_user FK → roadmaps.User
```

### Design Concern Assessment

| Concern | Severity | Evidence |
|---------|----------|----------|
| Too many responsibilities | Moderate-High | 15+ collection properties spanning auth, org structure, learning data, experiments, external sync |
| God entity anti-pattern | Moderate | Referenced by 25+ other entity files in `Nc.Shared/Entities/` alone |
| Cross-stack coupling | High | Same `users` PostgreSQL table accessed by C# EF Core, Django ORM, and Clever sync jobs |
| Audit trail pollution | Low-Moderate | `BaseEntity` forces `CreatedBy`/`ModifiedBy` on every entity |

**Recommendation:** Decompose `User` into bounded-context-specific identities:
- `Identity` aggregate for auth (Auth0 ID, email, roles)
- `Person` aggregate for profile data (name, grade level)
- `Membership` aggregate for org links (sites, classes)
- Keep `ExternalSync` as separate aggregate referenced by ID

## Part 2 — Orphaned Assets

### Asset Inventory

| File | Size | Added In | Last Referenced By |
|------|------|----------|-------------------|
| `map-circle.png` | 4,440 bytes | `63aede530` (TEAMB-929) | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-neighborhood.png` | 3,823 bytes | `63aede530` | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-street.png` | 7,760 bytes | `63aede530` | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-tree.png` | 8,394 bytes | `63aede530` | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |

**Total orphaned payload:** ~24 KB

### Deletion Safety Assessment

| Criterion | Status |
|-----------|--------|
| Referenced by any source file? | **No** |
| Referenced by any test file? | **No** |
| Referenced by any config? | **No** |
| Used in dynamic `require()`/`import()`? | **No** |
| Part of PWA manifest or service worker? | **No** |

**Verdict:** All four PNG files are **safe to delete**.

### Cleanup Command

```bash
rm frontend/src/assets/mapInformation/map-circle.png
rm frontend/src/assets/mapInformation/map-neighborhood.png
rm frontend/src/assets/mapInformation/map-street.png
rm frontend/src/assets/mapInformation/map-tree.png
rmdir frontend/src/assets/mapInformation/
```

## Concepts Covered

- [[god-entity]] — `User` as cross-community bridge with 15+ responsibilities
- [[bounded-contexts]] — Decomposing monolithic entity into focused aggregates
- [[orphaned-assets]] — Detecting and removing unused static files
- [[knowledge-graph-analysis]] — Using graphify for cross-community coupling detection

## Related

- [[jumpcloud-django-user-sync-pipeline]] — How `User` is used in the sync pipeline
- [[brainbreak-knowledge-graph-analysis]] — Another graph analysis from same codebase
- [[nc-frontend-architecture]] — NC frontend architecture
