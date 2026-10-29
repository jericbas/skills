---
name: react-srp-dry-analyzer
description: >-
  Scans a React component to identify Single Responsibility Principle (SRP) and
  DRY violations, then suggests refactors into smaller composable components or
  custom hooks. Use when refactoring bloated React components or extracting
  reusable hooks.
trigger: /analyze-srp-dry
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [React, SRP, DRY, Refactoring, SOLID, Architecture]
    category: react
    related_skills: [react-19-ts-review]
---

## Install
Run:
`npx skills add jericbas/skills --skill react-srp-dry-analyzer`

# React SRP/DRY Analyzer

**Trigger Command:** `/analyze-srp-dry`

## Instructions for the Agent
* Scan the target component for SRP violations by identifying code that mixes data fetching, state orchestration, and UI rendering.
* Scan for DRY violations such as duplicated logic, repeated UI patterns, or helper functions that should be extracted into custom hooks or shared components.
* If the component is already clean and composable, output: "This component successfully follows SRP and DRY principles."
* If violations exist, provide a refactored code block that splits the logic into smaller, composable pieces or extracts reusable hooks/components.
* Briefly explain why the refactor improves SRP and DRY.
