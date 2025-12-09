# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a marketplace for Claude Code plugins, providing custom agents and slash commands to enhance development workflows. The repository contains four main plugins:

1. **subagents** - Specialized AI agents for development workflow
2. **git** - Git workflow commands
3. **git-flow** - Git Flow automation and PR/MR management
4. **mcp** - MCP server configurations

**Important**: This is a documentation-only repository with no build scripts, tests, or package.json. The plugins are configuration files (markdown/JSON) that get loaded by Claude Code.

## Plugin Architecture

The repository follows the Claude Code plugin marketplace structure:
- `.claude-plugin/marketplace.json` - Plugin registry configuration
- `plugins/{name}/` - Individual plugin directories
  - `agents/` - AI agent definitions (subagents plugin)
  - `commands/` - Slash command definitions (git/git-flow plugins)
  - `hooks/` - Event hook configurations (git-flow plugin)
  - `servers.json` - MCP server configurations (mcp plugin)

## Repository Structure

This is a **configuration-only repository** - all files are documentation or configuration:
- Plugin definitions are in Markdown format with YAML frontmatter
- Hooks and MCP configurations are in JSON format
- No compilation, build steps, or dependencies required
- Changes are applied immediately when plugins are installed in Claude Code

## Development Workflow

### Planning Phase
Use strategic-planner agent to create specs in `specs/<feature-name>/`:
- `requirements.md` - User stories and acceptance criteria
- `design.md` - Technical blueprint
- `tasks.md` - Granular task checklist

### Execution Phase
Use task-executor agent to implement tasks one-by-one with surgical precision.

### Review Phase
Use code-reviewer agent for automated quality assurance and security review.

## Common Commands

### Plugin Installation
```bash
# Install from marketplace
claude plugin marketplace add huangdijia/oh-my-claude-code-plugins

# Install individual plugins
claude plugin install subagents@oh-my-claude-code-plugins
claude plugin install git@oh-my-claude-code-plugins
claude plugin install git-flow@oh-my-claude-code-plugins
claude plugin install mcp@oh-my-claude-code-plugins
```

### Working with This Repository
```bash
# No build, test, or lint commands needed - this is a config-only repo

# Validate plugin configuration
claude plugin validate

# Test plugin locally (development)
claude plugin test ./plugins/subagents
```

### Agent Usage
```markdown
Use the strategic-planner agent to help me plan a feature
Use the task-executor agent to implement the next task from specs/feature/tasks.md
Use the code-reviewer agent to review my recent changes
```

### Git Workflow Commands
```bash
/git:feature <name>          # Create feature branch from develop
/git:hotfix <name>          # Create hotfix branch from main
/git:flow-status            # Display Git Flow status
/git-flow:commit:create     # Generate semantic commits
/git-flow:pr:create         # Create Pull Requests
/git-flow:pr:review <id>    # Review PR with structured analysis
/git-flow:mr:create         # Create Merge Requests
/git-flow:mr:review <id>    # MR review with customizable scope
```

### Project Setup
Use steering-architect agent to initialize project governance:
```markdown
Use the steering-architect agent to analyze this project
```

This creates `.ai-rules/` files for product vision, tech stack, and structure conventions.

## Agent Tool Access

Each agent has specific tool restrictions for security:
- **strategic-planner**: file_edit, file_search, web_search (no code execution)
- **task-executor**: file_edit, bash, file_search (code execution allowed)
- **code-reviewer**: file_search, bash, file_edit (code execution allowed)
- **steering-architect**: file_edit, file_search, bash (code execution allowed)
- **data-scientist**: bash, file_search, file_edit (code execution allowed)
- **debugger**: file_search, file_edit, bash (code execution allowed)
- **prd-writer**: file_edit, web_search, file_search (no code execution)

## Language Support

Several components output in Chinese for the target user base:
- Code review feedback
- PR/MR review analysis
- Agent instructions (bilingual)

Note: The debugger agent filename is `debuger.md` (without 'g') while the agent name is `debugger`.

## Hook Configuration

Git hooks are configured in `plugins/git-flow/hooks/`:
- `auto-git-add.json` - Automatically stage modified files
- `php-cs-fixer.json` - Auto-format PHP files on write/edit
- `smart-commit.json` - Intelligent commit message generation

## MCP Servers Configuration

Pre-configured MCP servers in `plugins/mcp/servers.json` requiring environment variables:
- **context7** - Documentation retrieval (requires `CONTEXT7_API_KEY`)
- **sequential-thinking** - Structured problem-solving (no API key required)
- **memory** - Persistent knowledge graph (uses `CLAUDE_PROJECT_DIR`)
- **tavily-mcp** - Web search and extraction (requires `TAVILY_API_KEY`)
- **chrome-devtools** - Browser automation (no API key required)