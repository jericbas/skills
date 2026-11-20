---
name: skills-lifecycle
description: Audits, prunes, registers, and retires AI agent skills against token and line-budget limits (<= 120 lines). Use when adding a new skill, compacting bloated skills, or performing maintenance audits.
---

# Trigger Command: /skills-lifecycle

**Purpose:** Standardizes the acquisition, evaluation, pruning, registration, and retirement of AI agent skills across repositories and workspaces. It enforces strict token economy by keeping skills focused, modular, and within a <= 120-line budget to prevent context window bloat and attention degradation.

## Strict Rule: User Confirmation Required
Before making any changes to files (overwriting, editing, or compacting) or deleting skills, always ask the user for confirmation first with the proposed change or target path, and proceed only after approval.

## Instructions for the Agent:

When executing the skills lifecycle protocol, select the appropriate operational mode:

### 1. Mode 1: Ingestion & Compaction Pruning (`audit` / `compact`)
Use when evaluating a newly installed skill or compacting an existing one.
1. **Line Budget Verification:**
   - Measure total line count of the target `SKILL.md`.
   - **Target Budget:** <= 120 lines.
   - **Critical Bloat Ceiling:** If > 150 lines, compaction is immediately mandatory.
2. **Pruning Rules:**
   - **Strip:** Conversational intros, motivational prose, marketing fluff, multi-paragraph tutorials, verbose ASCII art, and repetitive code samples.
   - **Retain:** YAML frontmatter triggers/descriptions, exact CLI commands and argument flags, input/output contracts, and concise checklists.
3. **Execution:**
   - Generate a compact draft `SKILL.md` that preserves all functional capabilities under 120 lines.
   - Present the proposed diff to the user and ask for confirmation before applying any changes to the file.

### 2. Mode 2: Discovery & Vetting Gate (`evaluate`)
Use prior to installing community skills to verify quality and safety.
1. **Search & Evaluate:**
   ```bash
   npx skills find [query] [--owner <owner>]
   ```
2. **Vetting Criteria:**
   - **Adoption:** Prefer packages with >= 1,000 installs.
   - **Author Reputation:** Prioritize official or established maintainers (e.g., `vercel-labs`, `anthropics`, `microsoft`).
   - **Safety & Scope:** Ensure the skill defines deterministic triggers, does not require unexpected external secrets, and adheres to modular boundaries.

### 3. Mode 3: Registry & Allocation (`track`)
Use after installing or updating a skill to maintain visibility.
1. **Tracker Entry:**
   - Verify or create `SKILLS_TRACKER.md` (or workspace index) in the repository root.
   - Record the skill in the tracking table:
     ```markdown
     | Skill Name | Category | Primary Owner / Agent | Line Count | Date Added | Status |
     | :--- | :--- | :--- | :--- | :--- | :--- |
     | [skill-name] | [category] | [role/agent] | [lines] | YYYY-MM-DD | Active |
     ```

### 4. Mode 4: Deprecation & Retirement (`retire`)
Use when a skill is superseded, redundant, or unused.
1. **Confirmation & Removal:**
   - Ask the user for confirmation first before removing any skill.
   - Uninstall through the CLI (works on every platform):
     ```bash
     npx skills remove [skill-name]
     ```
   - If the skill was added by hand, delete its directory instead:
     ```bash
     # Linux / macOS (POSIX)
     rm -rf [path-to-skill]
     ```
     ```powershell
     # Windows (PowerShell)
     Remove-Item -Recurse -Force "[path-to-skill]"
     ```
2. **Update Tracker:**
   - Set status in `SKILLS_TRACKER.md` to `Retired` with date and reason.
3. **Regenerate Index:**
   - If managing a skill catalog (e.g. `skills.sh`), regenerate index configs to remove dead references.
