
# Graphify Agent Skills

A collection of sprint-sized, strictly-scoped AI agent skills for managing `@sentropic/graphify` knowledge graphs. These skills use a `/graphify-[action]` namespace to prevent collisions with the native Graphify CLI tool.

## Installation

Add these skills to your local AI agent (like Claude Code or Cursor) using the skills CLI:

```bash
npx skills@latest add jericbas/skills

```

*(Alternatively, manually copy the specific `SKILL.md` folders into your project's `.claude/` or equivalent context directory.)*

## The Command Suite

| Trigger Command | Skill Folder | Purpose |
| --- | --- | --- |
| `/graphify-setup` | `setup-graphify` | Safely installs the Graphify CLI, sets up agent integrations, and builds the initial local graph. |
| `/graphify-map` | `map-graphify-feature` | Queries `.graphify/graph.json` to map out exact files needed for a feature. Halts before coding to prevent context bloat. |
| `/graphify-patch` | `apply-ontology-patch` | Safely manages canonical entities using the strict Patch Lifecycle (Validate -> Dry-Run -> Apply). |
| `/graphify-review` | `review-graphify-impact` | Analyzes staged files for blast radius and test gaps before a commit. |
| `/graphify-agents` | `track-agent-stats` | Parses local transcripts to track token usage and attribute work to the current AI session. |

## The Ontology Patch Lifecycle

Because modifying canonical entities directly can corrupt the graph, the `/graphify-patch` skill forces the AI agent to follow a strict, immutable lifecycle method:

1. **Validate:** Runs `graphify patch validate <file>` to verify structural and schema compliance.
2. **Dry-Run:** Runs `graphify patch apply <file> --dry-run` to output a preview of the exact mutations to the graph.
3. **Approval Halt:** The agent completely halts execution to wait for explicit human approval.
4. **Apply:** Only upon human confirmation does the agent execute the final `graphify patch apply <file>` command.

## Real-World Workflow Example

To effectively use Graphify as your pair programmer without burning through your context window, run the tools in a strict sequence.

Here is an example of using this workflow to build a **"Forgot Password"** feature:

1. **Scope the Work:** Run `/graphify-map I am building a Forgot Password flow`
* *Result:* The AI queries the graph, tells you exactly which 3 files you need to edit (`auth.ts`, `db.ts`, `Login.tsx`), and completely stops talking.


2. **Write Code:** Write your code in those 3 isolated files.
3. **Update the Graph:** Run `/graphify-patch`
* *Result:* The AI creates a patch for the new `ForgotPassword` entity, shows you a safe dry-run, and waits for your explicit "yes" before updating the actual `.graphify` knowledge graph.


4. **Check Blast Radius:** Run `/graphify-review`
* *Result:* The AI checks your staged code and warns: *"Blast radius is 2 communities. Missing test coverage in `auth.spec.ts`."*


5. **Commit:** Commit your code to Git.
6. **Log Session:** Run `/graphify-agents`
* *Result:* The AI parses your local transcript and logs the stats: *"1 commit attributed. Time: 15m. Tokens: 3,500."*

