---
name: daily-standup
description: >-
  Scans yesterday's (or the most recent) git commits, today's commits, and current
  staged or uncommitted changes on the active branch (or specified branches) to
  generate a human-friendly daily standup update in intermediate English. Use when
  preparing for a daily standup, writing a daily Slack status, or recalling what
  you worked on yesterday and what is in progress today.
trigger: /standup
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Agile, Standup, Daily Update, Git, Team, Productivity]
    category: team
    related_skills: [sprint-retro-wins]
---

## Install
Run:
`npx skills add jericbas/skills --skill daily-standup`

# Daily Standup & Today's Task Generator

**Trigger Command:** `/standup`

**Purpose:** Checks what you accomplished yesterday (or on your last active commit day), what you have committed today, and what is currently in progress in your staged and uncommitted changes. Translates your git state into clear, human-friendly **intermediate English** (by default) for daily standup meetings and async status updates.

## Instructions for the Agent:

### Step 1: Resolve Author, Target Branch(es), and Time Window
1. **Author Detection:**
   * Run `git config user.name` and `git config user.email` to identify the current developer.
   * Filter commits matching either the user's configured name or email unless the user explicitly requests a team-wide scan (`--team`) or another author.
2. **Branch Selection (Current Branch by Default):**
   * **Default (No Branch Specified):** Use the currently checked-out branch (`HEAD` via `git branch --show-current`).
   * **Custom or Multiple Branches:** If the user specifies another branch or multiple branches (e.g., `/standup develop`, `/standup feat/auth feat/profile`, or `--all`), scan those branches and let git deduplicate shared commits by hash.
3. **Time Window & Smart Fallback for "Yesterday":**
   * **Today's Commits:** Scan commits by the user since midnight today (`--since="midnight"`).
   * **Yesterday's Commits:** Scan commits by the user from yesterday (`--since="yesterday 00:00" --until="today 00:00"`).
   * **Fallback to Last Active Commit Day:** If **0 commits** are found from yesterday (for example, on a Monday morning, after a holiday, or when resuming a branch), automatically fetch the user's last 3–5 commits on the target branch(es) (`git log <branch(es)> --no-merges --author="<user>" -n 5 --date=short`) and group those from the most recent active date as **"Yesterday / Last Active Day (<date>)"**.

### Step 2: Two-Pass Scan of Commits & Working Tree (Context-Safe)
1. **Pass 1 — Recent Commits (`git log --stat`):**
   * Collect commit messages and changed file stats (`--stat`) for both yesterday's (or last active day's) commits and today's commits.
   * For commits with vague messages (`"wip"`, `"fix"`, `"update"`, `"changes"`, `"refactor"`), run a concise diff (`git show <hash> --unified=1`) to understand the actual functional change without overloading context.
2. **Pass 2 — Staged & Uncommitted Changes (Today's In-Progress Work):**
   * Run `git status --short` to inspect the working tree.
   * If staged changes exist, inspect `git diff --cached --stat` and a concise diff (`git diff --cached --unified=1`, excluding lockfiles or generated files).
   * If unstaged modifications exist, inspect `git diff --stat` and a concise diff (`git diff --unified=1`, excluding lockfiles or generated files).
   * For untracked files (`??`), inspect their file paths (and briefly read new source files if needed) to see what new component, hook, test, or module is being started today.
   * Also check the active branch name (e.g., `feat/PROJ-42-checkout-validation`) for helpful ticket or feature context.

### Step 3: Synthesize into Human Updates (Intermediate English by Default)
1. **Intermediate English Default:**
   * Write all bullet points and talking points in **intermediate English** by default—using simple, clear, everyday words that are easy to read aloud and understand across an international team. Avoid heavy jargon or stiff corporate phrasing unless the user explicitly asks for a different level (e.g., beginner/simple, advanced/executive, or native casual).
2. **Focus on Outcomes & Current Momentum:**
   * **Yesterday (or Last Active Day):** Summarize completed commits into cohesive outcomes rather than listing raw file names or commit hashes.
   * **Today (Committed + In Progress):** Combine any commits made today with the current staged/uncommitted working tree changes to clearly describe:
     - What you have already finished today (if any commits exist today).
     - What you are actively building, fixing, or testing right now based on staged/uncommitted changes.
     - If there are no commits today and the working tree is completely clean, infer the logical next step from the most recent commit on the branch (or state that the branch work looks ready for PR/review).

### Step 4: Output Format (Chat-First)
Output directly in the chat response (do not create files in the repo unless requested). Structure the response as follows:

1. **Standup Scan Summary:**
   * A compact 1-line header: `**Branch(es):** <branch> | **Author:** <name> | **Working Tree:** <staged/unstaged summary>`
2. **📋 Daily Standup Notes (Copy-Paste Ready for Slack / Jira / Teams):**
   * **✅ Yesterday (or Last Active Day — `<date>`):** Short, clear 1-line bullet points of what was completed.
   * **🔨 Today (In Progress):** Short, clear 1-line bullet points covering today's commits plus active work detected in staged/uncommitted changes.
   * **🚧 Blockers / Follow-ups:** Default to `None` unless uncommitted changes clearly show unfinished TODOs, broken tests, or pending migrations worth mentioning.
3. **🗣️ Verbal Standup Talking Points (For the Meeting):**
   * A natural, first-person conversational script (2–4 sentences in **intermediate English**, starting with *"Yesterday I..."* and *"Today I'm working on..."*) that the developer can read aloud smoothly during the daily standup.
