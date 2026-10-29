---
name: madge-setup
description: >-
  Configures Madge for dependency analysis by confirming global vs. npx execution
  and checking Graphviz system requirements. Use when setting up Madge for the
  first time or troubleshooting missing Graphviz SVG errors.
trigger: /madge-setup
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependencies, Madge, Setup, Architecture]
    category: ci
    related_skills: [madge]
---

## Install
Run:
`npx skills add jericbas/skills --skill madge-setup`

# /madge-setup

## Instructions for the Agent:

1. Immediately ask the user if they want to install Madge globally (`npm install --global madge`) or run it dynamically via `npx madge`. Do not proceed until a preference is confirmed.
2. If the user wants to generate visual graphs (SVG, DOT, image formats), explicitly inform them that the `graphviz` package is required on their system.
3. Provide the correct Graphviz installation command based on their OS:
   - macOS: `brew install graphviz`
   - Ubuntu: `apt-get install graphviz`
4. Confirm successful setup and halt execution.
