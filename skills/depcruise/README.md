# Dependency Cruiser Skills

This directory contains AI agent skills for managing and running [dependency-cruiser](https://github.com/sverweij/dependency-cruiser), a tool that validates and visualizes dependencies between modules.

By enforcing strict namespaces and disabling auto-model invocation, these skills allow you to audit your architecture safely without burning through your agent's context window.

## Installation

You can install these skills directly into your project's `.skills` directory using the CLI:

```bash
# 1. Install the main orchestrator (Recommended entry point)
npx skills add jericbas/skills --skill depcruise

# 2. Install the setup wizard
npx skills add jericbas/skills --skill depcruise-setup

# 3. Install the CLI runner and validator
npx skills add jericbas/skills --skill depcruise-run
```

## The Command Suite

| Trigger Command | Purpose |
| :--- | :--- |
| `/depcruise` | **Meta-Skill:** The main entry point. Evaluates the workspace and automatically routes you to either setup or execution. |
| `/depcruise-setup` | Installs the tool (npm/npx), initializes `.dependency-cruiser.js`, and handles Graphviz setup warnings. |
| `/depcruise-run` | A comprehensive CLI runner to validate rules, generate HTML/SVG graphs, and track down orphans or circular dependencies. |

## Real-Life Workflow Example: Untangling a Spaghetti Module

To effectively use Dependency Cruiser as your architectural auditor, follow this workflow:

1. **Initialize the Suite:** Type `/depcruise`. 
   * **Result:** The AI notices you don't have a `.dependency-cruiser.js` file and seamlessly drops into the `/depcruise-setup` logic, running `npx depcruise --init` to scaffold your rules.
2. **Audit a Specific Feature:** Run `/depcruise-run I want to see the dependency graph for the auth module`. 
   * **Result:** The AI formulates the scoped command (`npx depcruise src/auth --output-type dot | dot -T svg > auth-graph.svg`), executes it, and generates a visual map of just that module.
3. **Validate Code Changes:** After refactoring, run `/depcruise-run validate the src directory`.
   * **Result:** The AI runs the standard check. If a rule is broken (e.g., a newly introduced circular dependency), the AI outputs the exact violation and halts, allowing you to fix the architecture before committing.
