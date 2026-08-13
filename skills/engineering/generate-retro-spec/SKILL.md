---
name: generate-retro-spec
description: Reverse-engineers legacy code into strict, conflict-free, SDD-compliant Markdown specifications.
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Documentation, Spec-Driven, Reverse-Engineering, Architecture, SDD]
---

## Install
Run:
`npx skills add jericbas/skills --skill generate-retro-spec`

# Trigger Command: /generate-retro-spec

**Purpose:** Interactively scans undocumented legacy code and reverse-engineers it into a structured, SDD-compliant Markdown specification while actively preventing cross-module architectural conflicts.

## Instructions for the Agent:

1. **Step 1: Get Target Input Directory**
   * Ask the user: "Which specific directory or file path needs to be analyzed? (e.g., `src/legacy/utils/`)"
   * **Wait for user input.** Do not proceed to the next step until a path is provided.

2. **Step 2: Get Target Output Directory**
   * Ask the user: "Where should I save the generated `spec.md` file? (e.g., `./docs/specs/` to commit, or a private `./.local-specs/` folder?)"
   * **Wait for user input.** Do not proceed to the next step until a path is provided.

3. **Step 3: The Adjacency Check (Preventing Conflicts)**
   * Ask the user: "Are there any existing, related specification files (e.g., an existing `auth.spec.md` or `database.md`) that this new module interacts with? If yes, please provide their paths so I can align the new spec and prevent architectural conflicts. If none, reply 'none'."
   * **Wait for user input.** Do not proceed until the user provides related paths or says "none."

4. **Step 4: Code Analysis & SDD Generation**
   * Read the code in the Target Input Directory.
   * If the user provided adjacent specs in Step 3, read them now. Ensure your new generated rules **do not contradict** the rules established in the adjacent specs.
   * Untangle the logic and draft the new `spec.md` document. 
   * **You MUST adhere to the following Spec-Driven Development (SDD) Rules:**
     * **The "Source of Truth" Rule (Based on [Tom Preston-Werner's README-Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)):** You must clearly define the core business intent and "Why" of the module before explaining the technical "How". In SDD, the specification is the absolute contract; the code is merely an implementation of that contract. Your generated spec must reflect the intended behavior, not just summarize the existing code syntax.
     * **Prioritize Human Reviewability:** Do not write a monolithic block of text. Use strict bullet points, clear inputs/outputs, and defined edge cases so a human can review it in under 60 seconds.
     * **Start Minimal:** Strip away irrelevant technical trivia or formatting quirks. Document the core constraints, state changes, and API contracts.

5. **Step 5: Execution**
   * Save the generated SDD document to the Target Output Directory provided in Step 2.
   * If any minor conflicts were detected and resolved during Step 4, briefly inform the user in your output message.
   * If the user chose a private/local folder, remind them to add it to their `.gitignore`.
