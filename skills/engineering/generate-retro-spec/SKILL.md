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
   * If the file exists, read the `targetOutputDir` (where specs live) and acknowledge it to the user. Do not treat `targetInput` as persisted config state; it is expected to be provided live for each run.
   * If the file does not exist, or if `targetOutputDir` is missing, proceed to Step 2.
   * If the user must provide the `targetInput`, ask for it explicitly and treat it as required before continuing.
   * Validate the live `targetInput` path before continuing: if it does not exist, ask again and do not proceed until it is valid.
   * If `targetOutputDir` does not exist, create it before continuing.
   * If the root `spec.md` file is missing in `targetOutputDir`, create a minimal index file before appending new links.

2. **Step 2: Manual Target Inputs (Fallback)**
   * Ask the user: "Which specific directory or file path needs to be analyzed? (e.g., `src/legacy/utils/`)"
   * Wait for user input and use it as the live `targetInput` for this run.
   * Ask the user: "What is the root specification directory where the index `spec.md` lives? (e.g., `./docs/specs/`)"
   * Wait for user input and store it as `targetOutputDir`.
   * Save only `targetOutputDir` to `tmp/.retro-spec-config.json` in the repository root so the workflow can reuse it on future runs.
   * Do not save `targetInput` in the config file; keep it as a runtime input for the current analysis.
   * Recommended config shape: `{ "targetOutputDir": "./docs/specs/" }` plus optional metadata such as `lastUpdated` if needed.
   * Do not proceed until both values are established.

3. **Step 3: The Adjacency, Legacy Docs & Graphify Check**
   * Automatically scan the repository for existing, related specification files or partial documentation (like a legacy `README.md`), and also use the live `targetInput` to identify adjacent files.
   * **Graphify Integration:** If `/graphify` is available, run it in the same step to map dependencies and adjacent files for the target input so the analysis has better context.
   * If no related docs are found, or the user provides `none`, proceed without them. Do not pause for a separate confirmation; use both checks together.
   * Scope guard: stay within the target module and immediate dependency surface. Do not broaden the spec into unrelated subsystems unless the code path explicitly requires it.

4. **Step 4: Code Analysis & SDD Generation**
   * Read the code in the Target Input (including all child files if a directory).
   * Review `/graphify` output (if utilized) and read any adjacent files/docs identified in Step 3.
   * Determine a URL-safe, kebab-case name for the new specification based on the module (e.g., if analyzing a Button component, use `button-component`).
   * If a spec file with that name already exists, append a numeric suffix such as `-2`, `-3`, etc., instead of overwriting the original.
   * **Template Extraction:** Locate and read the official SDD template at [SDD-TEMPLATE.md](templates/SDD-TEMPLATE.md).
      * Draft the new specification document by strictly filling out the exact structure, headers, and bullet points defined in that template. Do not hallucinate new sections.
      * Write a `Plain-language summary` (2–4 short sentences) at the top of the spec that explains the module to non-technical readers.
      * Add an `Examples (input → output)` section with at least one concrete example showing expected behavior in everyday language.
      * Include a `Technical specification (structured)` section that contains the original SDD headings (Intent & Context, The Core Contract, Strict Constraints & Rules, Critical Dependencies, Edge Cases & Error Handling, Definition of Done). For each heading, provide a 1–2 sentence plain-language explanation followed by a `Technical notes` block with exact schemas, error codes, and implementation details.
      * Separate verified facts from inferred behavior clearly so unknowns are called out instead of silently guessed.

5. **Step 5: Execution & Root Linking**
   * Save the drafted document as `spec-[name].md` inside the established `targetOutputDir`.
   * Open the root `spec.md` file located in that same directory.
   * Append a markdown link to the newly created `spec-[name].md` inside the root `spec.md` file so it acts as an updated index.
      * Ensure the saved `spec-[name].md` includes the `Plain-language summary` and `Examples` sections so non-technical stakeholders can read it easily.
      * Ensure the saved `spec-[name].md` also includes the `Technical specification (structured)` section so engineers have precise, testable details.
      * The output contract is: one newly created spec file, one root index updated with a markdown link, and a completion summary that includes the plain-language summary.
      * Inform the user of completion, listing the files created/modified and include the plain-language summary in the completion message.
