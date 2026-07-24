---
name: depcruise-orchestrator
description: 'Meta-skill that acts as the entry point for Dependency Cruiser, routing the user to either setup or execution.'
trigger: /depcruise
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependency Cruiser, Architecture, Meta-Skill]
    category: architecture
    related_skills: [depcruise-setup, depcruise-run]
---

## Install
Run:
`npx skills add jericbas/skills --skill depcruise`

# /depcruise

The user wants to work with `dependency-cruiser` but may need guidance on whether to install it or run it.

## Instructions for the Agent:

1. **Check Project State:** Briefly check if `dependency-cruiser` is already installed in the `package.json` or if a `.dependency-cruiser.js` config file exists.
2. **Route to Setup:** If the tool is NOT configured, inform the user and automatically trigger the logic from `/depcruise-setup` to get them started. 
3. **Route to Run:** If the tool IS configured, ask them what they want to analyze today (e.g., "Do you want to validate rules, find circular dependencies, or generate a visual graph?") and transition to the `/depcruise-run` logic based on their answer.
