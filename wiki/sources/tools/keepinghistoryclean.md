---
description: "Git best practices for maintaining clean commit history"
tags: ['research']
raw_file: "KeepingHistoryClean.md"
created: 2026-05-17
---

---

# Keeping History Clean

- [Understand Branches](#understand-branches)
- [Make Coherent Commits](#make-coherent-commits)
- [Write Good Commit Messages](#write-good-commit-messages)
- [Commit Often, Perfect Later](#commit-often-perfect-later)

## Understand Branches

If you don't have a solid understanding of how branches work in git, a lot of the topics in this page will be confusing, and it will be easy to make mistakes that can be undone but that have made things more complicated.

## Make Coherent Commits

A commit should address a single topic.

- Linting cannot be mixed into functional changes
- Changes requested during code review should be squashed into the relevant commit (push *then* squash)
- Avoid mixing in significant refactoring with functional changes
- Merge commits are strictly forbidden (use `git rebase`)

Commits should, generally, cover a single topic. For example, if you're adding a new parameter to a function, your commit will probably include the addition of that parameter, the implementation that handles it, an update to the comment on the function, unit tests covering your change, updates to code that calls that function, and possibly updates to documentation outside the code itself.

However, your commit should probably *not* include other refactoring not directly related, code formatting changes (linting) or other clean-up, temporary changes you may have made while working on it, other unrelated changes you may be working on in parallel, and so on. All of these things can be good things to do, but they should be organized into another commit. (See below about "commit often, perfect later".)

When a single commit covers multiple topics, this:

- Makes it difficult during code review to focus on the most important changes
- Makes it difficult to understand the history of the code when trying to track down bugs
- Makes it difficult to revert only the undesirable parts of the commit

## Write Good Commit Messages

When you are writing commit messages and reviewing pull requests, please follow the guidelines below. They're summarized from this excellent article.

- Separate subject from body with a blank line
- Limit the subject line to 50 characters, if possible, but do not wrap it if it exceeds that length
- Capitalize the subject line
- Do not end the subject line with a period
- Use the imperative mood in the subject line (should complete the sentence, "When applied, this commit will ___.")
- Wrap the body at 72 characters (bullet lists with asterisks are appropriate)
- Use the body to explain *what* and *why* vs. *how*

In addition, if the commit relates to a Jira issue—which it usually will—**include the issue number**, parenthesized, at the end of the subject line. If you have multiple issues, they can be listed instead, comma-separated, at the end of the body. Not every commit has to have a Jira issue, especially if the changes are really not user-facing. Use your best judgement and avoid unnecessary overhead.

Of course, there are exceptions to every rule. If you're making a change to `big_possibly_poorly_named_function()` and need to mention it in the subject, it's okay to go long. Part of the value in these guidelines just comes from being reasonably consistent.

Here are some sample commit messages:

### Simple commit message

```
Prevent search engines from indexing the site (PROD-2627)
```

### Commit message with list of changes

```
Fix book sync issue in sync_lessons (PROD-2585, FOO-1234)
* Books have to be synced before lesson_books, obviously
* You don't get to just not sync the books at all
* Confirm that books are in sync in the other direction, too
* Fail fast if lessons or books fail to sync
* Helpful message if we know it's an FK error
```

### Commit message with detailed body

```
Load schools along with cohorts in student editor (PROD-2448)

Loading the student editor was slow because the page would do O(cohorts)
queries. Using the ORM properly to preload that data speeds up the
page load significantly.
```

## Commit Often, Perfect Later

Taken from this article the idea is to use the topic/personal branch and commit as much as possible. This allows to:

- Save your progress as you work on something large. Pushing to a remote this also allows to recover in the event something happens to local environment
- Easier to find out if some incremental change caused an issue. (`git bisect` helps with that, see tools below)

When done, rewrite history by squashing commits. Keep only the ones that are useful and group the ones that should be one commit. A commit that fixes a typo of a previous commit (within same work) should not be history. A good article about this topic and how it can be done. This also allows to rewrite and prepare the commit message(s) before a PR.

Keep formatting changes on separate commits and before doing any other change. This helps ignore those during a PR and easily see the change that happened.

If you work on a branch for a long time, amending and rebasing as you go, your commit date will not automatically update. Consider running a command like this to reset the commit date to the current date before you share or push your code:

```bash
git commit --amend --reset-author --no-edit
```
