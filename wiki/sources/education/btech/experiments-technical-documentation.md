---
description: "Database schema documentation for experiments flag history, observations, and speculative data tables"
tags: ['research']
raw_file: "Experiments - Technical Documentation.md"
created: 2026-05-17
---

# New Tables:

Unleash Doc Pages:

- [React Reference](https://docs.getunleash.io/reference/sdks/react "https://docs.getunleash.io/reference/sdks/react")
    
- [Unleash Schema for a Get Request](https://docs.getunleash.io/reference/api/unleash/get-frontend-features "https://docs.getunleash.io/reference/api/unleash/get-frontend-features")
    
    - [Schema if no variants are defined](https://docs.getunleash.io/reference/strategy-variants#fallback-variant "https://docs.getunleash.io/reference/strategy-variants#fallback-variant")?
        
    - [Toggle Data](https://docs.getunleash.io/reference/unleash-proxy#toggle-data "https://docs.getunleash.io/reference/unleash-proxy#toggle-data")?
        

**NOTE:** The frontend that logs to these tables will be responsible for adapting the variant_name column in the event the feature toggle has no variants (just on or off).

- From Unleash: In the case that the toggle is off (either in general, or for this particular user), it won’t be returned by Unleash in the set of toggles and the variant name will be undefined (?). In the event that the toggle is on, but there is only one/no variant, the variant name will be “disabled”.
    
- In our tables: Inactive toggles (the default case in an experiment) will be remapped to “control” (from undefined/NULL). Active Toggles with only one variant will be remapped to “treatment” (from “disabled”).
    

So all flag states will have a variant_name as a string that identifies the test condition active at the time of logging.

## FAQ:

- Should flag_name or variant_name be foreign-keyed?
    
    - No, because data integrity in these tables doesn’t affect any business logic in the application, and using a separate flags table would make double-bookkeeping necessary between Unleash and the database.
        
- What’s the use of the created_by_id field?
    
    - In most cases, this will be the same as the user_id for the record, but parallelism with other tables makes it easier to reuse, e.g., data access audit queries, etc.
        

## experiments_flag_history

This table supports analytics where we’re tracking existing metrics across multiple experiment lifecycles. (E.g. looking at existing student flow analyses, segmented by when students were in a test condition. That’s mostly a convenience relative to duplicating existing logging and analytics per experiment.)

NOTE: For data integrity, we will generally need to externally track (e.g. from Unleash logs) when an experiment became inactive altogether and use date-based filtering to infer all final states as “control”.

|               |             |          |         |                                                                                                                                                                                                                                 |
| ------------- | ----------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| column        | type        | not null | default | foreign key                                                                                                                                                                                                                     |
| id            | integer     | X        |         |                                                                                                                                                                                                                                 |
| user_id       | integer     | X        |         | [users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users") |
| ==flag_name== | varchar     | X        |         |                                                                                                                                                                                                                                 |
| variant_name  | varchar     | X        |         |                                                                                                                                                                                                                                 |
| created_by_id | integer     | X        |         | [users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users") |
| created_on    | timestamptz | X        | now()   |                                                                                                                                                                                                                                 |

### Indexes

|   |   |   |   |
|---|---|---|---|
|name|unique|columns|**use case**|
|experiments_flag_history_pkey|X|id||
|==experiments_flag_history_user_id_flag_name_created_on_idx==||user_id, flag_name, created_on|Reconstruct experimental state for a given flag at a given time.|

## experiments_observations

This is all of the data that will be used on the experiment-agnostic QuickSight dashboards. Filtered for flag_name, then for observation_type, the dashboard would compare histograms of sums, medians, and means of the observation for each user, compared across variants.

Example observation_types:

- Clicked the button (always has value 1, acts like a count, look at sum per user)
    
- Passed the test (like a boolean, interested in mean per user)
    
- Time to complete practice problems (acts like a float, interested in median per user)
    
    - Could potentially define new observation types (strings) specific to individual skills or other comparison categories.
        
- Student-reported affect after each activity (question-keyed likert values).
    

|                  |             |          |         |                                                                                                                                                                                                                                 |
| ---------------- | ----------- | -------- | ------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| column           | type        | not null | default | foreign key                                                                                                                                                                                                                     |
| id               | integer     | X        |         |                                                                                                                                                                                                                                 |
| user_id          | integer     | X        |         | [users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users") |
| flag_name        | varchar     | X        |         |                                                                                                                                                                                                                                 |
| variant_name     | varchar     | X        |         |                                                                                                                                                                                                                                 |
| observation_type | varchar     | X        |         |                                                                                                                                                                                                                                 |
| observation      | numeric     | X        |         |                                                                                                                                                                                                                                 |
| created_by_id    | integer     | X        |         | [users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users") |
| created_on       | timestamptz | X        | now()   |                                                                                                                                                                                                                                 |

### Indexes

|   |   |   |   |
|---|---|---|---|
|name|unique|columns|**use case**|
|experiments_observations_pkey|X|id||
|==experiments_observations_flag_name_observation_type_idx==||flag_name, observation_type|Easy filtering of all data for a given experiment metric (comparing across variants).|

## experiments_speculative_data

This table supports persisting user data across sessions for features that may not be permanent.

|   |   |   |   |   |
|---|---|---|---|---|
|column|type|not null|default|foreign key|
|id|integer|X|||
|user_id|integer|X||[users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users")|
|flag_name|varchar|X|||
|variant_name|varchar|X|||
|payload|jsonb (Binary JSON)|X|{}||
|==created_by_id==|integer|X||[users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users")|
|created_on|timestamptz|X|now()||
|modified_by_id|integer|||[users.id](https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users "https://newclassrooms.atlassian.net/wiki/spaces/TRA/pages/210534404/Database+Schema+as+Built#table_users")|
|modified_on|timestamptz||||

### Indexes

|                                                                 |        |                                  |                                                                                                                                                             |
| --------------------------------------------------------------- | ------ | -------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------- |
| name                                                            | unique | columns                          | **use case**                                                                                                                                                |
| experiments_speculative_data_pkey                               | X      | id                               |                                                                                                                                                             |
| experiments_speculative_data_flag_name_idx                      |        | flag_name                        | Analytics accesses all data for a single experiment                                                                                                         |
| experiments_speculative_data_user_id_flag_name_variant_name_idx | X      | user_id, flag_name, variant_name | enforces uniqueness of user-persistent feature-variant-specific data.<br><br>Frontend can proactively load all experiment data for one user (user_id only). |
