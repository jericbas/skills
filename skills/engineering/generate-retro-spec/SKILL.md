---
name: generate-retro-spec
description: Reverse-engineers legacy code into strict, DRY, SDD-compliant Markdown specifications using a root index and standardized child templates.
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Documentation, Spec-Driven, Reverse-Engineering, Architecture, SDD, Graphify]
---

## Install
Run:
`npx skills add jericbas/skills --skill generate-retro-spec`

# Trigger Command: /generate-retro-spec

**Purpose:** Interactively scans undocumented legacy code and reverse-engineers it into a structured, SDD-compliant Markdown specification. It uses a root `spec.md` as an index and generates standardized child files (`spec-[name].md`). It prioritizes reading a local `tmp/.retro-spec-config.json` file to bypass manual data entry, integrates `/graphify` for dependency mapping, and actively prevents cross-module architectural conflicts.

## Instructions for the Agent:

1. **Step 1: Configuration Pre-Flight Check**
   * Scan the repository root for a configuration file located at `tmp/.retro-spec-config.json`.
   * If the file exists, read the `targetInput` (code to scan) and `targetOutputDir` (where specs live). Acknowledge these paths to the user and skip to Step 3.
   * If the file does not exist, or if the necessary values are missing, proceed to Step 2.

2. **Step 2: Manual Target Inputs (Fallback)**
   * Ask the user: "Which specific directory or file path needs to be analyzed? (e.g., `src/legacy/utils/`)"
   * Wait for user input.
   * Ask the user: "What is the root specification directory where the index `spec.md` lives? (e.g., `./docs/specs/`)"
   * Wait for user input. Do not proceed until both paths are established.

3. **Step 3: The Adjacency, Legacy Docs & Graphify Check**
   * Ask the user: "Would you like me to scan the repository for existing, related specification files or partial documentation (like a legacy `README.md`)? Alternatively, you can provide their specific paths so I can align with them. If you want to skip this, reply 'none'."
   * **Graphify Integration:** Check if the `/graphify` skill is available. If yes, automatically suggest using it: "I see `/graphify` is available. Shall I use it to map out the dependencies and adjacent files for your target input to build better context?"
   * Wait for user input. If the user agrees, execute those actions before moving to Step 4.

4. **Step 4: Code Analysis & SDD Generation**
   * Read the code in the Target Input (including all child files if a directory).
   * Review `/graphify` output (if utilized) and read any adjacent files/docs identified in Step 3.
   * Determine a URL-safe, kebab-case name for the new specification based on the module (e.g., if analyzing a Button component, use `button-component`).
   * **Template Extraction:** Locate and read the official SDD template at [SDD-TEMPLATE.md](templates/SDD-TEMPLATE.md).
   * Draft the new specification document by strictly filling out the exact structure, headers, and bullet points defined in that template. Do not hallucinate new sections.

5. **Step 5: Execution & Root Linking**
   * Save the drafted document as `spec-[name].md` inside the established `targetOutputDir`.
   * Open the root `spec.md` file located in that same directory.
   * Append a markdown link to the newly created `spec-[name].md` inside the root `spec.md` file so it acts as an updated index.
   * Inform the user of completion, listing the files created/modified.
