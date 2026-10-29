# jericbas/skills

This is a personal repository used to codify my engineering workflows into reusable AI agent skills.

## The Strategy: Sprint-Sized Skills

Most AI agents struggle with context limits. If you feed an LLM a massive task with too many details, it hits a context cut-off and loses track of the goal. To solve this, this repository treats AI skills like tasks in an Agile sprint: as small, specific, and particular as possible.

## The Skills List



| Skill | Location | Description |
| :--- | :--- | :--- |
| Skill | Location | Purpose |
| :--- | :--- | :--- |
| Test Failure Resolver | [skills/ci/test-failure-resolver/SKILL.md](skills/ci/test-failure-resolver/SKILL.md) | Investigates failing unit tests and gathers dependency and change context. |
| Dependency Cruiser | [skills/depcruise/depcruise/SKILL.md](skills/depcruise/depcruise/SKILL.md) | Routes architecture-analysis requests to setup or dependency validation. |
| Dependency Cruiser Runner | [skills/depcruise/depcruise-run/SKILL.md](skills/depcruise/depcruise-run/SKILL.md) | Runs dependency rules, graph generation, and architecture checks. |
| Dependency Cruiser Setup | [skills/depcruise/depcruise-setup/SKILL.md](skills/depcruise/depcruise-setup/SKILL.md) | Sets up Dependency Cruiser and its configuration. |
| Generate Retro Spec | [skills/engineering/generate-retro-spec/SKILL.md](skills/engineering/generate-retro-spec/SKILL.md) | Creates a structured specification from retrospective findings. |
| Graphify Agent Stats | [skills/graphify/graphify-agents/SKILL.md](skills/graphify/graphify-agents/SKILL.md) | Tracks agent-session usage and contribution information. |
| Graphify Map | [skills/graphify/graphify-map/SKILL.md](skills/graphify/graphify-map/SKILL.md) | Uses the project graph to identify relevant code before implementation. |
| Graphify Patch | [skills/graphify/graphify-patch/SKILL.md](skills/graphify/graphify-patch/SKILL.md) | Validates and applies approved patches to canonical graph entities. |
| Graphify Review | [skills/graphify/graphify-review/SKILL.md](skills/graphify/graphify-review/SKILL.md) | Reviews graph impact and test gaps for code changes. |
| Graphify Setup | [skills/graphify/graphify-setup/SKILL.md](skills/graphify/graphify-setup/SKILL.md) | Installs and configures Graphify for a repository. |
| Madge | [skills/madge/madge/SKILL.md](skills/madge/madge/SKILL.md) | Runs dependency graph, circular dependency, and orphan checks. |
| Madge Setup | [skills/madge/madge-setup/SKILL.md](skills/madge/madge-setup/SKILL.md) | Sets up Madge and optional Graphviz support. |
| TeachMe | [skills/personal/teachme/SKILL.md](skills/personal/teachme/SKILL.md) | Builds a sequence of interactive, sprint-sized learning lessons. |
| React 19 + TypeScript Reviewer | [skills/react/react-19-ts-review/SKILL.md](skills/react/react-19-ts-review/SKILL.md) | Reviews React 19 and TypeScript branch changes against project standards. |
| React SRP/DRY Analyzer | [skills/react/react-srp-dry-analyzer/SKILL.md](skills/react/react-srp-dry-analyzer/SKILL.md) | Finds component responsibility and duplication issues. |
| Apply Master Strategy | [skills/strategy/apply-master-strategy/SKILL.md](skills/strategy/apply-master-strategy/SKILL.md) | Applies a structured framework to strategic decisions. |
| Daily Standup | [skills/team/daily-standup/SKILL.md](skills/team/daily-standup/SKILL.md) | Summarizes recent work and current changes for standup updates. |
| Repository Onboarding | [skills/team/repo-onboarding/SKILL.md](skills/team/repo-onboarding/SKILL.md) | Guides a developer through understanding a repository. |
| Sprint Retro Wins | [skills/team/sprint-retro-wins/SKILL.md](skills/team/sprint-retro-wins/SKILL.md) | Turns recent sprint work into retrospective highlights. |

## Commit Messages

Commits are validated with [Conventional Commits](https://www.conventionalcommits.org/) through the `commit-msg` hook. Use `type(scope): summary`, for example `feat(graphify): add patch review command` or `fix(teachme): preserve existing configuration`.

Use `feat` for user-facing capabilities and `fix` for bug fixes; release-please uses these types to determine version bumps. Other standard types such as `docs`, `refactor`, `test`, `build`, and `chore` are accepted but do not normally create a release. Mark a breaking change with `!` after the type/scope and include a `BREAKING CHANGE:` footer, for example `feat(api)!: change the patch format`.

The repository currently enforces Conventional Commit syntax. A release-please workflow/configuration is not present in this checkout, so automated release PRs still need to be configured separately.

## Tech Debt / TODO

- Add Codex/OpenAI agent metadata to each skill so they are discoverable and consistent across tooling.

## CLI Installation Instructions

To ensure users can easily pull these skills down via CLI, use the following command:

`npx skills@latest add jericbas/skills` 


`npx skills@latest add jericbas/skills -a github-copilot`

`npx skills@latest add jericbas/skills -a claude-code`
