---
name: test-failure-resolver
description: >-
  Investigates failing unit tests and routes the issue to the relevant developer
  using dependency graphs and git history context. Use when unit tests fail in CI
  or locally and the user wants to trace the root cause and recent file authors.
trigger: /resolve-test-failure
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Testing, Debugging, CI, Git]
    category: testing
    related_skills: [depcruise, madge]
---

## Install
Run:
`npx skills add jericbas/skills --skill test-failure-resolver`

# Test Failure Resolver

**Trigger Command:** `/resolve-test-failure`

## Instructions for the Agent
* Check `package.json` to see if tests exist.
* Run unit tests, or ask the user to provide the failed test file.
* If a test fails, use the `/depcruise` or `/madge` skills to map and check the dependencies of the failed unit test.
* Use `git log` or `git blame` only as context about recent changes. File authorship is not proof of cause, ownership, or availability.
* Summarize the evidence and likely context owners for human confirmation. Do not assign or route the issue to a developer without an explicit team ownership source or the user's direction, and keep the language non-blaming.
