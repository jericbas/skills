---
name: madge-setup
description: 'Safely sets up Madge for dependency visualization. Checks for global vs npx preference and Graphviz.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependencies, Madge, Setup, Architecture]
  category: ci
  related_skills: [madge-cli]
---
# /madge-setup

## Instructions for the Agent:

1. Immediately ask the user if they want to install Madge globally (`npm -g install madge`) or run it dynamically via `npx madge`. Do not proceed until a preference is confirmed.
2. If the user wants to generate visual graphs (SVG, DOT, image formats), explicitly inform them that the `graphviz` package is required on their system.
3. Provide the correct Graphviz installation command based on their OS:
   - macOS: `brew install graphviz`
   - Ubuntu: `apt-get install graphviz`
4. Confirm successful setup and halt execution.
