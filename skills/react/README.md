# React & TypeScript Agent Skills

A collection of sprint-sized AI agent skills for reviewing and refactoring React 19 and TypeScript codebases using modern React 19 primitives, core React principles, and layer-scoped SOLID design principles.

## Installation

Install the React skills using the skills CLI:

```bash
# Install the React 19 + TypeScript Branch Reviewer
npx skills add jericbas/skills --skill react-19-ts-review

# Install the React SRP/DRY Component Analyzer
npx skills add jericbas/skills --skill react-srp-dry-analyzer
```

## The Command Suite

| Trigger Command | Skill Folder | Purpose |
| :--- | :--- | :--- |
| `/review-react-19` | `react-19-ts-review` | Confirms the target git branch (e.g., `develop`), optionally runs `/graphify` for blast-radius context, and audits modified `.ts`/`.tsx` files for React 19 standards/features, React principles, TypeScript strictness, and layer-scoped SOLID principles (S, O, L, I on components; S, O, L, I, D on non-component code). |
| `/analyze-srp-dry` | `react-srp-dry-analyzer` | Deep-scans a specific React component for Single Responsibility (SRP) and DRY violations, outputting composable refactored components and custom hooks. |

## Real-World Workflow Example

1. **Branch Diff Review:** Run `/review-react-19`.
   * *Result:* The agent detects your current branch, asks which base branch to compare against (e.g., `develop`), checks `/graphify` if available, and outputs a categorized report covering React 19 upgrades (`ref` prop, `use()`, `useActionState`, `useOptimistic`, `<Context>`), declarative state rules, and SOLID compliance.
2. **Targeted Component Refactor:** If the branch review flags a complex "God component", run `/analyze-srp-dry` on that file to extract clean subcomponents and custom hooks.

