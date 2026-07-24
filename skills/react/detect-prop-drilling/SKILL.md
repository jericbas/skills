---
name: detect-prop-drilling
description: Uses react-docgen to extract React component props and detect unnecessary prop drilling through intermediate components.
---

## Install
Run:
`npx skills add jericbas/skills --skill detect-prop-drilling`

# Prop Drilling Detector

**Trigger Command:** `/detect-prop-drilling`

## Instructions for the Agent
* Target the provided React component files.
* Run `react-docgen` (or `react-docgen-typescript`) on the components to extract their props into a structured JSON format.
* Analyze the generated JSON to track how props are passed down through multiple component layers.
* Identify any props that are passed through intermediate components without being utilized.
* Output a summary of the prop drilling path and suggest an architectural refactor (e.g., Context API, component composition) to resolve it.
