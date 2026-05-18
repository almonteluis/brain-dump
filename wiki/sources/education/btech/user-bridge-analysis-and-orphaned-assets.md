---
description: "User Bridge Analysis and Orphaned Assets"
tags: ['research']
raw_file: "User Bridge Analysis and Orphaned Assets.md"
created: 2026-05-17
---

# User Bridge Analysis and Orphaned Assets

> **Date:** 2026-04-28
> **Branch:** feature/TEAME-218-LTS-Brain-Break
> **Analysis type:** Graph-based cross-community coupling + dead code/asset detection

---

## Summary

This document traces two separate findings from a graph analysis of the codebase:

1. **User Cross-Community Bridge:** The `User` entity in `Nc.Shared` acts as a structural bridge connecting three distinct communities: Shared Domain Entities, Clever API & External Integrations, and Django CMS Migrations. This creates tight cross-domain coupling that may be a design concern.

2. **Orphaned Assets:** Four PNG image files in `frontend/src/assets/mapInformation/` are confirmed orphaned. They were added for a map info dialog feature (TEAMB-929) and became unused when `DashboardMap.tsx` and all map-related components were deleted in commit `2b0cc8d0a` ("FE Remove Maps from Student Dashboard", 2025-07-01). All four files are safe to delete.

---

## Part 1 — User Cross-Community Bridge

### 1.1 What Fields/Properties Make User a Shared Entity

The `User` entity lives at `shared/Nc.Shared/Entities/User.cs` and implements multiple cross-cutting interfaces:

```csharp
public class User : BaseEntity, IActivatable, IOwned, IObfuscatable
```

**Core identity fields:**

| Property | Type | Purpose |
|----------|------|---------|
| `Id` | `int` | Primary key (inherited from `BaseEntityParent`) |
| `PublicUserId` | `string` | Auth0-facing public identifier |
| `FirstName` | `string` | Display name |
| `LastName` | `string` | Display name |
| `Email` | `string` | Unique login credential |
| `IsActive` | `bool` | Soft-delete / activation flag (`IActivatable`) |
| `IsObfuscated` | `bool` | GDPR/privacy flag (`IObfuscatable`) |

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

**Audit trail (inherited from `BaseEntity` / `BaseEntityParent`):**

```csharp
// BaseEntityParent.cs
public virtual int Id { get; set; }
public int CreatedById { get; set; }
public virtual User CreatedBy { get; set; }     // Self-referential!
public virtual DateTime CreatedOn { get; set; }

// BaseEntity.cs
public int? ModifiedById { get; set; }
public virtual User? ModifiedBy { get; set; }   // Self-referential!
public virtual DateTime? ModifiedOn { get; set; }
```

The `IOwned` interface is particularly notable:

```csharp
public interface IOwned
{
    User Owner { get; }
}
```

And `User` implements it as:

```csharp
[NotMapped]
public User Owner { get => this; }
```

This means every entity that implements `IOwned` (or uses `BaseEntity` with its audit fields) has a direct navigation property back to `User`.

### 1.2 How User Is Referenced in Clever External Sync

The Clever integration lives in `external-sync/` and has two distinct `User` types:

**A. Clever API Model** (`external-sync/Nc.Clever/Models/User.cs`)

This is an auto-generated Kiota client model for the Clever REST API. It is a *separate* `NewClassrooms.Clever.Models.User` class with its own properties (`Id`, `Email`, `Name`, `Roles`, `District`, etc.).

**B. Shared Entity User** (`shared/Nc.Shared/Entities/User.cs`)

The importer (`external-sync/Nc.ExternalSync/Importers/Clever/UserImporter.cs`) maps Clever API users to the shared `User` entity:

```csharp
// UserImporter.cs — creating a new shared User from Clever data
user = new Shared.Entities.User
{
    PublicUserId = response.UserId,
    FirstName = cleverUser.Name?.First,
    LastName = cleverUser.Name?.Last,
    Email = cleverUser.Email,
    IsActive = true,
    CreatedBy = actingUser,
    CreatedOn = syncTime,
    ExternalSync = new Shared.Entities.ExternalSync
    {
        ExternalId = cleverUser.Id,
        Source = CleverSource.SOURCE_NAME,
        ...
    }
};
```

