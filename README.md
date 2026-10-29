# jericbas/skills

This is a personal repository used to codify my engineering workflows into reusable AI agent skills.

## The Strategy: Sprint-Sized Skills

Most AI agents struggle with context limits. If you feed an LLM a massive task with too many details, it hits a context cut-off and loses track of the goal. To solve this, this repository treats AI skills like tasks in an Agile sprint: as small, specific, and particular as possible.

## The Skills List



| Skill | Location | Description |
| :--- | :--- | :--- |
| **Daily Standup & Today's Task Generator** | `skills/team/daily-standup/SKILL.md` | Scans yesterday's (or the last active day's) commits, today's commits, and staged/uncommitted changes on the current branch (or specified branches) to generate copy-pasteable standup notes and verbal talking points in intermediate English. |
| **React 19 + TypeScript Branch Reviewer** | `skills/react/react-19-ts-review/SKILL.md` | Reviews branch diffs against a confirmed target branch (e.g., `develop`) for React 19 standards & new features, React principles, `/graphify` impact, and layer-scoped SOLID principles (S, O, L, I for components; S, O, L, I, D for non-component layers). |
| **React SRP/DRY Analyzer** | `skills/react/react-srp-dry-analyzer/SKILL.md` | Reviews components for SRP and DRY violations and suggests smaller components or hooks to improve composition and reuse. |
| **Sprint Retro "What Went Well" Generator** | `skills/team/sprint-retro-wins/SKILL.md` | Scans a developer's git commits from the last 2 weeks on `develop`/`main` (or custom branches) and generates copy-pasteable retro board sticky notes and natural first-person talking points answering "What went well in this sprint?". |
| **Test Failure Resolver** | `skills/ci/test-failure-resolver/SKILL.md` | Helps trace failing tests by inspecting dependencies and recent changes, then routes the issue to the most relevant developer without blame. |

## Tech Debt / TODO

- Add Codex/OpenAI agent metadata to each skill so they are discoverable and consistent across tooling.

## CLI Installation Instructions

To ensure users can easily pull these skills down via CLI, use the following command:

`npx skills@latest add jericbas/skills` 


`npx skills@latest add jericbas/skills -a github-copilot`

`npx skills@latest add jericbas/skills -a claude-code`
