---
name: test-failure-resolver
description: Investigates failing tests and routes the issue to the right developer using dependency and history context.
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
* Use `git log` or `git blame` to check who was the last person to touch those specific files.
* Assign the issue back to the developer who made the recent changes, as they have the freshest context, ensuring the tone does not assign blame.
