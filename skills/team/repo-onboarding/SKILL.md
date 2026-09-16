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

**Instructions for the Agent:**
When the user types `/onboard`, output a welcoming, easy-to-read guide following these exact steps. Use intermediate English. If you encounter complex technical terms, save them for the Glossary at the end.

1. **Step 1: Context Gathering**
   * Silently scan the repository's root configuration files (`README.md`, `package.json`, `docker-compose.yml`, etc.) to understand the tech stack and purpose.
   * If the user does not specify where the onboarding guide should live, create a file named `ONBOARDING.md` in the repository root and write the full onboarding guide there.
   * If `ONBOARDING.md` already exists, update that file in place instead of creating a duplicate.
   * If the user specifies another path or filename, follow that location instead of the root default.

2. **Step 2: The Application Idea**
   * Write a simple, one-paragraph explanation of what this application does and who it is for.

3. **Step 3: The Architecture Flowchart**
   * Explain the tech stack simply. Provide a text-based flowchart showing how the system is connected.
   * *Example Format:*
     [ User Interface ] ---> [ Backend Server ] ---> [ Database / Cloud ]

4. **Step 4: The Business Logic Flowchart**
   * Provide a text-based flowchart showing how a user flows through the main feature of the app.
   * *Example Format:*
     [ Login ] ---> [ View Dashboard ] ---> [ Create Item ] ---> [ Save to System ]

5. **Step 5: The Daily Workflow & Prerequisites**
   * List any dependencies the user needs to install.
   * Explain the daily development process using a simple numbered list (e.g., Pull code, create branch, run tests, open PR).

6. **Step 6: Areas of Uncertainty**
   * Explicitly list any configuration, architecture, or business logic that you could not find or do not fully understand from your scan.
   * Ask the user to clarify these specific points so you can learn.

7. **Step 7: The Glossary (Jargon Buster)**
   * Provide a table defining any difficult words or acronyms used in the explanation above.
   * *Required Format:*
     | Term | Simple Meaning |
     | ------ | ------ |
     | **Repository** | The main folder where all our code is stored. |

8. **Step 8: Optional File-by-File Documentation Pass**
   * After the main onboarding guide has been created or updated, ask the user: "Would you like me to create short docs for each important source file (excluding unit tests) to explain its purpose, dependencies, and business logic?"
   * If the answer is yes, create small documentation notes for the most important non-test files only, focusing on what each file does, what it depends on, and how it contributes to the business flow.
   * Avoid writing documentation for unit test files unless the user explicitly asks for it.
   * Keep each note short and practical, ideally in a simple format like:
     - File: `path/to/file`
     - Purpose: What it does
     - Depends on: Key inputs or collaborators
     - Business logic: How it supports the main feature
   * Prefer the most relevant production files over exhaustive coverage.

9. **Next Steps:** 
   * End the message by asking the new programmer: "Which part of the system would you like to explore first?"