The `Repository` class (`external-sync/Nc.ExternalSync/Repository.cs`) links Clever users to the shared domain via `ExternalSync`:

```csharp
public async Task<Shared.Entities.User?> LookupUserByCleverId(Context dbContext, string cleverUserId)
{
    var externalSyncRecord = await dbContext.ExternalSync
        .SingleOrDefaultAsync(x => x.ExternalId == cleverUserId);
    // ...
    user = await dbContext.Users
        .SingleOrDefaultAsync(x => x.ExternalSync.Id == externalSyncRecord.Id);
}
```

The `User` entity is the *pivot point* where external Clever IDs are resolved to internal domain identities. Without `User`, the external sync has no anchor in the domain model.

### 1.3 How User Is Referenced in Django CMS

The Django CMS (`cms-django/`) has a dual-user architecture:

**A. Django-native user** (`cms-django/users/models.py`)

```python
class CustomUser(AbstractUser):
    email = models.EmailField(unique=True)
    first_name = models.CharField(max_length=150)
    last_name = models.CharField(max_length=150)
    created_by = models.ForeignKey("CustomUser", models.DO_NOTHING, related_name="+")
    modified_by = models.ForeignKey("CustomUser", models.DO_NOTHING, related_name="+", blank=True, null=True)
    username = None
    date_joined = None
    USERNAME_FIELD = "email"
```

**B. Roadmaps User** (`cms-django/roadmaps/models.py`)

This is an *unmanaged* Django model that mirrors the shared C# `User` entity (same PostgreSQL table):

```python
class User(ActivatableMixin, AuditableMixin):
    first_name = models.CharField()
    last_name = models.CharField()
    public_user_id = models.CharField(unique=True)
    email = models.CharField(unique=True)
    external_sync = models.ForeignKey(ExternalSync, models.PROTECT, blank=True, null=True)

    # Virtual relations to other shared tables
    sites = models.ManyToManyField("Site", through="UserSite", ...)
    classes = models.ManyToManyField("Class", through="UserClass", ...)
    roles = models.ManyToManyField("Role", through="UserRole", ...)
    grade_levels = models.ManyToManyField("GradeLevel", through="StudentGradeLevel", ...)

    class Meta:
        managed = False
        db_table = "users"
```

**C. The Bridge: `UserProfile`** (`cms-django/users/models.py`)

```python
class UserProfile(models.Model):
    user = models.OneToOneField("users.CustomUser", related_name="user_profile", on_delete=models.CASCADE)
    roadmaps_user = models.ForeignKey(
        User,  # <-- This is roadmaps.models.User (the shared entity)
        blank=True, null=True,
        related_name="user_profile",
        on_delete=models.DO_NOTHING,
    )
```

The `CustomUser.save()` method auto-creates a linked Roadmaps `User`:

```python
roadmaps_user = User.objects.create(
    email=django_user.email,
    first_name=django_user.first_name,
    last_name=django_user.last_name,
    public_user_id=f"django|user={django_user.id}",
    created_by=created_by,
)
profile.roadmaps_user = roadmaps_user
profile.save()
```

**D. Migration history** shows the coupling evolution:

- `0003_add_users.py` — Originally seeded Django users and linked them to groups
- `0013_delete_users.py` — Later deleted hardcoded users (moved to JumpCloud SSO)
- Throughout, the `roadmaps.models.User` remains the canonical identity in the shared database

### 1.4 Why This Creates Cross-Community Coupling

The graph analysis identified three communities that all connect through `User`:

```
┌─────────────────────────────┐
│  Shared Domain Entities     │  ← User.cs, BaseEntity.cs, Role.cs, Site.cs, etc.
│  (core domain model)        │
└─────────────┬───────────────┘
              │
              │ User is inherited by BaseEntity (CreatedBy, ModifiedBy)
              │ User is referenced by Role, Site, Class, StudentSkill, etc.
              │
┌─────────────▼───────────────┐
│  Clever API & External Sync │  ← UserImporter.cs, Repository.cs, Clever.Models.User
│  (integration boundary)     │
└─────────────┬───────────────┘
              │
              │ LookupUserByCleverId resolves ExternalSync → User
              │ ImportUserSchoolAssociations links User ↔ Site via UserSite
              │
┌─────────────▼───────────────┐
│  Django CMS Migrations      │  ← users/models.py, roadmaps/models.py
│  (content management)       │
└─────────────────────────────┘
              │
              │ UserProfile.roadmaps_user FK → roadmaps.User
              │ CustomUser.save() auto-creates roadmaps.User
              │ All roadmaps models reference "User" for auditing/ownership
```

