# Specification: Generic Skills Lifecycle Protocol Skill (`skills-lifecycle`)

## 1. Intent & Context
Agent skill bloat degrades LLM context windows, wastes tokens, and harms tool-calling accuracy. While ecosystems like `skills.sh` simplify discovering skills, developers and agentic systems lack an active, standardized lifecycle tool to audit, prune, register, and retire skills.
This specification defines the `skills-lifecycle` skill for `jericbas/skills` (Engineering category). It provides an actionable, executable workflow for agents and developers to audit installed or developing skills against token/line budgets (<= 120 lines), prune conversational fluff upon ingestion, maintain a skill registry, and deprecate stale skills.

## 2. Core Contract & Interface
- **Skill Slug:** `skills-lifecycle`
- **Category:** `engineering` (`skills/engineering/skills-lifecycle/SKILL.md`)
- **Metadata Frontmatter:**
  ```yaml
  ---
  name: skills-lifecycle
  description: Audits, prunes, registers, and retires AI agent skills against token and line-budget limits (<= 120 lines). Use when adding a new skill, compacting bloated skills, or performing maintenance audits.
  disable-model-invocation: true
  ---
  ```
- **Line Count Constraint:** `SKILL.md` MUST strictly be <= 120 lines.

## 3. Core Operational Modes & Workflow
When invoked via `/skills-lifecycle`, the agent operates across three explicit modes:

1. **Mode 1: Ingestion & Compaction Pruning (`audit` / `compact`)**
   - **Input:** Target skill directory or `SKILL.md` file path.
   - **Line Budget Enforcement:** Evaluates total lines against the <= 120-line budget (flagging any file >150 lines as critically bloated).
   - **Pruning Heuristics:**
     - Strip conversational preambles, marketing narrative, chatty examples, and redundant ASCII diagrams.
     - Retain YAML frontmatter triggers, exact CLI commands and flags, input/output schemas, and concise checklists.
   - **Output:** Produces a pruned, compliant `SKILL.md` draft or a bulleted compaction diff.

2. **Mode 2: Vetting & Discovery Gate (`evaluate`)**
   - **Input:** Candidate skill name or package query.
   - **Gates:**
     - Runs `npx skills find [query]` to check install volume (>= 1,000 preferred) and verified author reputation.
     - Verifies deterministic trigger criteria and absence of external secret dependencies.

3. **Mode 3: Registry & Retirement Tracking (`track` / `retire`)**
   - **Input:** Project root or skills tracker file (default: `SKILLS_TRACKER.md` or local README index).
   - **Action:**
     - `track`: Scans local skills, records line count, designated agent owner/role, status (`Active`), and last-modified date.
     - `retire`: Safely uninstalls/removes target skill directory and marks entry as `Retired`.

## 4. Repository Integration & Files Affected
- **New Skill File:** `skills/engineering/skills-lifecycle/SKILL.md` (<= 120 lines).
- **Metadata Automation:** Run `npm run generate:skills-sh` (or `node tools/skills-sh-json.js`) to regenerate `skills.sh.json`.
- **Repository Index:** Update `README.md` under `## Skills` -> `Engineering` to include `[Skills Lifecycle](skills/engineering/skills-lifecycle/SKILL.md)`.
- **Testing & Validation:** Execute `npm run test:skills` (`node --test tools/skills-sh-json.test.js`).

## 5. Definition of Done
1. `skills/engineering/skills-lifecycle/SKILL.md` created with valid frontmatter, actionable modes, and strictly <= 120 lines.
2. `skills.sh.json` updated with `skills-lifecycle` in the `Engineering` grouping.
3. `README.md` updated with link to the new skill under `Engineering`.
4. Automated tests pass (`npm run test:skills`).
5. Implemented in an isolated git worktree, committed following Conventional Commits (`feat(skills): add skills-lifecycle protocol skill`), and verified before merging to `main`.
