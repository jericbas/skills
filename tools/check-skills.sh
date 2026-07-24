# ==========================================
# 2. VALIDATION MODE: Runs on commit
# ==========================================
set +e # Disable exit-on-error so we can count all failures
ERROR_COUNT=0
TARGET_DIR="skills" # <-- Define your target directory here

echo "🔍 Validating SKILL.md files in the '$TARGET_DIR' directory..."

# Safety check: If the directory doesn't exist, skip the check successfully
if [ ! -d "$TARGET_DIR" ]; then
  echo "⚠️  Directory '$TARGET_DIR' does not exist yet. Skipping validation."
  exit 0
fi

# Find all SKILL.md files (case-insensitive) ONLY inside the skills/ folder
while IFS= read -r file; do
  
  # Extract the parent directory name
  PARENT_DIR=$(basename "$(dirname "$file")")
  EXPECTED_TEXT=$(printf '## Install\nRun:\n`npx skills add jericbas/skills --skill %s`' "$PARENT_DIR")

  # Search for the exact string in the file
  if ! grep -Fq "$EXPECTED_TEXT" "$file"; then
    echo "❌ Failed: $file"
    echo "   Missing: \"$EXPECTED_TEXT\""
    ERROR_COUNT=$((ERROR_COUNT + 1))
  else
    echo "✅ Passed: $file"
  fi

# <-- Updated find command targets the specific directory
done < <(find "$TARGET_DIR" -type f -iname "skill.md")

# If any file failed, exit with 1 to block the git commit
if [ "$ERROR_COUNT" -gt 0 ]; then
  echo ""
  echo "🚨 Commit blocked: $ERROR_COUNT file(s) failed validation."
  exit 1
fi

echo "🎉 All SKILL.md files under '$TARGET_DIR' are valid!"
exit 0