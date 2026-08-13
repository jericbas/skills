# Specification: [Module/Component Name]

## 1. Intent & Context
[One to two sentences explicitly defining the core business or technical reason this module exists. State the "Why" and strip away all fluff.]

## 2. The Core Contract (I/O & State)
[Define exactly what data this module accepts, what it returns, and what global/local state it mutates. Use code blocks for schemas or type definitions.]
* **Inputs:** [Describe arguments, props, or API payloads]
* **Outputs/Mutations:** [Describe return values or side effects]

## 3. Strict Constraints & Rules
[List the absolute non-negotiable architectural or business rules. Keep this to 3-5 punchy bullet points. What MUST it do? What MUST it NOT do?]
* **CON-001:** [e.g., "Must not mutate the original data array."]
* **CON-002:** [e.g., "Must execute in under 50ms."]

## 4. Critical Dependencies
[List ONLY the external systems, files, or external services this module absolutely relies on to function. Omit standard framework libraries.]
* **[Dependency Name]:** [Reason it is required]

## 5. Edge Cases & Error Handling
[Define the specific failure states and exactly how the code should handle them (e.g., graceful degradation, specific error messages, or hard crashes).]
* **When [Edge Case Condition]:** The system must [Expected Fallback Behavior].

## 6. Definition of Done (Acceptance)
[Provide 2-3 testable, deterministic scenarios to validate completion.]
* **AC1:** Given [initial context], When [specific action occurs], Then [exact measurable result].
* **AC2:** Given [initial context], When [specific action occurs], Then [exact measurable result].
