---
name: generate-retro-spec
description: Reverse-engineers legacy code into strict, DRY, SDD-compliant Markdown specifications.
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

**Purpose:** Interactively scans undocumented legacy code and reverse-engineers it into a structured, SDD-compliant Markdown specification while actively preventing cross-module architectural conflicts and redundant documentation.

## Instructions for the Agent:

1. **Step 1: Get Target Input Directory or File**
   * Ask the user: "Which specific directory or file path needs to be analyzed? (e.g., `src/legacy/utils/` or `src/components/Button.tsx`)"
   * **Wait for user input.** Do not proceed to the next step until a path is provided.
   * *Note: The Target Input can be a single file OR an entire directory. If it is a directory, analyze all child files within it to understand their collective purpose. If available, suggest using `/graphify` to identify relevant files for the target.*

2. **Step 2: Get Target Output Directory**
   * Ask the user: "Where should I save the generated `spec.md` file? (e.g., `./docs/specs/` to commit, or a private `./.local-specs/` folder?)"
   * **Wait for user input.** Do not proceed to the next step until a path is provided.

3. **Step 3: The Adjacency & Legacy Docs Check**
   * Ask the user: "Are there any existing, related specification files I should align with? OR, is there any existing partial documentation (like a legacy `README.md`) for this module? Provide their paths so I can link to them and avoid redundancy. If none, reply 'none'."
   * **Wait for user input.** Do not proceed until the user provides related paths or says "none."

4. **Step 4: Code Analysis & SDD Generation**
   * Read the code in the Target Input (including all child files if a directory was provided).
   * If the user provided adjacent files in Step 3, read them now. 
   * Untangle the logic and draft the new `spec.md` document. 
   * **You MUST adhere to the following Spec-Driven Development (SDD) Rules:**
     * **The "Source of Truth" Rule (Based on [Tom Preston-Werner's README-Driven Development](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)):** You must clearly define the core business intent and "Why" of the module before explaining the technical "How". The spec is the contract; the code is an implementation of that contract.
     * **The DRY Documentation Rule:** If the user provided an existing partial document (like an old README), DO NOT duplicate its content. Use markdown links (e.g., `[See Legacy Config Docs](./legacy-readme.md)`) to reference the existing info, and only document the missing logic or new constraints.
     * **Prioritize Human Reviewability:** Do not write a monolithic block of text. Use strict bullet points, clear inputs/outputs, and defined edge cases so a human can review it in under 60 seconds.
     * **Start Minimal:** Strip away irrelevant technical trivia or formatting quirks. Document the core constraints, state changes, and API contracts.

5. **Step 5: Execution**
   * Save the generated SDD document to the Target Output Directory provided in Step 2.
   * If any minor conflicts were detected and resolved during Step 4, briefly inform the user in your output message.
   * If the user chose a private/local folder, remind them to add it to their `.gitignore`.
