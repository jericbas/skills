# /analyze-srp-dry
Purpose: Enforce Single Responsibility Principle (SRP) and Don't Repeat Yourself (DRY) in React components.

Instructions:
- Scan for SRP violations: Identify components mixing data fetching, heavy state logic, and UI rendering.
- Scan for DRY violations: Identify duplicated logic, inline UI patterns, or functions that should be custom hooks.
- If violations exist, provide refactored code breaking the component into composable sub-components or extracting logic into custom hooks.
- If the component is clean, output: "This component successfully follows SRP and DRY principles."
