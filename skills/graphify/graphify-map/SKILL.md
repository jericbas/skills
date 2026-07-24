---
name: graphify-map
description: 'Gathers context and builds a strict execution map for a new feature using the local Graphify knowledge graph to prevent context bloat.'
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Graphify, Context, Planning, Architecture, Knowledge Graph]
    category: productivity
    related_skills: [graphify-setup, graphify-patch]
---

## Install
Run:
`npx skills add jericbas/skills --skill graphify-map`

# Map Graphify Feature

**Trigger Command:** `/graphify-map`

**Purpose:** Gathers context and builds a strict execution map for a new feature using the local `.graphify/graph.json` knowledge graph.

## Instructions for the Agent

1. **Targeted Context Gathering:** Ask the user what feature they are building. Do not proceed until they answer.
2. **Query the Graph:** Once the user provides the feature details, use the read-only Graphify MCP server (if active) or direct terminal commands to map the workspace. Use commands like:
   * `graphify query "[feature keywords]" --graph .graphify/graph.json` to find structural connections.
   * `graphify summary --graph .graphify/graph.json` for a compact first-hop orientation.
3. **Map the Workspace:** Based on the graph's output, map out the exact files, canonical entities, schemas, or existing configurations needed for that specific implementation.
4. **Output a Context Map:** Output a concise "context map" or checklist detailing the exact files that need to be touched.
5. **Halt Execution:** Stop immediately after providing the checklist. Do not write any code. This guarantees that when the user moves to the coding phase, the agent only holds the most relevant files in its memory, completely avoiding context bloat.
