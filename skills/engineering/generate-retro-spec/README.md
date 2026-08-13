# Generate Retro-Spec (/generate-retro-spec)

## The Problem: Legacy Code & Context Bloat
Modern AI-assisted engineering relies on **Spec-Driven Development (SDD)**, where clean, minimal Markdown requirements dictate what the AI builds. However, older legacy repositories lack these specifications. 

If you ask an AI to "document the whole repository," it fails. Shoving dozens of tightly coupled, messy legacy files into an LLM at once maxes out the context window. It violates the core rule of SDD: **Specifications must be minimal and human-reviewable.**

## The Solution: Iterative SDD Reverse-Engineering
To properly retrofit a legacy codebase for Spec-Driven Development, the `/generate-retro-spec` skill acts as an interactive CLI tool. It forces the developer to define strict input and output boundaries before any AI analysis begins.

By untangling the legacy logic directory-by-directory, the AI generates pristine, SDD-compliant `spec.md` files that can be used to safely refactor or extend the legacy code later.

## Handling Collisions & Partial Documentation (DRY Docs)
When generating specs iteratively, there is a risk of **Specification Collision** (e.g., the newly generated Auth spec contradicts an existing Database spec) or **Redundancy** (rewriting what is already in a legacy README). 

To prevent this, the skill includes a strict **Adjacency Check**. Before generating a new document, the AI will ask for paths to related specs OR existing partial documentation. The AI is instructed to use Markdown links to reference existing docs rather than duplicating their content.

## References & Guidelines
This skill's architecture and SDD rules are directly inspired by the following industry standards and research:

1. **[README-Driven Development by Tom Preston-Werner](https://tom.preston-werner.com/2010/08/23/readme-driven-development.html)**
   * *Guideline:* Specifications/documentation must be the ultimate source of truth. If the code deviates, the code is wrong.
2. **[Lost in the Middle: How Language Models Use Long Contexts (Stanford Research)](https://arxiv.org/abs/2307.03172)**
   * *Guideline:* The academic proof of the "context bloat" problem, justifying our directory-by-directory approach.
3. **[Anthropic Prompt Engineering Strategies](https://docs.anthropic.com/en/docs/build-with-claude/prompt-engineering/overview)**
   * *Guideline:* Best practices for defining AI tasks. Prompts and specs must be minimal, modular, and prioritize human-reviewability.
4. **[Matt Pocock's Composable Skills Architecture](https://github.com/mattpocock/skills)**
   * *Guideline:* The architectural inspiration for treating AI skills exactly like sprint tasks using isolated Markdown files.
5. **[The skills.sh Official Registry](https://www.skills.sh/)**
   * *Guideline:* The open distribution standard for composable agent CLI skills.

## How to Use It
1. Run `/generate-retro-spec` in your agent chat.
2. **Target Input:** Provide the target directory or file (e.g., `src/legacy-auth/` or `src/utils.js`).
3. **Target Output:** Provide the save location (e.g., `./docs/specs/`).
4. **Adjacency Check:** Provide paths to any existing specs OR partial documentation (like an old README).
5. **Execution:** The AI generates a minimal, DRY, human-reviewable Markdown specification.
