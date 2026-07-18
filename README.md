# jericbas/skills

This is a personal repository used to codify my engineering workflows into reusable AI agent skills.

## The Strategy: Sprint-Sized Skills

Most AI agents struggle with context limits. If you feed an LLM a massive task with too many details, it hits a context cut-off and loses track of the goal. To solve this, this repository treats AI skills like tasks in an Agile sprint: as small, specific, and particular as possible.

## The Skills List



| Skill | Location | Description |
| :--- | :--- | :--- |
| **Prop Drilling Detector** | `skills/react/detect-prop-drilling/SKILL.md` | Analyzes React component trees to identify props passed through multiple layers without being used, and suggests Context API or composition-based refactors. |
| **React Declarative Analyzer** | `skills/react/react-declarative-analyzer/SKILL.md` | Scans React components for imperative patterns such as manual DOM work or unnecessary effects and recommends declarative state-driven alternatives. |
| **React SRP/DRY Analyzer** | `skills/react/react-srp-dry-analyzer/SKILL.md` | Reviews components for SRP and DRY violations and suggests smaller components or hooks to improve composition and reuse. |
| **Test Failure Resolver** | `skills/ci/test-failure-resolver/SKILL.md` | Helps trace failing tests by inspecting dependencies and recent changes, then routes the issue to the most relevant developer without blame. |

## CLI Installation Instructions

To ensure users can easily pull these skills down via CLI, use the following command:

`npx skills@latest add jericbas/skills` 


`npx skills@latest add jericbas/skills -a github-copilot`

`npx skills@latest add jericbas/skills -a claude-code`
