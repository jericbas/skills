# jericbas/skills

This is a personal repository used to codify my engineering workflows into reusable AI agent skills.

## The Strategy: Sprint-Sized Skills

Most AI agents struggle with context limits. If you feed an LLM a massive task with too many details, it hits a context cut-off and loses track of the goal. To solve this, this repository treats AI skills like tasks in an Agile sprint: as small, specific, and particular as possible.

## The Skills List

| Skill | File Name | Description |
| :--- | :--- | :--- |
| **Prop Drilling Detector** | `detect-prop-drilling.md` | Uses `react-docgen` to extract React component props into a structured JSON file, preventing the AI agent from wasting context window tokens on raw logic. |
| **Declarative Analyzer** | `react-declarative-analyzer.md` | Scans target React files strictly for imperative programming patterns like manual DOM manipulations and provides declarative code refactors. |
| **Test Failure Resolver** | `test-failure-resolver.md` | Tracks down test failures using a visualizer like `depcruise` or `madge` and version control to bypass finger-pointing and route the issue to the person with the freshest context. |

## CLI Installation Instructions

To ensure users can easily pull these skills down via CLI, use the following command:

`npx skills@latest add jericbas/skills` 


`npx skills@latest add jericbas/skills -a github-copilot`

`npx skills@latest add jericbas/skills -a claude-code`
