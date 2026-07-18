# Test Failure Resolver

**Trigger Command:** `/resolve-test-failure`
**Purpose:** Tracks down test failures using a visualizer and version control to bypass finger-pointing and route the issue to the person with the freshest context.

## Instructions for the Agent
* Check `package.json` to see if tests exist.
* Run unit tests, or ask the user to provide the failed test file.
* If a test fails, use `npx depcruise` or `npx madge` to map and check the dependencies of the failed unit test.
* Use `git log` or `git blame` to check who was the last person to touch those specific files.
* Assign the issue back to the developer who made the recent changes, as they have the freshest context, ensuring the tone does not assign blame.
