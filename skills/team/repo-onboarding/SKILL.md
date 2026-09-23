---
name: repo-onboarding
description: Educates new programmers on any application's purpose, workflow, and architecture using simple English, text flowcharts, and clear uncertainty flags.
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Onboarding, Documentation, Architecture, Team]
---

## Install
Run:
`npx skills add jericbas/skills --skill repo-onboarding`

**Trigger Command:** `/onboard`

**Purpose:** Welcomes a new programmer and simply explains the application, workflow, architecture, and common terms without confusing technical jargon, while clearly stating what information is missing.

**Optional Graphify Usage:**
* If the repository is complex or the architecture is hard to explain from file names alone, use `/graphify` when possible to map the project structure, important modules, and feature relationships before writing the onboarding guide.
* Use `/graphify` as a helpful supplement, not a requirement for every repo.

**Instructions for the Agent:**
When the user types `/onboard`, output a welcoming, easy-to-read guide following these exact steps. Use intermediate English. If you encounter complex technical terms, save them for the Glossary at the end.

1. **Step 1: Context Gathering**
   * Silently scan the repository's root configuration files (`README.md`, `package.json`, `docker-compose.yml`, etc.) to understand the tech stack and purpose.
   * If the user does not specify where the onboarding guide should live, create a file named `ONBOARDING.md` in the repository root and write the full onboarding guide there.
   * If `ONBOARDING.md` already exists, update that file in place instead of creating a duplicate.
   * If the user specifies another path or filename, follow that location instead of the root default.
   * If the app is large or has multiple features, create a folder named `onboarding/` next to the main onboarding guide for feature-specific notes and link them from the root onboarding guide.

2. **Step 2: The Application Idea**
   * Write a simple, one-paragraph explanation of what this application does and who it is for.
   * Clearly state whether the guide is for the whole repository or for a specific feature area selected by the user.

3. **Step 3: The Architecture Flowchart**
   * Explain the tech stack simply. Provide a text-based flowchart showing how the system is connected.
   * *Example Format:*
     [ User Interface ] ---> [ Backend Server ] ---> [ Database / Cloud ]

4. **Step 4: Business Logic by Screen or Feature**
   * Provide the main user journey in simple text flowchart form.
   * *Example Format:*
     [ Login ] ---> [ View Dashboard ] ---> [ Create Item ] ---> [ Save to System ]
   * If the app has multiple screens or features, create a separate business flow for each major area, such as `Authentication`, `Dashboard`, `Billing`, `Settings`, or `Reports`.
   * For each screen or feature, explain:
     - What the screen or feature is for
     - The main user actions
     - Key business rules or decisions
     - Important data or API dependencies
   * If there are many screens or features, create separate markdown files in the same `onboarding/` folder as the main `ONBOARDING.md` and add links from the root guide.
   * *Example link format in the main guide:*
     - [Authentication Flow](onboarding/authentication.md)
     - [Dashboard Flow](onboarding/dashboard.md)
   * Each linked feature doc should stay focused on one feature or screen and should include:
     - a simple text flowchart for the user journey
     - a short business logic summary explaining what rules or decisions drive the feature
     - the main user actions and important states
     - key data, API, or service dependencies
     - a short section titled "Other areas to explore later" for anything not covered in this guide
   * The feature doc should be written in plain, easy-to-follow language so a new programmer can understand the feature without reading the whole repository.

5. **Step 5: Scope and Learning Path**
   * Decide whether this onboarding is for the full repository or only a specific feature requested by the user.
   * If the onboarding is feature-specific, clearly label the scope at the top of the guide and say that other parts of the repo remain available for later exploration.
   * Add a small section like:
     - Scope: Full repository / Feature focus
     - Planned next areas: Other features to learn later
   * If the user wants repo-wide onboarding later, leave space for those sections so it can expand without rewriting the whole guide.

6. **Step 6: The Daily Workflow & Prerequisites**
   * List any dependencies the user needs to install.
   * Explain the daily development process using a simple numbered list (e.g., Pull code, create branch, run tests, open PR).

7. **Step 7: Areas of Uncertainty**
   * Explicitly list any configuration, architecture, or business logic that you could not find or do not fully understand from your scan.
   * Ask the user to clarify these specific points so you can learn.

8. **Step 8: The Glossary (Jargon Buster)**
   * Provide a table defining any difficult words or acronyms used in the explanation above.
   * *Required Format:*
     | Term | Simple Meaning |
     | ------ | ------ |
     | **Repository** | The main folder where all our code is stored. |

9. **Step 9: Optional Documentation Pass**
   * After the main onboarding guide has been created or updated, ask the user: "Would you like me to create short docs for each important source file (excluding unit tests) to explain its purpose, dependencies, and business logic?"
   * If the answer is yes, create small documentation notes for the most important non-test files only, focusing on what each file does, what it depends on, and how it contributes to the business flow.
   * Avoid writing documentation for unit test files unless the user explicitly asks for it.
   * Keep each note short and practical, ideally in a simple format like:
     - File: `path/to/file`
     - Purpose: What it does
     - Depends on: Key inputs or collaborators
     - Business logic: How it supports the main feature
   * Prefer the most relevant production files over exhaustive coverage.
   * If the repo is large or the app has many screens/features, prefer feature-level markdown docs linked from the onboarding guide over a giant single document.

10. **Next Steps:** 
   * End the message by asking the new programmer: "Which part of the system would you like to explore first?"
