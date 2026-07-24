#!/usr/bin/env node
const fs = require('node:fs');
const path = require('node:path');

function collectSkillEntries(rootDir) {
  if (!fs.existsSync(rootDir)) {
    return [];
  }

  const entries = [];
  const skillDirs = fs.readdirSync(rootDir, { withFileTypes: true })
    .filter((entry) => entry.isDirectory())
    .map((entry) => entry.name);

  for (const topLevelDir of skillDirs) {
    const absoluteDir = path.join(rootDir, topLevelDir);
    const skillFiles = fs.readdirSync(absoluteDir, { withFileTypes: true })
      .filter((entry) => entry.isDirectory())
      .map((entry) => entry.name)
      .filter((name) => fs.existsSync(path.join(absoluteDir, name, 'SKILL.md')));

    for (const skillName of skillFiles) {
      const skillDir = path.join(absoluteDir, skillName);
      const skillFile = path.join(skillDir, 'SKILL.md');
      const slug = skillName;
      const title = skillName
        .split('-')
        .filter(Boolean)
        .map((part) => part.charAt(0).toUpperCase() + part.slice(1))
        .join(' ');

      entries.push({
        slug,
        title,
        path: skillFile,
        category: topLevelDir,
      });
    }
  }

  return entries.sort((a, b) => a.slug.localeCompare(b.slug));
}

function buildSkillsShConfig(rootDir) {
  const entries = collectSkillEntries(rootDir);
  const groupings = [];

  const categorized = entries.reduce((acc, entry) => {
    const key = entry.category.toLowerCase();
    if (!acc[key]) {
      acc[key] = [];
    }
    acc[key].push(entry);
    return acc;
  }, {});

  for (const [category, items] of Object.entries(categorized)) {
    const groupTitle = category === 'react'
      ? 'React'
      : category === 'ci'
        ? 'CI'
        : category.charAt(0).toUpperCase() + category.slice(1);

    groupings.push({
      title: groupTitle,
      description: `Skills for ${groupTitle.toLowerCase()} workflows.`,
      skills: items.map((item) => item.slug),
    });
  }

  groupings.sort((a, b) => a.title.localeCompare(b.title));

  return {
    $schema: 'https://skills.sh/schemas/skills.sh.schema.json',
    notGrouped: 'bottom',
    groupings,
  };
}

function writeSkillsShConfig(rootDir, outputPath = path.join(process.cwd(), 'skills.sh.json')) {
  const config = buildSkillsShConfig(rootDir);
  fs.writeFileSync(outputPath, `${JSON.stringify(config, null, 2)}\n`);
  return config;
}

if (require.main === module) {
  const rootDir = process.argv[2] || 'skills';
  writeSkillsShConfig(rootDir, path.join(process.cwd(), 'skills.sh.json'));
}

module.exports = {
  collectSkillEntries,
  buildSkillsShConfig,
  writeSkillsShConfig,
};
