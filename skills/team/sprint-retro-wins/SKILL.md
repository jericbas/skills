---
name: sprint-retro-wins
description: >-
  Scans git commits from the last 2 weeks on a target branch (or multiple branches)
  and generates human-friendly "What went well in this sprint" talking points and
  retro board notes. Use when preparing for a sprint retrospective or summarizing
  recent personal or team accomplishments.
trigger: /retro-wins
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Agile, Retrospective, Sprint, Git, Team, Productivity]
    category: team
    related_skills: [daily-standup]
---

## Install
Run:
`npx skills add jericbas/skills --skill sprint-retro-wins`

# Sprint Retro "What Went Well" Generator

**Trigger Command:** `/retro-wins`

**Purpose:** Scans a developer's git commits over a 2-week sprint window on the primary branch (or user-specified branches) and translates technical commit history into natural, human-friendly text in **intermediate English** (by default) answering **"What went well in this sprint?"** for sprint retrospectives.

## Instructions for the Agent:

### Step 1: Resolve Author, Target Branch(es), and Sprint Window
1. **Sprint Time Window:**
   * Default to the last **2 weeks** (`--since="2 weeks ago"`).
   * If the user passes a custom timeframe inline (e.g., `/retro-wins 1 week`, `/retro-wins 10 days`, or explicit dates like `2026-10-01..2026-10-15`), use that window instead.
2. **Author Detection:**
   * Run `git config user.name` and `git config user.email` to identify the current developer.
   * Filter commits matching either the user's configured name or email unless the user explicitly requests a whole-team summary (e.g., `--team`) or specifies another author.
3. **Branch Selection (One Branch by Default):**
   * **Default (No Branch Specified):** Scan a single branch by resolving the repository's primary integration branch in this priority order:
     1. `develop` (or `origin/develop` if local `develop` does not exist)
     2. `main` (or `origin/main`)
     3. `master` (or `origin/master`)
     4. Fall back to the currently checked-out branch (`HEAD`) if none of the above exist.
   * **Multiple or Custom Branches:** If the user specifies one or more branch names (e.g., `/retro-wins feat/checkout feat/auth` or `--all`), pass those branches directly to `git log` so git automatically deduplicates shared commits by hash.
4. **Zero-Commit Fallback:**
   * If **0 commits** by the user are found on the default branch (`develop`/`main`) within the sprint window (for example, because their work is still on unmerged feature branches), inform the user clearly and ask if they would like to scan their currently checked-out branch (`HEAD`) or all local branches (`--branches`) instead.

### Step 2: Two-Pass Commit Scan (Context-Safe)
To keep context usage small and accurate:
1. **Pass 1 — Commit Messages & Changed File Paths:**
   * Run `git log <branch(es)> --no-merges --since="<window>" --author="<user>" --stat --date=short --pretty=format:"COMMIT:%h | %ad | %s %b"` to gather commit messages along with the files touched.
2. **Pass 2 — Targeted Diff Inspection for Vague Commits Only:**
   * Identify commits with vague, generic, or cryptic messages (e.g., `"wip"`, `"fix"`, `"update"`, `"address PR comments"`, `"refactor"`, `"cleanup"`) where the commit message and file names alone do not explain what was accomplished.
   * Only for those ambiguous commits, inspect a concise diff (`git show <hash> --unified=1` or excluding lockfiles/generated assets) to determine the real functional or engineering change.
   * Do **not** run full diffs on commits whose messages and `--stat` file paths already clearly explain the change.

### Step 3: Synthesize into Human "What Went Well" Themes
1. **Consolidate & Filter Noise:**
   * Merge incremental commits that belong to the same feature or bug fix into a single cohesive accomplishment instead of listing commit-by-commit.
   * Ignore trivial noise (formatting-only commits, typo fixes, branch merges) unless they were part of a meaningful cleanup effort.
2. **Translate Code into Value (Intermediate English by Default):**
   * Use **intermediate English** by default: write in clear, simple, everyday sentences that are easy to read aloud and understand in an international team—avoiding stiff corporate buzzwords, overly complex vocabulary, or dense technical jargon unless the user explicitly requests a different language level (e.g., beginner/basic, advanced/executive, or native casual).
   * Rewrite technical commit logs into natural, human language that highlights **outcomes and impact** (e.g., instead of *"Updated `useAuth.ts` and `LoginModal.tsx` null check"*, write *"Fixed a login crash and made sign-in more reliable"*).
3. **Group by Outcome Theme:**
   * Organize accomplishments into the following categories (omit any category that has no items):
     * **🚀 Features & Product Delivery:** New user-facing functionality, screens, APIs, or workflows shipped.
     * **🛡️ Bug Fixes & Stability:** Resolved bugs, edge cases handled, error handling, and test coverage improvements.
     * **🧹 Refactoring, Tech Debt & DX:** Code simplification, performance optimizations, dependency updates, or developer tooling wins.

### Step 4: Output Format (Chat-First)
Output the result directly in the chat response (do not create or modify files in the repository unless the user explicitly asks to save the report). Structure the response as follows:

1. **Sprint Scan Summary:**
   * A single compact header line: `**Branch(es):** <branch> | **Author:** <name/email> | **Window:** <since> → <now> (<N> commits analyzed)`
2. **📋 Retro Board Sticky Notes (Copy-Paste Ready):**
   * Short, punchy 1-line bullet points grouped under the outcome themes (`Features & Product Delivery`, `Bug Fixes & Stability`, `Refactoring, Tech Debt & DX`).
   * Written so the user can copy-paste individual bullets directly onto Miro, FigJam, Jira, Retrium, or Slack retro boards under **"What went well?"**.
3. **🗣️ Verbal Talking Points (For the Retro Meeting):**
   * A natural, conversational first-person summary (*"I..."* by default, or *"We..."* if `--team` was used) in 1–2 short paragraphs written in **intermediate English** (unless another level is requested) so the developer can read it aloud comfortably when sharing what went well this sprint.

