---
name: graphify-setup
description: 'Checks for and safely installs the Graphify CLI and assistant integrations, then builds the initial graph.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Graphify, Setup, Knowledge Graph, CLI]
    category: setup
    related_skills: [graphify-map]
---

## Install
Run:
`npx skills add jericbas/skills --skill graphify-setup`

# Setup Graphify

**Trigger Command:** `/graphify-setup`

**Purpose:** Checks for and safely installs the Graphify CLI and assistant integrations.

## Instructions for the Agent

1. **Pre-Flight Check:** Scan the system or `package.json` to see if the `@sentropic/graphify` package is already installed.
2. **Interactive Execution (Installed):** If it is already installed, output a simple success message and halt to save context tokens.
3. **Interactive Execution (Missing):** If it is missing, explicitly ask the user for permission to run the global installation command: `npm install -g @sentropic/graphify`. Do not proceed without explicit human approval.
4. **Integration Setup:** Once the NPM package is installed, remind the user to run `graphify install` (or `graphify <platform> install`) to write the necessary assistant integrations (e.g., `CLAUDE.md`, `GEMINI.md`, or `AGENTS.md`).
5. **Initial Build:** Ask the user if they would like to build their first graph by running `/graphify .` (or `$graphify .` for Codex). Halt execution once complete.