**The coupling mechanism:**

1. **BaseEntity audit fields** — Every entity that inherits `BaseEntity` has `CreatedBy` and `ModifiedBy` navigation properties pointing to `User`. This means ~30+ entity types have a direct edge to `User` in the dependency graph.

2. **ExternalSync bridge** — The `User.ExternalSync` property links domain identity to third-party identity (Clever). The external sync code cannot function without resolving through `User`.

3. **Django ORM mirror** — The unmanaged `roadmaps.models.User` exposes the same PostgreSQL table to Django. The CMS cannot perform bulk rostering, auth, or content management without going through this shared `User` table.

### 1.5 Design Concern Assessment

| Concern | Severity | Evidence |
|---------|----------|----------|
| **Too many responsibilities** | Moderate-High | `User` has 15+ collection properties spanning auth (Roles), org structure (Sites, Classes), learning data (Diagnostics, Assessments, StudentSkills), experiments (FlagHistory, Observations), and external sync. |
| **God entity anti-pattern** | Moderate | `User` is referenced by 25+ other entity files in `Nc.Shared/Entities/` alone. Changing `User` ripples across the entire domain. |
| **Cross-stack coupling** | High | The same `users` PostgreSQL table is accessed by C# EF Core, Django ORM, and Clever sync jobs. Schema changes require coordination across three runtimes. |
| **Audit trail pollution** | Low-Moderate | `BaseEntity` forces `CreatedBy`/`ModifiedBy` on every entity, even those where user attribution may not be meaningful (e.g., system-generated records). |

**Recommendation:** Consider decomposing `User` into bounded-context-specific identities:

- An `Identity` aggregate for auth (Auth0 ID, email, roles)
- A `Person` aggregate for profile data (name, grade level)
- A `Membership` aggregate for org links (sites, classes)
- Keep `ExternalSync` as a separate aggregate referenced by ID, not as a navigation property on `User`

This would break the graph bridge and allow each community to evolve independently.

---

## Part 2 — Orphaned Assets

### 2.1 Asset Inventory

The following PNG files exist in `frontend/src/assets/mapInformation/`:

| File | Size | Added In | Last Referenced By |
|------|------|----------|-------------------|
| `map-circle.png` | 4,440 bytes | commit `63aede530` (TEAMB-929) | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-neighborhood.png` | 3,823 bytes | commit `63aede530` (TEAMB-929) | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-street.png` | 7,760 bytes | commit `63aede530` (TEAMB-929) | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |
| `map-tree.png` | 8,394 bytes | commit `63aede530` (TEAMB-929) | `DashboardMap.tsx` (deleted `2b0cc8d0a`) |

**Total orphaned payload:** ~24 KB

### 2.2 Codebase Reference Search

**Search strategy:** Full-text search across all frontend source files for any reference to the asset filenames or directory.

```bash
# Search for any imports, URLs, or string references
grep -r "map-circle\|map-neighborhood\|map-street\|map-tree\|mapInformation" \
  frontend/src --include="*.ts" --include="*.tsx" --include="*.js" \
  --include="*.jsx" --include="*.css" --include="*.scss" --include="*.json"
```

**Result:** No matches in source code.

The only matches found were in the graph analysis output (`graphify-out/`), which is generated metadata and not a functional reference.

### 2.3 Git History: When DashboardMap.tsx Was Deleted

**Deletion commit:**

```
commit 2b0cc8d0a56af1df27b9fd0e1f5e32e32d28ab59
Author: Lucas Ferrarini <lferrarini@newclassrooms.org>
Date:   Tue Jul 1 16:14:19 2025 -0300

    FE Remove Maps from Student Dashboard

    * Delete Icons and Maps components
    * Update/change old target models and redux slice for targetGroup
    * Clean vite.config file
```

**Files deleted in this commit:**

