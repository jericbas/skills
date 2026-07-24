---
name: depcruise-setup
description: 'Installs dependency-cruiser and initializes the configuration file.'
trigger: /depcruise-setup
disable-model-invocation: true
license: MIT
metadata:
  hermes:
    tags: [Dependency Cruiser, Architecture, Setup, CLI]
    category: architecture
    related_skills: [depcruise, depcruise-run]
---

## Install
Run:
`npx skills add jericbas/skills --skill depcruise-setup`

# /depcruise-setup

The user wants to set up `dependency-cruiser` in their project. 

## Instructions for the Agent:

1. **Ask for Execution Preference:** Immediately ask the user if they want to install the package as a local dev dependency (`npm install -D dependency-cruiser`) or strictly run it on the fly using `npx`.
2. **Execute Installation:** Run the user's preferred installation command.
3. **Initialize Configuration:** Once available, ask the user if they want to scaffold the default validation rules. If yes, run `npx depcruise --init` (or the equivalent command based on their install preference) and briefly guide them through the interactive prompts.
4. **Graphviz Warning:** Remind the user that if they intend to generate visual `.svg` or `.dot` graphs later, they will need to have Graphviz installed on their operating system.
5. **Halt:** Stop execution once the `.dependency-cruiser.js` configuration file is successfully created.
