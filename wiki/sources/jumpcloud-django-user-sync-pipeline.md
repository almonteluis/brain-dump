---
description: Complete bidirectional sync pipeline between JumpCloud (IdP), Django CMS, Auth0, and Roadmaps platform
tags: ["new-classrooms", "jumpcloud", "django", "auth0", "identity-sync", "sso"]
sources: ["JumpCloud to Django User Sync Pipeline.md"]
created: 2026-04-28
updated: 2026-04-28
---

# JumpCloud to Django User Synchronization Pipeline

**Source:** `JumpCloud to Django User Sync Pipeline.md`
**Date ingested:** 2026-04-28
**Type:** Architecture documentation

## Summary

Complete bidirectional sync pipeline between four systems: JumpCloud (IdP), Django CMS, Auth0, and the Roadmaps platform. JumpCloud is the source of truth for CMS user identities and group membership. A background scheduler runs every 15 minutes to pull JumpCloud users, create missing Django users, update group memberships, deactivate orphaned users, and elevate superusers based on admin role mappings. Auth0 serves as the authentication broker for Roadmaps users, with Django admin providing bidirectional sync hooks when Roadmaps users are edited.

## Architecture

| System | Role |
|--------|------|
| **JumpCloud** | Identity provider (IdP). Source of truth for user accounts and group memberships. |
| **Django CMS** | Internal admin dashboard. Stores `CustomUser` records with group/permission mappings. |
| **Auth0** | Authentication broker for Roadmaps platform users. Manages login, blocking, and user profiles. |
| **Roadmaps** | Student/teacher platform. Uses `User` model with `public_user_id` linking to Auth0. |

## Two Distinct User Types

- **CMS Users (`CustomUser`)**: Staff who log into the Django admin. Synced from JumpCloud.
- **Roadmaps Users (`roadmaps.models.User`)**: Students, teachers, and school staff. Synced via bulk rostering or manual admin entry, with Auth0 as the identity broker.

## Key Sync Behaviors

### JumpCloud → Django (Every 15 Minutes)

1. Query JumpCloud API for all users and their group memberships
2. Filter to CMS-only groups (prefix `APP_CMS`)
3. Compare JumpCloud emails against Django `CustomUser` emails
4. Create missing users, update group memberships, deactivate orphaned users
5. Elevate superusers if groups include admin roles

### Group Synchronization

- Full replacement pattern: `user.groups.set(groups, clear=True)`
- Change detection via `Counter` equality to avoid unnecessary writes
- Environment-specific role filtering via `DJANGO_JUMPCLOUD_ROLES`

### Auth0 Bidirectional Sync

Django admin `UserAdmin.save_model` for Roadmaps users:
- Create → auto-provision in Auth0
- Edit → push changes (name, email, active status) to Auth0
- `is_active=False` → `blocked=True` in Auth0
- `public_user_id` links Roadmaps user to Auth0 identity

### Superuser Elevation

```python
ADMIN_ROLES = [
    "APP_CMS_NON_PROD_ADMIN",
    "APP_CMS_DEV_ADMIN",
    "APP_CMS_SMARKETING_ADMIN",
    "APP_CMS_PROD_ADMIN",
]
```

## Scheduler Trigger

```python
scheduler.add_job(
    user_sync,
    "interval",
    minutes=15,
    id="user_sync",
    replace_existing=True,
)
```

**No JumpCloud webhooks** — sync is purely pull-based.

## Key Files

| File | Purpose |
|------|---------|
| `cms-django/users/jumpcloud_user_sync.py` | Main orchestrator |
| `cms-django/users/models.py` | `CustomUser`, `UserProfile` |
| `cms-django/users/auth0.py` | `Auth0Session` Management API client |
| `cms-django/jumpcloud_integration/jumpcloud/jumpcloud_user_mgmt.py` | JumpCloud API client |
| `cms-django/roadmaps/models.py` | Roadmaps `User` with Auth0 class methods |
| `cms-django/roadmaps/admin.py` | Roadmaps `UserAdmin` with Auth0 sync |

## Concepts Covered

- [[identity-sync]] — Bidirectional user synchronization across systems
- [[sso]] — Single sign-on with JumpCloud as IdP
- [[user-bridge]] — `User` entity as cross-community bridge (see [[user-bridge-analysis-orphaned-assets]])
- [[bulk-rostering]] — CSV/Excel upload with Auth0 Jobs API

## Related

- [[user-bridge-analysis-orphaned-assets]] — Analysis of `User` entity coupling across communities
- [[assessmentauditor-assignmentchecker-pattern-analysis]] — Another NC backend pattern
- [[nc-frontend-architecture]] — NC frontend architecture
