---
name: teachme
description: Teaches a skill through Binary Diagnostics, forcing 100% success-rate retrieval practice before logging mastery.
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Mentorship, Mastery, Interactive Learning, Diagnostics, Hansei]
---

## Install
Run:
`npx skills add jericbas/skills --skill teachme`

**Trigger Command:** `/teachme`

**Purpose:** Teaches a new skill or concept over multiple sessions. It focuses on practical, repeatable lessons and checks to help the learner build confidence and understanding.

**Layman's terms:** This skill helps someone learn a topic by creating one short lesson at a time, with simple checks to make sure they understand before moving on. Think of it like a patient tutor: make a lesson, show it to the learner, and only keep things that actually help.

**Instructions for the Agent:**

1. **Step 1: Configuration Pre-Flight Check**
   * Search the entire repository, including parent directories if needed, for exactly one `.teachme-config.json`. There must be only one active config for the whole repo.
   * **If a config already exists:** Do not create a second one. Parse the file immediately and validate that it is valid JSON and correctly configured. Ensure the required paths for `lessons`, `assets`, and `reference` are present and valid, and that any relative paths resolve correctly from the config file’s directory. If the JSON is malformed or incomplete, repair it in place or ask the user for the correct values before continuing.
   * **If multiple configs are found:** Treat it as a setup issue. Ask which config is canonical, keep only one, and remove or consolidate duplicates before proceeding.
   * **If no config exists:** Ask the user what skill or concept they want to learn and where they want to store the single teaching workspace. Prefer a dedicated repo-local directory such as `./.teachme/` or `./.local/teachme/` and create only one config there. Default the target directories relative to the config file itself (`./lessons/`, `./assets/`, `./reference/`). Generate a `MISSION.md` file capturing their overarching goal based on the response before proceeding.
   * Acknowledge the active repo configuration and continue to Step 2 without creating duplicate config files.

2. **Step 2: Context & Zone of Proximal Development**
   * Read `MISSION.md` and any existing lesson files in the configured `lessons/` directory.
   * Determine the most relevant, sprint-sized concept to teach next based on the user's mission and previous struggles.

3. **Step 3: Generate the Lesson**
   * Generate a single, self-contained, beautiful HTML lesson in the configured `lessons/` directory based on the user’s exact query and the mission.
   * If there is already an existing lesson in the configured `lessons/` directory that covers the same topic or a prerequisite concept, prefer linking to or extending that lesson rather than creating duplicate content. Where possible, create a short next-step lesson that references the earlier lesson and explains the relationship.
   * Focus only on the required knowledge to acquire the specific skill.
   * Recommend a primary, high-trust external source for the user to review.

4. **Step 4: Optional Assessment & Reflection**
   * Optionally include a lightweight check in the lesson HTML (stored under `assets/`) to help the learner self-verify understanding. This is not a blocking quiz; it should be friendly and supportive.
   * Encourage a short reflection from the learner (Hansei-style) after a lesson: one or two sentences about what was hard or surprising.
   * If the user wants a persistent learning log, offer to add a simple `learning-records/` directory, but do not require it by default.
