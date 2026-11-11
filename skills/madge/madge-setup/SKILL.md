---
name: madge-setup
description: Configures Madge for dependency analysis by confirming global vs. npx execution and checking Graphviz system requirements. Use when setting up Madge for the first time or troubleshooting missing Graphviz SVG errors.
disable-model-invocation: true
---

# /madge-setup

## Instructions for the Agent:

1. Immediately ask the user if they want to install Madge globally (`npm install --global madge`) or run it dynamically via `npx madge`. Do not proceed until a preference is confirmed.
2. If the user wants to generate visual graphs (SVG, DOT, image formats), explicitly inform them that the `graphviz` package is required on their system.
3. Provide the correct Graphviz installation command based on their OS:
   - macOS: `brew install graphviz`
   - Ubuntu: `apt-get install graphviz`
4. Confirm successful setup and halt execution.
