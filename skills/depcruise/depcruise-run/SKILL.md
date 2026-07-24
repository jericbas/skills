---
name: depcruise-run
description: 'Comprehensive CLI wrapper for dependency-cruiser to validate rules, find circular dependencies, and generate graphs.'
trigger: /depcruise-run
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependency Cruiser, Architecture, Validation, CLI, Graphing]
    category: architecture
    related_skills: [depcruise, depcruise-setup]
---

## Install
Run:
`npx skills add jericbas/skills --skill depcruise-run`

# /depcruise-run

The user wants to execute `dependency-cruiser` CLI commands to analyze their codebase.

## Instructions for the Agent:

Act as a CLI wrapper for `dependency-cruiser`. Parse the user's request to execute the correct flags. Use `npx depcruise` (or their preferred local binary).

### Core Capabilities:

1. **Standard Validation:** - Run `npx depcruise src` to validate the codebase against the rules defined in `.dependency-cruiser.js`.
   - Use `--output-type err-long` if the user wants detailed explanations of rule violations.
2. **Targeted Checks (Orphans & Circular):**
   - Focus the scan if the user is looking for specific smells. Example: `npx depcruise src --include-only "^src" --validate` 
3. **Graph Generation (Visuals):**
   - If the user wants a visual dependency graph, pipe the output to Graphviz.
   - SVG Example: `npx depcruise src --include-only "^src" --output-type dot | dot -T svg > dependency-graph.svg`
   - HTML Example: `npx depcruise src --include-only "^src" --output-type html > dependency-report.html`
4. **Focused Scoping:**
   - If the codebase is large, aggressively use the `--focus`, `--include-only`, or `--exclude` flags to limit the context window and the graph size based on the user's specific feature area.

**Execution:** Formulate the correct CLI command based on the user's request, explicitly show it to them, and execute it upon approval. Summarize the output concisely.
