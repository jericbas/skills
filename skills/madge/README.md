# Madge Agent Skills

Madge is an incredibly powerful tool for visualizing and debugging dependency graphs in your codebase. These skills wrap Madge's capabilities into highly focused agent commands to automate terminal work.

## The Command Suite

| Trigger Command | Skill Folder | Purpose |
| --- | --- | --- |
| `/madge-setup` | `madge-setup` | Asks the user for their execution preference (global vs. npx) and handles Graphviz installation for image generation. |
| `/madge` | `madge` | Acts as a comprehensive wrapper for the Madge CLI to check circular dependencies, orphans, and leaves. |

## Workflow Example

To effectively audit your project's architecture, use these tools in sequence:

1. **Set Up**: Run `/madge-setup`. Decide between `npx` or a global install, and grab `graphviz` if you need SVG outputs.
2. **Audit Circulars**: Run `/madge`. Tell the AI: "Check my `/src` folder for circular dependencies." The agent will run `npx madge --circular ./src`.
3. **Clean Up Orphans**: Run `/madge`. Tell the AI: "Find unused modules in `/components`." The agent will run `npx madge --orphans ./components`.
4. **Visualize**: Run `/madge`. Tell the AI: "Generate an SVG graph of `app.js`." The agent will output `graph.svg` into your root directory.
