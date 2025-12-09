---
description: Update all documentation files (README.md, README_CN.md, AGENTS.md, CLAUDE.md) based on the latest repository state
allowed-tools: Read, Glob, Grep, Edit, Write
argument-hint: [optional] Specify which docs to update (readme|readme-cn|claude|agents|all)
---

# Update Documentation Command

## Context

This command scans the repository structure and updates all documentation files to ensure they reflect the current state of the codebase.

## Task

Update documentation files based on the latest repository structure and content.

### 1. Analyze Current Repository State

First, scan the repository structure to understand the current state:

```bash
# Check marketplace.json for plugin list
plugins/.claude-plugin/plugin.json
plugins/skills/.claude-plugin/plugin.json

# Find all markdown files in plugins
find plugins -name "*.md" -type f

# Find all JSON files in plugins
find plugins -name "*.json" -type f

# Check for any new plugin directories
ls -la plugins/
```

### 2. Update Documentation Files

Based on the argument provided, update the appropriate documentation files:

#### If "readme" or "all" is specified

- Update README.md with:
  - Latest plugin list from marketplace.json
  - New skills and their descriptions
  - Updated installation commands
  - Current project structure
  - Fixed any outdated references

#### If "readme-cn" or "all" is specified

- Update README_CN.md with same changes as README.md but in Chinese
- Maintain consistency with English version

#### If "claude" or "all" is specified

- Update CLAUDE.md with:
  - Latest plugin architecture
  - Updated installation instructions
  - New skill usage examples
  - Current file naming conventions

#### If "agents" or "all" is specified

- Update AGENTS.md with:
  - Latest file organization patterns
  - Updated testing procedures
  - New plugin references

### 3. Validation Steps

After updating documentation:

1. Verify all plugin paths in marketplace.json match actual directories
2. Check that all referenced files exist
3. Ensure consistency between all documentation files
4. Validate that installation commands include all plugins
5. Confirm project structure diagrams match reality

### 4. Special Updates

Check for and update:

- New plugins added to marketplace.json
- New agent files in plugins/subagents/agents/
- New commands in plugins/*/commands/
- New hooks in plugins/git-flow/hooks/
- New skills in plugins/skills/*/
- Any filename corrections (like debugger.md)

### 5. Output

Report what was updated:

- List of files modified
- Summary of changes made
- Any inconsistencies found and fixed

## Instructions

Execute the following steps:

1. Read the current marketplace.json to get the official plugin list
2. Scan the plugins directory to verify all plugins exist
3. Read each documentation file to understand its current state
4. Update files based on the argument or "all" if no argument
5. Validate all updates for consistency
6. Report the changes made

Begin by reading marketplace.json and scanning the repository structure.
