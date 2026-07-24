---
name: graphify-agents
description: 'Parses local CLI transcripts and accurately attributes work packages and commits to specific AI sessions.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Graphify, Analytics, Agents, Tracking]
    category: analytics
    related_skills: []
---

## Install
Run:
`npx skills add jericbas/skills --skill graphify-agents`

# Track Agent Stats

**Trigger Command:** `/graphify-agents`

**Purpose:** Accurately attribute work packages to AI sessions locally without network telemetry.

## Instructions for the Agent

1. **Locate Transcripts:** Identify the directory holding agent terminal transcripts.
2. **Run Stats:** Execute `graphify agent-stats` against the transcript files.
3. **Output Summary:** Print the parsed token usage, time spent, and attributed commits for the session.
4. **Halt:** Stop execution immediately after providing the report.
