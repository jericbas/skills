# Prop Drilling Detector

**Trigger Command:** `/detect-prop-drilling`
**Purpose:** Uses react-docgen to extract React component props into a structured JSON file, preventing the AI from wasting context window tokens on raw logic.

## Instructions for the Agent
* Target the provided React component files.
* Run `react-docgen` (or `react-docgen-typescript`) on the components to extract their props into a structured JSON format.
* Analyze the generated JSON to track how props are passed down through multiple component layers.
* Identify any props that are passed through intermediate components without being utilized.
* Output a summary of the prop drilling path and suggest an architectural refactor (e.g., Context API, component composition) to resolve it.
