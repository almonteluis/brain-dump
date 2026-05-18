---
description: "JumpCloud to Django User Synchronization Pipeline"
tags: ['research']
raw_file: "JumpCloud to Django User Sync Pipeline.md"
created: 2026-05-17
---

# JumpCloud to Django User Synchronization Pipeline

> **Summary:** This document traces the complete bidirectional sync pipeline between JumpCloud (IdP), Django CMS, Auth0, and the Roadmaps platform. JumpCloud is the source of truth for CMS user identities and group membership. A background scheduler runs every 15 minutes to pull JumpCloud users, create missing Django users, update group memberships, deactivate orphaned users, and elevate superusers based on admin role mappings. Auth0 serves as the authentication broker for Roadmaps users, with Django admin providing bidirectional sync hooks when Roadmaps users are edited. The system also supports bulk rostering via import jobs.

---

## Table of Contents

1. [Architecture Overview](#1-architecture-overview)
2. [How JumpCloud Users Are Fetched and Mapped](#2-how-jumpcloud-users-are-fetched-and-mapped)
3. [Group-Based Role Mapping Logic](#3-group-based-role-mapping-logic)
4. [Superuser Elevation Logic](#4-superuser-elevation-logic)
5. [Auth0 Integration in the Sync Flow](#5-auth0-integration-in-the-sync-flow)
6. [Django Admin Integration](#6-django-admin-integration)
7. [Webhook and Event-Driven Triggers](#7-webhook-and-event-driven-triggers)
8. [Data Flow Diagram](#8-data-flow-diagram)
9. [Key Files Reference](#9-key-files-reference)

---

## 1. Architecture Overview

The sync pipeline involves four main systems:

| System | Role |
|--------|------|
| **JumpCloud** | Identity provider (IdP). Source of truth for user accounts and group memberships. |
| **Django CMS** | Internal admin dashboard. Stores `CustomUser` records with group/permission mappings. |
| **Auth0** | Authentication broker for Roadmaps platform users. Manages login, blocking, and user profiles. |
| **Roadmaps** | Student/teacher platform. Uses `User` model with `public_user_id` linking to Auth0. |

There are two distinct user types:

- **CMS Users (`CustomUser`)**: Staff who log into the Django admin. Synced from JumpCloud.
- **Roadmaps Users (`roadmaps.models.User`)**: Students, teachers, and school staff. Synced via bulk rostering or manual admin entry, with Auth0 as the identity broker.

---

## 2. How JumpCloud Users Are Fetched and Mapped

### 2.1 Fetching Users from JumpCloud

The `jumpcloud_user_mgmt.py` module queries the JumpCloud API to retrieve all users and their group memberships.

**File:** `cms-django/jumpcloud_integration/jumpcloud/jumpcloud_user_mgmt.py`

```python
def __list_users__():
    url = f"{host_v1}/systemusers"
    headers = {"Content-Type": content_type, "Accept": accept, "x-api-key": api_key}
    res = requests.get(url, headers=headers)
    return res.json()
```

For each user, it fetches their group memberships via the v2 API:

```python
def __get_groups_by_user__(users):
    for user in users["results"]:
        url = f"{host_v2}/users/{user['id']}/memberof?limit=100"
        res = requests.get(url, headers=headers)
        groups = res.json()
        # ... filter to CMS-only groups
```

### 2.2 Filtering to CMS-Related Groups

JumpCloud groups are filtered to only include those prefixed with `APP_CMS`:

```python
def get_all_cms_user_groups():
    url = f"{host_v2}/usergroups?filter=name:search:APP_CMS"
    # Returns only APP_CMS_* groups
```

Each user's LDAP groups are checked against this CMS group list:

```python
def __filter_user_group_names__(groups):
    cms_user_groups = get_all_cms_user_groups()
    for group in groups:
        ldap_groups = group["compiledAttributes"]["ldapGroups"]
        for ldap_group in ldap_groups:
            if ldap_group["name"] in cms_user_groups:
                user_groups.append(ldap_group["name"])
```

### 2.3 User Data Structure

Each JumpCloud user is transformed into a dictionary:

```python
{
    "email": user["email"],
    "first_name": user["firstname"],
    "last_name": user["lastname"],
    "groups": ["APP_CMS_DEV_ADMIN", "APP_CMS_NON_PROD_ADMIN"]  # CMS-only groups
}
```

### 2.4 Mapping to Django Users

The orchestrator (`jumpcloud_user_sync.py`) compares JumpCloud emails against all Django `CustomUser` emails:

**File:** `cms-django/users/jumpcloud_user_sync.py`

```python
def user_sync():
    django_jumpcloud_roles_by_env = os.getenv("DJANGO_JUMPCLOUD_ROLES").split(",")
    jumpcloud_users = jumpcloud.load_users()
    all_django_users = django.get_all_users()
    all_django_user_emails = django.get_all_user_emails()

    all_jumpcloud_user_emails = manage_user_creation(
        django_jumpcloud_roles_by_env, jumpcloud_users, all_django_user_emails
    )
    manage_deactivations(all_jumpcloud_user_emails, all_django_user_emails)
    manage_groups(django_jumpcloud_roles_by_env, jumpcloud_users)
```

---

## 3. Group-Based Role Mapping Logic

### 3.1 Environment-Specific Role Filtering

The `DJANGO_JUMPCLOUD_ROLES` environment variable defines which JumpCloud groups are relevant for the current environment. This allows different environments (dev, staging, prod) to have different access scopes.

```python
django_jumpcloud_roles_by_env = os.getenv("DJANGO_JUMPCLOUD_ROLES").split(",")
# Example: ["APP_CMS_DEV_ADMIN", "APP_CMS_DEV_EDITOR"]
```

### 3.2 Two-Step Group Validation

For each JumpCloud user, the sync performs two checks:

1. **Intersection check**: The user's JumpCloud groups are intersected with the environment-specific roles.
2. **Membership check**: The user must belong to at least one CMS group to be considered a CMS user.

```python
environment_specific_user_roles = set(jumpcloud_user["groups"]).intersection(
    set(django_jumpcloud_roles_by_env)
)

if (
    len(jumpcloud_user["groups"]) > 0
    and len(environment_specific_user_roles) > 0
):
    # User is a valid CMS user for this environment
    jumpcloud_user["groups"] = environment_specific_user_roles
```

### 3.3 Django Group Synchronization

When a user's groups need updating, the sync replaces the user's Django groups entirely:

**File:** `cms-django/jumpcloud_integration/django/django_user_mgmt.py`

```python
def update_user_group_membership(jumpcloud_user, django_user=None):
    email = jumpcloud_user['email']
    group_names = jumpcloud_user['groups']
    groups = Group.objects.filter(name__in=group_names)
    user.groups.set(groups, clear=True)  # Full replacement
```

### 3.4 Group Change Detection

To avoid unnecessary writes, the sync compares the current Django groups against the JumpCloud groups using `Counter` equality:

```python
def should_update_groups(jumpcloud_user):
    all_django_groups = jumpcloud.get_all_cms_user_groups()
    jumpcloud_groups = jumpcloud_user["groups"]
    django_user = __get_user__(jumpcloud_user["email"])
    django_groups = __get_groups_by_user__(django_user)

    jc_django_groups = [
        g for g in jumpcloud_groups if g in all_django_groups
    ]

    return Counter(jc_django_groups) != Counter(django_groups)
```

---

## 4. Superuser Elevation Logic

### 4.1 Admin Role Definitions

Admin roles are defined in Django settings:

**File:** `cms-django/cms/configurations/common.py`

```python
ADMIN_ROLES = [
    "APP_CMS_NON_PROD_ADMIN",
    "APP_CMS_DEV_ADMIN",
    "APP_CMS_SMARKETING_ADMIN",
    "APP_CMS_PROD_ADMIN",
]
```

### 4.2 Elevation During User Creation

When a new Django user is created from JumpCloud, superuser status is determined immediately:

**File:** `cms-django/jumpcloud_integration/django/django_user_mgmt.py`

```python
def create_user(jumpcloud_user):
    is_superuser = False
    if len(set(ADMIN_ROLES).intersection(jumpcloud_user['groups'])) > 0:
        is_superuser = True

    django_user = User.objects.create_user(
        email=jumpcloud_user['email'],
        password='',
        first_name=jumpcloud_user['first_name'],
        last_name=jumpcloud_user['last_name'],
        created_by=admin_user,
        is_active=True,
        is_staff=True,
        is_superuser=is_superuser
    )
```

### 4.3 Elevation During Group Updates

During periodic sync, if a user's groups change and now include an admin role, they are elevated:

**File:** `cms-django/users/jumpcloud_user_sync.py`

```python
def manage_groups(django_jumpcloud_roles_by_env, jumpcloud_users):
    # ...
    if should_update_groups:
        django.update_user_group_membership(jumpcloud_user)
        django.update_is_staff(jumpcloud_user["email"], True)
        django.update_is_active(jumpcloud_user["email"], True)

        if len(set(ADMIN_ROLES).intersection(jumpcloud_user["groups"])) > 0:
            print(f"Adding superuser to {jumpcloud_user['email']}")
            django.update_is_superuser(jumpcloud_user["email"], True)
```

### 4.4 Deactivation and Privilege Revocation

If a JumpCloud user no longer exists or has no CMS groups, all privileges are revoked:

```python
def manage_deactivations(all_jumpcloud_user_emails, all_django_user_emails):
    for django_user_email in all_django_user_emails:
        if django_user_email not in all_jumpcloud_user_emails and "admin" not in django_user_email:
            django.update_is_staff(django_user_email, False)
            django.update_is_superuser(django_user_email, False)
            django.update_is_active(django_user_email, False)
            django.update_user_group_membership({"email": django_user_email, "groups": []})
```

**Note:** Users with "admin" in their email are protected from deactivation.

---

## 5. Auth0 Integration in the Sync Flow

### 5.1 Auth0Session Class

**File:** `cms-django/users/auth0.py`

The `Auth0Session` class provides a reusable connection to the Auth0 Management API:

```python
class Auth0Session:
    auth0 = None
    connected = False

    def __init__(self):
        self.connect()

    def connect(self):
        get_token = GetToken(
            settings.AUTH0_DOMAIN, settings.AUTH0_CLIENT_ID, settings.AUTH0_SECRET
        )
        token_response = get_token.client_credentials(
            f"https://{settings.AUTH0_DOMAIN}/api/v2/"
        )
        token = token_response["access_token"]
        self.auth0 = Auth0(settings.AUTH0_DOMAIN, token)
        self.connected = True
```

### 5.2 Auth0 Operations

| Method | Purpose |
|--------|---------|
| `get_user_by_id(public_user_id)` | Lookup user by Auth0 ID |
| `get_user_by_email(email)` | Lookup user by email |
| `get_users_by_emails(emails)` | Bulk email lookup (chunked, with retries) |
| `create_user(email, name, blocked)` | Create a new Auth0 user |
| `block_users(ids)` | Block users (deactivate) |
| `unblock_users(ids)` | Unblock users (activate) |
| `update_auth0_fields(user, changed_fields)` | Sync Django changes to Auth0 |
| `bulk_import_users(users, connection_id)` | Bulk import via Auth0 Jobs API |

### 5.3 update_auth0_fields: Bidirectional Sync

This method maps Django field changes to Auth0 profile updates:

```python
def update_auth0_fields(self, user, changed_fields):
    main_update = {}
    password_update = None

    for field in changed_fields:
        if field == "first_name" or field == "last_name":
            main_update["name"] = user.first_name + " " + user.last_name
        elif field == "is_active":
            main_update["blocked"] = not user.is_active
        elif field == "email":
            main_update["email"] = user.email
        elif field == "password":
            password_update = {"password": user.password}

    if main_update:
        self.auth0.users.update(user.public_user_id, main_update)
    if password_update:
        self.auth0.users.update(user.public_user_id, password_update)
```

**Key mappings:**
- `is_active=False` in Django → `blocked=True` in Auth0
- Name changes → update Auth0 `name` field
- Email changes → update Auth0 `email` field
- Password changes → update Auth0 password directly

### 5.4 Auth0 in Roadmaps Models

**File:** `cms-django/roadmaps/models.py`

The Roadmaps `User` model has class methods for bulk activation/deactivation that sync to Auth0:

```python
class User(ActivatableMixin, AuditableMixin):
    @classmethod
    def activate_users(cls, queryset):
        queryset.update(is_active=True)
        return Auth0Session().unblock_users([u.public_user_id for u in queryset])

    @classmethod
    def deactivate_users(cls, queryset):
        queryset.update(is_active=False)
        return Auth0Session().block_users([u.public_user_id for u in queryset])

    def get_auth0_info(self):
        return Auth0Session().get_user_by_id(self.public_user_id)
```

---

## 6. Django Admin Integration

### 6.1 CustomUserAdmin (CMS Users)

**File:** `cms-django/users/admin.py`

The Django admin for CMS users handles user creation and editing with audit fields:

```python
class CustomUserAdmin(UserAdmin):
    model = CustomUser
    list_display = ["id", "email", "first_name", "last_name", "is_staff", "is_superuser", "is_active", "last_login"]
    readonly_fields = ["last_login", "created_by", "created_on", "modified_by", "modified_on"]

    def save_model(self, request, obj, form, change):
        if change:
            obj.modified_by = request.user
        else:
            obj.created_by = request.user
        super().save_model(request, obj, form, change)
```

**Important:** The `CustomUserAdmin.save_model` does **NOT** call Auth0. CMS users are authenticated via JumpCloud SSO (SAML2), not Auth0.

### 6.2 UserProfile Inline

Each `CustomUser` has an associated `UserProfile` that links to a Roadmaps `User`:

```python
class UserProfileInline(admin.StackedInline):
    model = UserProfile
    can_delete = False
    autocomplete_fields = ["roadmaps_user"]
```

### 6.3 CustomUser.save() Auto-Creates Roadmaps User

**File:** `cms-django/users/models.py`

When a `CustomUser` is saved, the overridden `save()` method ensures:

1. A `UserProfile` exists (creates one if missing)
2. If the user is staff, a corresponding Roadmaps `User` is created

```python
def save(self, **kwargs):
    super().save(**kwargs)

    # Ensure UserProfile exists
    try:
        profile = self.user_profile
    except ObjectDoesNotExist:
        profile = UserProfile.objects.create(user=self)

    if not self.is_staff:
        return  # Non-staff users don't get Roadmaps users

    # Ensure Roadmaps user exists
    if not profile.roadmaps_user:
        roadmaps_user = User.objects.filter(email=self.email).first()
        if not roadmaps_user:
            roadmaps_user = User.objects.create(
                email=self.email,
                first_name=self.first_name,
                last_name=self.last_name,
                public_user_id=f"django|user={self.id}",
                created_by=self.created_by.user_profile.roadmaps_user,
            )
        profile.roadmaps_user = roadmaps_user
        profile.save()
```

### 6.4 Roadmaps UserAdmin (Auth0 Sync)

**File:** `cms-django/roadmaps/admin.py`

The Roadmaps `UserAdmin.save_model` provides **bidirectional Auth0 synchronization**:

```python
def save_model(self, request, obj, form, change):
    user = obj
    auth0 = Auth0Session()
    user_by_public_user_id = auth0.get_user_by_id(user.public_user_id) if user.public_user_id else None
    user_by_email = auth0.get_user_by_email(user.email)

    safe_to_update_at_auth0 = False
    override_auth0_changes = []

    if not user.is_django_user:
        # Only applies to Roadmaps users, not CMS users
        if change:
            # Editing existing user
            if not auth0_user_exists(user_by_public_user_id):
                # Auth0 user missing - show error
                messages.add_message(request, messages.ERROR, "No user exists at Auth0...")
            else:
                safe_to_update_at_auth0 = True
        else:
            # Adding new user
            if user.public_user_id and auth0_user_exists(user_by_public_user_id):
                safe_to_update_at_auth0 = True
            elif auth0_user_exists(user_by_email):
                user.public_user_id = user_by_email["user_id"]
                safe_to_update_at_auth0 = True
            else:
                # Create new Auth0 user
                auth0_user = auth0.create_user(user.email, f"{user.first_name} {user.last_name}", blocked=not user.is_active)
                user.public_user_id = auth0_user["user_id"]

    if safe_to_update_at_auth0:
        results = auth0.update_auth0_fields(user, form.changed_data + override_auth0_changes)
        # ... display results as messages

    super().save_model(request, obj, form, change)
```

This enables admins to:
- Create a Roadmaps user and automatically provision them in Auth0
- Edit a user and have changes (name, email, active status) pushed to Auth0
- See Auth0 status information inline in the admin form

---

## 7. Webhook and Event-Driven Triggers

### 7.1 APScheduler Background Job (Primary Trigger)

**File:** `cms-django/users/apps.py`

The sync is triggered by a background scheduler running every 15 minutes:

```python
class UsersConfig(AppConfig):
    def ready(self):
        from django_apscheduler.jobstores import DjangoJobStore
        from apscheduler.schedulers.background import BackgroundScheduler
        from users.jumpcloud_user_sync import user_sync

        scheduler = BackgroundScheduler()
        scheduler.add_jobstore(DjangoJobStore(), "default")
        scheduler.add_job(
            user_sync,
            "interval",
            minutes=15,
            id="user_sync",
            replace_existing=True,
        )
        scheduler.start()
```

**Trigger:** Every 15 minutes via APScheduler interval job.

### 7.2 No Webhooks from JumpCloud

There are **no JumpCloud webhooks** in this codebase. The sync is purely pull-based via the scheduled job. The system does not receive push notifications from JumpCloud when users are added, removed, or group memberships change.

### 7.3 Bulk Rostering Trigger

**File:** `cms-django/roadmaps/bulk_rostering/auth0_sync.py`

For Roadmaps users, bulk rostering operations trigger Auth0 bulk imports:

```python
# Bulk import via Auth0 Jobs API
auth0.bulk_import_users(
    users=batch.payload(),
    connection_id=connection_id,
    upsert=False,
    send_completion_email=False,
)
```

This is triggered by:
- CSV/Excel upload through the bulk rostering wizard
- External sync integrations (e.g., Clever)

### 7.4 Manual Admin Trigger

Roadmaps user changes in Django admin trigger immediate Auth0 sync via `UserAdmin.save_model` (see Section 6.4).

---

## 8. Data Flow Diagram

```
┌─────────────────────────────────────────────────────────────────────────────────────────┐
│                              JUMPCLOUD TO DJANGO SYNC PIPELINE                          │
└─────────────────────────────────────────────────────────────────────────────────────────┘

  ┌─────────────┐
  │  JumpCloud  │◄────────────────────────────────────────────────────────────┐
  │   (IdP)     │                                                             │
  └──────┬──────┘                                                             │
         │                                                                    │
         │ 1. GET /api/systemusers (list all users)                           │
         │ 2. GET /api/v2/users/{id}/memberof (groups per user)               │
         │ 3. GET /api/v2/usergroups?filter=name:search:APP_CMS (CMS groups)  │
         │                                                                    │
         ▼                                                                    │
  ┌─────────────────────────────┐                                            │
  │ jumpcloud_user_mgmt.py      │                                            │
  │ - load_users()              │                                            │
  │ - __filter_user_group_names__()                                          │
  └─────────────┬───────────────┘                                            │
                │                                                            │
                │ jumpcloud_users["users"]                                   │
                │ [{email, first_name, last_name, groups}]                   │
                ▼                                                            │
  ┌─────────────────────────────┐                                            │
  │ jumpcloud_user_sync.py      │                                            │
  │                             │                                            │
  │ ┌─────────────────────┐     │                                            │
  │ │ manage_user_creation│     │                                            │
  │ │ - Filter by env     │     │                                            │
  │ │ - Skip if exists    │     │                                            │
  │ │ - create_user()     │─────┼────────────────────────────────────────────┤
  │ └─────────────────────┘     │                                            │
  │                             │                                            │
  │ ┌─────────────────────┐     │                                            │
  │ │ manage_deactivations│     │                                            │
  │ │ - Revoke perms      │     │                                            │
  │ │ - Set is_active=F   │     │                                            │
  │ └─────────────────────┘     │                                            │
  │                             │                                            │
  │ ┌─────────────────────┐     │                                            │
  │ │ manage_groups       │     │                                            │
  │ │ - Compare groups    │     │                                            │
  │ │ - Update if changed │     │                                            │
  │ │ - Elevate superuser │     │                                            │
  │ └─────────────────────┘     │                                            │
  └─────────────┬───────────────┘                                            │
                │                                                            │
                ▼                                                            │
  ┌─────────────────────────────┐     ┌─────────────────────────────┐        │
  │ django_user_mgmt.py         │     │ Django ORM                  │        │
  │                             │     │                             │        │
  │ - create_user()             │────►│  CustomUser                 │        │
  │ - update_user_group_membership│   │  ├── email (USERNAME_FIELD) │        │
  │ - update_is_staff()         │     │  ├── first_name             │        │
  │ - update_is_superuser()     │     │  ├── last_name              │        │
  │ - update_is_active()        │     │  ├── is_staff               │        │
  │ - should_update_groups()    │     │  ├── is_superuser           │        │
  │                             │     │  ├── is_active              │        │
  │                             │     │  ├── groups (ManyToMany)    │        │
  │                             │     │  └── created_by             │        │
  │                             │     │                             │        │
  │                             │     │  UserProfile                │        │
  │                             │     │  ├── user (OneToOne)        │        │
  │                             │     │  └── roadmaps_user (FK)     │────────┼────► Roadmaps User
  └─────────────────────────────┘     └─────────────────────────────┘        │
                                                                             │
                                                                             │
┌────────────────────────────────────────────────────────────────────────────┤
│                              AUTH0 SYNC (Roadmaps)                         │
└────────────────────────────────────────────────────────────────────────────┘
                                                                             │
  ┌─────────────────────────────┐                                            │
  │ Django Admin (roadmaps)     │                                            │
  │ UserAdmin.save_model()      │                                            │
  └─────────────┬───────────────┘                                            │
                │                                                            │
                │ 1. Check Auth0 by public_user_id                           │
                │ 2. Check Auth0 by email                                    │
                │ 3. Create or link Auth0 user                               │
                │ 4. Call update_auth0_fields()                              │
                ▼                                                            │
  ┌─────────────────────────────┐                                            │
  │ users/auth0.py              │                                            │
  │ Auth0Session                │                                            │
  │                             │                                            │
  │ - connect()                 │────► Auth0 Management API                 │
  │ - get_user_by_id()          │      (get token, CRUD users)              │
  │ - get_user_by_email()       │                                            │
  │ - create_user()             │                                            │
  │ - block/unblock_users()     │                                            │
  │ - update_auth0_fields()     │                                            │
  │ - bulk_import_users()       │                                            │
  └─────────────────────────────┘                                            │
                                                                             │
  ┌─────────────────────────────┐                                            │
  │ roadmaps/models.py          │                                            │
  │ User.activate_users()       │────► Auth0Session().unblock_users()       │
  │ User.deactivate_users()     │────► Auth0Session().block_users()         │
  │ User.get_auth0_info()       │────► Auth0Session().get_user_by_id()      │
  └─────────────────────────────┘                                            │
                                                                             │
  ┌─────────────────────────────┐                                            │
  │ bulk_rostering/auth0_sync.py│                                            │
  │ - Bulk email lookup         │────► Auth0 Users Search API               │
  │ - Bulk import jobs          │────► Auth0 Jobs Import API                │
  │ - Job status polling        │                                            │
  └─────────────────────────────┘                                            │
                                                                             │
┌────────────────────────────────────────────────────────────────────────────┤
│                              SCHEDULER TRIGGER                             │
└────────────────────────────────────────────────────────────────────────────┘
                                                                             │
  ┌─────────────────────────────┐                                            │
  │ users/apps.py               │                                            │
  │ UsersConfig.ready()         │                                            │
  │                             │                                            │
  │ APScheduler Background Job  │                                            │
  │ Interval: every 15 minutes  │────► users.jumpcloud_user_sync.user_sync  │
  │ ID: "user_sync"             │                                            │
  └─────────────────────────────┘                                            │
```

---

## 9. Key Files Reference

| File | Purpose |
|------|---------|
| `cms-django/users/jumpcloud_user_sync.py` | Main orchestrator: `user_sync()` entry point |
| `cms-django/users/models.py` | `CustomUser`, `UserProfile`, `CustomUserManager` |
| `cms-django/users/admin.py` | `CustomUserAdmin` for Django admin |
| `cms-django/users/auth0.py` | `Auth0Session` class for Auth0 Management API |
| `cms-django/users/apps.py` | APScheduler configuration (15-min interval) |
| `cms-django/users/forms.py` | `CustomUserCreationForm`, `CustomUserChangeForm` |
| `cms-django/jumpcloud_integration/jumpcloud/jumpcloud_user_mgmt.py` | JumpCloud API client |
| `cms-django/jumpcloud_integration/django/django_user_mgmt.py` | Django user CRUD operations |
| `cms-django/jumpcloud_integration/main.py` | Standalone script (legacy/development) |
| `cms-django/roadmaps/models.py` | Roadmaps `User` model with Auth0 class methods |
| `cms-django/roadmaps/admin.py` | Roadmaps `UserAdmin` with Auth0 bidirectional sync |
| `cms-django/roadmaps/bulk_rostering/auth0_sync.py` | Bulk Auth0 import/lookup for rostering |
| `cms-django/cms/configurations/common.py` | Settings: `ADMIN_ROLES`, `ADMIN_USER_EMAIL`, JumpCloud config |

