---
name: madge-cli
description: 'Comprehensive wrapper for Madge CLI. Detects circular dependencies, orphans, leaves, and generates visual dependency graphs.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependencies, Madge, CLI, Graph, Circular]
  category: ci
  related_skills: [madge-setup]
---

## Install
Run:
`npx skills add jericbas/skills --skill madge`

# /madge

## Instructions for the Agent:

1. Determine the user's execution environment. Ask if they are using `npx madge` or a globally installed `madge` command if it is not already known. If Madge is not installed or not configured for the project, direct the user to run `/madge-setup` first.
2. Ask the user which specific CLI analysis they want to perform on their target file or directory. Offer the following capabilities:
   - **List Dependencies**: Standard dependency tree listing.
   - **Circular Dependencies**: Detect circular loops using `--circular`.
   - **Orphans**: Find unused modules using `--orphans`.
   - **Leaves**: Find modules with no dependencies using `--leaves`.
   - **Dependents**: Find what depends on a specific module using `--depends <module>`.
   - **Visual Graph**: Generate a visual representation using `--image graph.svg` (requires Graphviz).
3. Formulate the exact Madge command based on their choice and the target path.
4. Execute the command (or provide the command for the user to execute) and summarize the terminal output directly in the chat.
5. If the user specifies `--image` and Graphviz is missing (resulting in an EPIPE error), direct them to run `/madge-setup` to install system dependencies.
