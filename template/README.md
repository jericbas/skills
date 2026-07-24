# Skills Repository Template

Use this folder as a starting point for a repository that wants to customize how its skills appear on skills.sh.

## What to include

- A root-level [skills.sh.json](skills.sh.json) file to group and organize skills on the repository page.
- Skill folders under a top-level skills directory, following the pattern used in this repo.
- A root-level README that explains the repository and its skills.

## Minimal skills.sh.json template

Copy the following into a file named skills.sh.json at the repository root:

```json
{
  "$schema": "https://skills.sh/schemas/skills.sh.schema.json",
  "notGrouped": "bottom",
  "groupings": [
    {
      "title": "React",
      "description": "Skills for React and frontend engineering.",
      "skills": [
        "react-best-practices",
        "react-component-patterns"
      ]
    },
    {
      "title": "Testing",
      "description": "Skills for quality and validation workflows.",
      "skills": [
        "test-failure-resolver",
        "playwright-cli"
      ]
    }
  ]
}
```

## Guidelines

- Keep the file valid JSON.
- Use at least one grouping with a non-empty title and at least one skill.
- Prefer the skill slug from the skills.sh URL when possible.
- If a skill is not listed in any group, it will appear under an "Other skills" section.
- Set notGrouped to "bottom" if curated groups should appear first, or "top" if ungrouped skills should appear first.
- Changes may take time to appear on the public skills.sh page because repository pages are cached.

## Suggested structure

```text
.
├── README.md
├── skills.sh.json
└── skills/
    └── react/
        └── react-best-practices/
            └── SKILL.md
```

## SKILL.md template

A basic skill file should include frontmatter and a short instruction block. A starter example is available at [skills/example-skill/SKILL.md](skills/example-skill/SKILL.md).

Use this structure when creating a new skill:

```md
---
name: example-skill
description: A short description of what this skill does.
license: MIT
---

# Example Skill

Describe the purpose of the skill in one or two sentences.

## Instructions

- Explain the main task this skill helps with.
- List the key steps or decision points the agent should follow.
- Mention any relevant tools, files, or commands.

## Install

Run:

`npx skills add jericbas/skills --skill example-skill`
```
