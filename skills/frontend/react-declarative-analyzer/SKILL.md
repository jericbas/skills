---
name: react-declarative-analyzer
description: Scans the provided React file (JSX/TSX) and suggests refactoring imperative logic into declarative patterns.
---

# React Declarative Analyzer

**Trigger Command:** `/analyze-declarative`

## Instructions for the Agent
* Scan the target file strictly for imperative programming patterns.
* Identify any manual DOM manipulations, redundant `useEffect` chains, or step-by-step UI mutations.
* If the code is already declarative and simple, output: "This component successfully follows declarative principles."
* If imperative patterns are found, provide a refactored code block showing how to achieve the exact same behavior using React's declarative state-driven rendering.
* Briefly explain why the refactored code is more declarative.
