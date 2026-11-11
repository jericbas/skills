# jericbas/skills

Personal AI agent skills for engineering workflows. Each skill is small and focused so it fits inside an agent's context window.

## Install

```bash
npx skills@latest add jericbas/skills
npx skills@latest add jericbas/skills -a github-copilot
npx skills@latest add jericbas/skills -a claude-code
```

## Skills

- **CI**: [Test Failure Resolver](skills/ci/test-failure-resolver/SKILL.md)
- **Depcruise**: [Dependency Cruiser](skills/depcruise/depcruise/SKILL.md), [Runner](skills/depcruise/depcruise-run/SKILL.md), [Setup](skills/depcruise/depcruise-setup/SKILL.md)
- **Engineering**: [Generate Retro Spec](skills/engineering/generate-retro-spec/SKILL.md)
- **Graphify**: [Agent Stats](skills/graphify/graphify-agents/SKILL.md), [Map](skills/graphify/graphify-map/SKILL.md), [Patch](skills/graphify/graphify-patch/SKILL.md), [Review](skills/graphify/graphify-review/SKILL.md), [Setup](skills/graphify/graphify-setup/SKILL.md)
- **Madge**: [Madge](skills/madge/madge/SKILL.md), [Setup](skills/madge/madge-setup/SKILL.md)
- **Personal**: [TeachMe](skills/personal/teachme/SKILL.md)
- **React**: [React 19 + TypeScript Reviewer](skills/react/react-19-ts-review/SKILL.md), [SRP/DRY Analyzer](skills/react/react-srp-dry-analyzer/SKILL.md)
- **Strategy**: [Apply Master Strategy](skills/strategy/apply-master-strategy/SKILL.md)
- **Team**: [Daily Standup](skills/team/daily-standup/SKILL.md), [Repository Onboarding](skills/team/repo-onboarding/SKILL.md), [Sprint Retro Wins](skills/team/sprint-retro-wins/SKILL.md)

## Skill format

Each `SKILL.md` uses minimal frontmatter. Install instructions live here, not in individual skills.

```yaml
---
name: skill-name
description: What the skill does and when to use it.
disable-model-invocation: true
---
```

Omit `disable-model-invocation` for skills the model should invoke on its own.

## Commits

Use [Conventional Commits](https://www.conventionalcommits.org/): `type(scope): summary`. `feat` and `fix` drive releases; mark breaking changes with `!` and a `BREAKING CHANGE:` footer.

Releases are automated with Release Please. Users update installed skills with `npx skills update`.

## TODO

- Add Codex/OpenAI agent metadata to each skill.
