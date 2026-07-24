---
name: graphify-patch
description: 'Manages the reviewable patch lifecycle (validate -> dry-run -> apply) for canonical entities safely without directly mutating derived files.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Graphify, Ontology, Patching, Data]
    category: data
    related_skills: [graphify-map, graphify-review]
---

## Install
Run:
`npx skills add jericbas/skills --skill graphify-patch`

# Apply Ontology Patch

**Trigger Command:** `/graphify-patch`

**Purpose:** Safely manage canonical entities through a strict validation lifecycle.

## Instructions for the Agent

1. **Validate:** Ask the user for the patch file path, then run `graphify patch validate <file>`.
2. **Dry-Run:** If valid, run `graphify patch apply <file> --dry-run`.
3. **Approval:** Show the dry-run output and ask the user for explicit approval to apply the patch. Do not proceed without approval.
4. **Apply:** Once approved, run `graphify patch apply <file>`.
5. **Halt:** Stop execution and report successful mutation.
