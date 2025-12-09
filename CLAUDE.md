# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

This is a collection of Claude Code plugins organized as a marketplace. The project provides custom AI agents, Git workflow commands, MCP server configurations, and specialized development skills to enhance development workflows.

## Architecture

### Plugin Structure

The project follows a marketplace architecture where each plugin is self-contained:

```bash
oh-my-claude-code-plugins/
├── .claude-plugin/marketplace.json    # Plugin registry configuration
└── plugins/                          # Plugin directories
    ├── subagents/                    # AI agent definitions
    ├── git/                         # Git workflow commands
    ├── git-flow/                    # Git Flow automation
    ├── mcp/                         # MCP server configurations
    └── skills/                      # Development skills
```

### Plugin Components

1. **Agents** (`plugins/subagents/agents/`): Specialized AI agents with specific roles and tool permissions
2. **Commands** (`plugins/*/commands/`): Slash commands with YAML frontmatter defining permissions and arguments
3. **Hooks** (`plugins/git-flow/hooks/`): Event-driven automation triggers
4. **MCP Servers** (`plugins/mcp/servers.json`): External service integrations
5. **Skills** (`plugins/skills/*/`): Specialized development workflows and capabilities

### Agent Architecture

The plugin implements a multi-agent system with role-based permissions:

- **strategic-planner**: Architecture and design (no code execution)
- **task-executor**: Atomic task implementation (full tool access)
- **code-reviewer**: Quality assurance and security review
- **steering-architect**: Project analysis and documentation
- **data-scientist**: SQL queries and data analysis
- **debugger**: Error troubleshooting and root cause analysis
- **prd-writer**: Product requirements documentation

### Specification-Driven Workflow

The project implements a three-phase development workflow:

1. **Planning Phase**: Creates specs in `specs/<feature>/` directory
   - `requirements.md`: User stories and acceptance criteria
   - `design.md`: Technical blueprint with Mermaid diagrams
   - `tasks.md`: Granular task checklist

2. **Execution Phase**: Tasks executed atomically with progress tracking

3. **Review Phase**: Automated quality assurance

## Development Commands

### Plugin Installation

```bash
# Install from marketplace
claude plugin marketplace add huangdijia/oh-my-claude-code-plugins

# Install individual plugins
claude plugin install subagents@oh-my-claude-code-plugins
claude plugin install git@oh-my-claude-code-plugins
claude plugin install git-flow@oh-my-claude-code-plugins
claude plugin install mcp@oh-my-claude-code-plugins
claude plugin install skills@oh-my-claude-code-plugins
```

### Using the Plugins

**AI Agents:**

```bash
# Strategic planning
Use the strategic-planner agent to help me plan [feature]

# Task execution
Use the task-executor agent to implement the next task from specs/[feature]/tasks.md

# Code review
Use the code-reviewer agent to review my recent changes

# Feature development skill
Use the feature-dev skill to help me implement [feature]

# Code review skill
Use the code-review skill to review my recent changes
```

**Git Commands:**

```bash
/git:feature <name>          # Create feature branch
/git:hotfix <name>          # Create hotfix branch
/git:flow-status            # Check Git Flow status
```

**Git Flow Automation:**

```bash
/git-flow:commit:create     # Generate semantic commit
/git-flow:pr:create         # Create pull request
/git-flow:pr:review <id>    # Review PR
/git-flow:mr:create         # Create merge request
/git-flow:mr:review <id>    # Review merge request
```

## Configuration Files

### Marketplace Registration

- `.claude-plugin/marketplace.json`: Plugin registry with metadata

### Agent Permissions

Each agent has specific tool permissions defined in YAML frontmatter:

- `tools`: Comma-separated list of allowed tools
- `description`: Agent role and capabilities

### Command Structure

Commands use YAML frontmatter with:

- `allowed-tools`: Specific tools and patterns (e.g., `Bash(git:*)`)
- `argument-hint`: Expected argument format
- `description`: Command purpose

### Hook Configuration

Hooks are JSON files with:

- `hooks`: Event types (e.g., `PostToolUse`)
- `matcher`: Tool patterns to match
- `command`: Shell commands to execute

### MCP Servers

`plugins/mcp/.mcp.json` configures external integrations requiring:

- `CONTEXT7_API_KEY`: For documentation retrieval
- `TAVILY_API_KEY`: For web search
- `MEMORY_FILE_PATH`: Persistent knowledge storage (optional, defaults to `${CLAUDE_PROJECT_DIR}/.claude/memory.json`)

## Important Notes

### Language Support

- Several components output in Chinese for the target user base
- Agent instructions are bilingual where appropriate

### File Naming Quirks

- Note: The debugger agent filename has been corrected from `debuger.md` to `debugger.md`
- Hook reference in marketplace has typo: `aut-git-add.json` vs `auto-git-add.json`

### Git Flow Integration

The plugins assume Git Flow branching model:

- `main`: Production branch
- `develop`: Integration branch
- `feature/*`: Feature branches
- `hotfix/*`: Emergency fixes

### Agent Workflow Pattern

The multi-agent system follows a strict pattern:

1. Always use strategic-planner for design decisions
2. Use task-executor for implementation (one task at a time)
3. Use code-reviewer after significant changes
4. Never skip phases in the workflow

### Security Considerations

- Agents have restricted tool access based on roles
- No agent has unrestricted system access
- Hooks use environment variables for sensitive data
- API keys are required for MCP servers
