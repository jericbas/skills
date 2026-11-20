---
name: floorplan
description: Draw an interactive architecture floorplan of an app's codebase or plan a blueprint from a PRD. Generates a self-contained node-graph HTML map with modules, files, and HTTP routes.
---

# Trigger Command: /floorplan

**Purpose:** Generates a self-contained, interactive architecture map (`floorplan/index.html`) of an application's codebase (single repo or multi-repo monorepo) or plans a blueprint from a PRD before code exists. Maps subsystems, modules, files, and HTTP routes with human-readable descriptions, call graphs, and zoom levels. Runs 100% locally and offline without external telemetry.

## Instructions for the Agent:

### 1. Pre-Flight & Status Check
Check whether an existing floorplan exists in the target codebase root:
```bash
node ${SKILL_DIR}/scripts/status.mjs [path-to-codebase-root]
```

### 2. Workflow A: Mapping an Existing Codebase
1. **Scan the Project:**
   Discover entry points, frameworks, files, and routes:
   ```bash
   node ${SKILL_DIR}/scripts/scan.mjs [path-to-codebase-root]
   ```
   This generates `floorplan/architecture.json` and worksheet descriptions.
2. **Review & Refine Descriptions:**
   Read and refine subsystem modules and plain-language descriptions in `floorplan/architecture.json` and `floorplan/descriptions/*.json`. Ensure descriptions reflect clear business and architectural purpose.
3. **Build the Map:**
   Assemble the standalone visualization (inlines layout engine and fonts):
   ```bash
   node ${SKILL_DIR}/scripts/build.mjs [path-to-codebase-root]
   ```
   Outputs `floorplan/graph.json` and `floorplan/index.html`.
4. **View or Serve:**
   Open the generated map or start the local query server:
   ```bash
   node ${SKILL_DIR}/scripts/open.mjs [path-to-codebase-root]
   ```

### 3. Workflow B: Drawing a Blueprint (No Code Yet)
Use when planning a greenfield project from a PRD, spec, or design prompt:
1. Review requirements and create `floorplan/plan.json` (screens, services, endpoints, data entities) and `floorplan/architecture.json`.
2. Generate the blueprint visualization:
   ```bash
   node ${SKILL_DIR}/scripts/plan.mjs [path-to-codebase-root]
   node ${SKILL_DIR}/scripts/build.mjs [path-to-codebase-root]
   node ${SKILL_DIR}/scripts/open.mjs [path-to-codebase-root]
   ```

### 4. Incremental Updates & Maintenance
When code changes occur after the initial map has been built:
1. Refresh the graph:
   ```bash
   node ${SKILL_DIR}/scripts/refresh.mjs [path-to-codebase-root]
   ```
2. Rebuild the map with `node ${SKILL_DIR}/scripts/build.mjs [path-to-codebase-root]`.

### 5. Querying the Map
Explore nodes, dependencies, or paths directly from the CLI:
```bash
node floorplan/query.mjs overview
node floorplan/query.mjs find "<search-query>"
node floorplan/query.mjs show <id>
node floorplan/query.mjs path <from-id> <to-id>
```
