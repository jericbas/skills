---
name: react-srp-dry-analyzer
description: Scans the provided React component and identifies SRP/DRY violations, then suggests refactors into smaller components or custom hooks.
---

# React SRP/DRY Analyzer

**Trigger Command:** `/analyze-srp-dry`

## Instructions for the Agent
* Scan the target component for SRP violations by identifying code that mixes data fetching, state orchestration, and UI rendering.
* Scan for DRY violations such as duplicated logic, repeated UI patterns, or helper functions that should be extracted into custom hooks or shared components.
* If the component is already clean and composable, output: "This component successfully follows SRP and DRY principles."
* If violations exist, provide a refactored code block that splits the logic into smaller, composable pieces or extracts reusable hooks/components.
* Briefly explain why the refactor improves SRP and DRY.
