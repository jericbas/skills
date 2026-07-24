const test = require('node:test');
const assert = require('node:assert/strict');

const { buildSkillsShConfig, collectSkillEntries } = require('./skills-sh-json');

test('collectSkillEntries groups skills by top-level skill folder', () => {
  const entries = collectSkillEntries('skills');

  assert.ok(entries.length > 0);
  assert.ok(entries.some((entry) => entry.slug === 'test-failure-resolver'));
  assert.ok(entries.some((entry) => entry.slug === 'detect-prop-drilling'));
});

test('buildSkillsShConfig creates a valid skills.sh.json structure', () => {
  const config = buildSkillsShConfig('skills');

  assert.equal(config.notGrouped, 'bottom');
  assert.ok(Array.isArray(config.groupings));
  assert.ok(config.groupings.length > 0);
  assert.ok(config.groupings.some((group) => group.title === 'React'));
  assert.ok(config.groupings.some((group) => group.title === 'CI'));
});
