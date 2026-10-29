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

  # Validate YAML frontmatter (name matches parent_dir, third-person description with "Use when", and install block)
  if ! python3 - "$file" "$PARENT_DIR" <<'PY'
import pathlib
import re
import sys

file_path = sys.argv[1]
parent_dir = sys.argv[2]
text = pathlib.Path(file_path).read_text()
lines = text.splitlines()

# 1. Check YAML frontmatter boundaries
if not lines or lines[0].strip() != "---":
    print("   Missing opening YAML frontmatter '---'", file=sys.stderr)
    raise SystemExit(1)

end_idx = None
for idx in range(1, len(lines)):
    if lines[idx].strip() == "---":
        end_idx = idx
        break

if end_idx is None:
    print("   Missing closing YAML frontmatter '---'", file=sys.stderr)
    raise SystemExit(1)

frontmatter = "\n".join(lines[1:end_idx])

# 2. Check kebab-case 'name' matches parent folder (https://antigravity.google/docs/skills/)
name_match = re.search(r"^name:\s*(.+)$", frontmatter, re.MULTILINE)
if not name_match:
    print("   Missing required 'name' field in frontmatter", file=sys.stderr)
    raise SystemExit(1)

skill_name = name_match.group(1).strip().strip("'\"")
if skill_name != parent_dir:
    print(f"   Frontmatter name '{skill_name}' does not match directory '{parent_dir}'", file=sys.stderr)
    raise SystemExit(1)

# 3. Check required 'description' field in frontmatter
if not re.search(r"^description:\s*", frontmatter, re.MULTILINE):
    print("   Missing required 'description' field in frontmatter", file=sys.stderr)
    raise SystemExit(1)

# 4. Validate the install block as an exact three-line sequence
expected_lines = [
    "## Install",
    "Run:",
    f"`npx skills add jericbas/skills --skill {parent_dir}`",
]

for start in range(len(lines) - len(expected_lines) + 1):
    if lines[start:start + len(expected_lines)] == expected_lines:
        raise SystemExit(0)

print("   Missing expected install block", file=sys.stderr)
raise SystemExit(1)
PY
  then
    echo "❌ Failed: $file"
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