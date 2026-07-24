# ==========================================
# 2. VALIDATION MODE: Runs on commit
# ==========================================
set +e # Disable exit-on-error so we can count all failures
ERROR_COUNT=0
TARGET_DIR="skills" # <-- Define your target directory here

node tools/skills-sh-json.js "$TARGET_DIR" >/dev/null 2>&1
if [ $? -ne 0 ]; then
  echo "❌ Failed: could not generate skills.sh.json"
  ERROR_COUNT=$((ERROR_COUNT + 1))
fi

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

  # Validate the install block as an exact three-line sequence
  if ! python3 - "$file" "$PARENT_DIR" <<'PY'
import pathlib
import sys

file_path = sys.argv[1]
parent_dir = sys.argv[2]
expected_lines = [
    "## Install",
    "Run:",
    f"`npx skills add jericbas/skills --skill {parent_dir}`",
]

lines = pathlib.Path(file_path).read_text().splitlines()
for start in range(len(lines) - len(expected_lines) + 1):
    if lines[start:start + len(expected_lines)] == expected_lines:
        raise SystemExit(0)

raise SystemExit(1)
PY
  then
    echo "❌ Failed: $file"
    echo "   Missing expected install block"
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