- `frontend/src/components/Dashboard/DashboardMap.tsx`
- `frontend/src/components/Dashboard/DashboardMaps/MapIcons/Icons4thGrade.ts`
- `frontend/src/components/Dashboard/DashboardMaps/MapIcons/Icons5thGrade.ts`
- `frontend/src/components/Dashboard/DashboardMaps/MapIcons/Icons6thGrade.ts`
- `frontend/src/components/Dashboard/DashboardMaps/MapIcons/Icons7thGrade.ts`
- `frontend/src/components/Dashboard/DashboardMaps/MapIcons/Icons8thGrade.ts`
- `frontend/src/components/Dashboard/DashboardMaps/MapsSkeleton/Map8thGrade.tsx`
- `frontend/src/components/Dashboard/DashboardMaps/MapsSkeleton/MapAlgebraGrade.tsx`
- `frontend/src/components/Dashboard/DashboardMaps/MapsSkeleton/MapDialog.tsx`
- `frontend/src/components/Dashboard/DashboardMaps/MapsSkeleton/MapRenderIcon.tsx`
- `frontend/src/models/Target.ts`
- `frontend/src/redux/reducers/targetSlice.ts`

**Notably absent from deletion:** The four PNG files in `frontend/src/assets/mapInformation/` were **not** deleted in this commit. They were left behind.

### 2.4 Original Usage Context

The assets were originally imported in `DashboardMap.tsx` for a map legend/info dialog:

```tsx
// From commit 63aede530 (the commit that added the assets)
import mapCircle from '../../assets/mapInformation/map-circle.png';
import mapNeighborhood from '../../assets/mapInformation/map-neighborhood.png';
import mapStreet from '../../assets/mapInformation/map-street.png';
import mapTree from '../../assets/mapInformation/map-tree.png';
```

These images were used in a PrimeReact `Dialog` component to explain the visual metaphor of the student progress map (circles = skills, neighborhoods = units, etc.).

### 2.5 Deletion Safety Assessment

| Criterion | Status |
|-----------|--------|
| Referenced by any source file? | **No** |
| Referenced by any test file? | **No** |
| Referenced by any config (vite, tsconfig, etc.)? | **No** |
| Referenced by any CSS/SCSS? | **No** |
| Referenced by any HTML template? | **No** |
| Referenced in import statements? | **No** |
| Used in any dynamic `require()` or `import()`? | **No** (searched for dynamic patterns) |
| Part of any PWA manifest or service worker? | **No** |
| Referenced in storybook or documentation? | **No** |

**Verdict:** All four PNG files are **safe to delete**.

### 2.6 Recommended Cleanup Command

```bash
rm frontend/src/assets/mapInformation/map-circle.png
rm frontend/src/assets/mapInformation/map-neighborhood.png
rm frontend/src/assets/mapInformation/map-street.png
rm frontend/src/assets/mapInformation/map-tree.png

# If the directory is now empty, remove it too:
rmdir frontend/src/assets/mapInformation/
```

---

## Key Files Referenced

### User Bridge Analysis

- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/shared/Nc.Shared/Entities/User.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/shared/Nc.Shared/Entities/BaseEntity.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/shared/Nc.Shared/Entities/BaseEntityParent.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/shared/Nc.Shared/Entities/IOwned.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/external-sync/Nc.ExternalSync/Importers/Clever/UserImporter.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/external-sync/Nc.ExternalSync/Repository.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/external-sync/Nc.Clever/Models/User.cs`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/cms-django/users/models.py`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/cms-django/roadmaps/models.py`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/cms-django/roadmaps/migrations/0003_add_users.py`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/cms-django/roadmaps/migrations/0013_delete_users.py`

### Orphaned Assets

- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/frontend/src/assets/mapInformation/map-circle.png`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/frontend/src/assets/mapInformation/map-neighborhood.png`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/frontend/src/assets/mapInformation/map-street.png`
- `/Users/lalmonte/Documents/Development/Work/.worktrees/TEAME-218/frontend/src/assets/mapInformation/map-tree.png`
- Commit `63aede530` — "Add map info dialog to map view" (added assets)
- Commit `2b0cc8d0a` — "FE Remove Maps from Student Dashboard" (deleted consumer, left assets)

