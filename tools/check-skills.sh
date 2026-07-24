#!/bin/bash

# Ensure the script stops on critical setup errors
set -e

# ==========================================
# 1. SETUP MODE: Run this once to configure Husky
# ==========================================
if [ "$1" == "setup" ]; then
  echo "⚙️  Setting up Husky pre-commit hook..."
  
  # Install husky as a dev dependency if it isn't already
  npm install --save-dev husky
  
  # Initialize husky (creates the .husky folder)
  npx husky init
  
  # Write the command to run this script into the pre-commit hook
  echo "bash tools/check-skills.sh" > .husky/pre-commit
  
  # Ensure the hook and this script are executable
  chmod +x .husky/pre-commit
  chmod +x tools/check-skills.sh
  
  echo "✅ Husky setup complete! The validation will now run automatically on 'git commit'."
  exit 0
fi

# ==========================================
# 2. VALIDATION MODE: Runs on commit
# ==========================================
set +e # Disable exit-on-error so we can count all failures
ERROR_COUNT=0

echo "🔍 Validating SKILL.md files..."

# Find all SKILL.md files (case-insensitive), ignoring node_modules and .git
while IFS= read -r file; do
  
  # Extract the parent directory name
  PARENT_DIR=$(basename "$(dirname "$file")")
  EXPECTED_TEXT="npx skills add jericbas/skills --skill $PARENT_DIR"

  # Search for the exact string in the file
  if ! grep -Fq "$EXPECTED_TEXT" "$file"; then
    echo "❌ Failed: $file"
    echo "   Missing: \"$EXPECTED_TEXT\""
    ERROR_COUNT=$((ERROR_COUNT + 1))
  else
    echo "✅ Passed: $file"
  fi

done < <(find . -type f -iname "skill.md" -not -path "*/node_modules/*" -not -path "*/.git/*")

# If any file failed, exit with 1 to block the git commit
if [ "$ERROR_COUNT" -gt 0 ]; then
  echo ""
  echo "🚨 Commit blocked: $ERROR_COUNT file(s) failed validation."
  exit 1
fi

echo "🎉 All SKILL.md files are valid!"
exit 0