---
name: graphify-review
description: 'Checks the blast radius, impacted communities, and test gaps of changed files before a commit.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Graphify, Review, Impact, Git]
    category: ci
    related_skills: [graphify-patch]
---

# Review Graphify Impact

**Trigger Command:** `/graphify-review`

**Purpose:** Prevent breaking changes by explicitly checking the blast radius before commits.

## Instructions for the Agent

1. **Identify Changes:** Find the currently staged or modified files in the repository.
2. **Review Delta:** Run `graphify review-delta` against the changed files.
3. **Review Analysis:** Run `graphify review-analysis` to identify potential test gaps.
4. **Output Context:** Provide a concise list of impacted communities and missing test coverage.
5. **Halt:** Stop execution before any git commit is made, allowing the user to review the impact.
