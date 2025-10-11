# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Overview

This is a Claude Code plugin marketplace repository that provides custom agents and slash commands to extend Claude Code functionality. The main plugin is located in the `plugins/devtools/` directory.

## Project Structure

```bash
claude-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # Plugin registry configuration
└── plugins/
    └── devtools/                 # Main plugin directory
        ├── agents/               # Custom AI agent definitions
        │   ├── code-reviewer.md  # Code quality and security review agent
        │   ├── data-scientist.md # Data analysis and SQL specialist
        │   ├── debuger.md        # Error debugging specialist
        │   ├── prd-writer.md     # Product requirements document writer
        │   ├── steering-architect.md # Project analysis and documentation architect
        │   ├── strategic-planner.md  # Feature planning and technical design
        │   └── task-executor.md  # Precise task execution agent
        ├── commands/             # Slash command definitions
        │   ├── commit/
        │   │   └── create.md     # /commit:create command
        │   ├── mr/
        │   │   ├── create.md     # /mr:create command (GitLab)
        │   │   └── review.md     # /mr:review command (GitLab)
        │   └── pr/
        │       ├── create.md     # /pr:create command (GitHub)
        │       └── review.md     # /pr:review command (GitHub)
        └── hooks/                # Event hooks (empty)
```

## Architecture

### Plugin System

The plugin is registered via `.claude-plugin/marketplace.json` which defines the plugin source location and metadata. The `devtools` plugin contains:

1. **Agents** - Specialized AI personas with specific roles and tools
2. **Commands** - Slash commands that expand to predefined prompts
3. **Hooks** - Event-driven shell commands (currently unused)

### Agent Workflow Pattern

The repository implements a multi-agent workflow system with three primary phases:

#### Phase 1: Strategic Planning (strategic-planner agent)

- Analyzes requirements and creates technical designs
- Generates structured specs in `specs/<feature-name>/` directory:
  - `requirements.md` - User stories with EARS-compliant acceptance criteria
  - `design.md` - Technical blueprint with data models, APIs, and Mermaid diagrams
  - `tasks.md` - Granular task checklist with dependency ordering

#### Phase 2: Task Execution (task-executor agent)

- Implements one atomic task at a time from `tasks.md`
- Follows strict single-task discipline (surgical precision)
- Updates task status by marking checkboxes `[ ]` → `[x]`
- Supports autonomous mode for unattended execution
- Never anticipates future steps or uses new code before instructed

#### Phase 3: Quality Assurance (code-reviewer agent)

- Reviews code quality, security, and maintainability
- Runs after code changes are made
- Provides prioritized feedback (critical → warnings → suggestions)

### Supporting Agents

- **steering-architect**: Creates project governance files in `.ai-rules/`:
  - `product.md` - Product vision and target users
  - `tech.md` - Technology stack and testing commands
  - `structure.md` - File organization and naming conventions

- **data-scientist**: SQL queries, BigQuery operations, and data analysis

- **debugger**: Error troubleshooting and root cause analysis

- **prd-writer**: Product requirements documentation generation

### Slash Commands

Commands are markdown files with YAML frontmatter defining:

- `allowed-tools`: Restricted tool access for security
- `description`: Command purpose
- Dynamic context via shell commands: `!`git status``

#### Git Workflow Commands

- `/commit:create` - Create git commits from staged changes
- `/pr:create` - Create GitHub Pull Requests with branch management
- `/pr:review` - Review GitHub PRs with structured analysis (Chinese output)
- `/mr:create` - Create GitLab Merge Requests
- `/mr:review` - Review GitLab MRs (Chinese output with optional scope filtering)

The PR/MR review commands support optional parameters:

- `$LANGUAGE` - Target code language
- `$SCOPE` - Focus area (performance, security, style)

## Plugin Configuration

The plugin is configured in `.claude-plugin/marketplace.json`:

```json
{
  "name": "claude-code-plugins",
  "owner": {
    "name": "Developer"
  },
  "plugins": [
    {
      "name": "devtools",
      "source": "./plugins/devtools",
      "description": "Plugin under development",
      "category": "development"
    }
  ]
}
```

The `source` field must match the actual directory path (`./plugins/devtools`).

## Key Conventions

### Spec-Driven Development

When working on new features:

1. Run strategic-planner to create specs in `specs/<feature-name>/`
2. Review and approve requirements → design → tasks
3. Execute tasks one-by-one using task-executor
4. All tasks must maintain dependency order
5. Context files in `.ai-rules/` provide global project standards

### Task Execution Rules

When using task-executor agent:

- Execute exactly one task per iteration
- Read `.ai-rules/` files for project context
- Read `specs/<feature>/` files for feature context
- Check "Rules & Tips" section in tasks.md before starting
- Fix lint errors during editing
- Run tests before marking tasks complete
- Record only project-wide insights, not implementation details
- Never skip ahead or merge multiple tasks

### Agent Tool Restrictions

Each agent has specific tool access defined in frontmatter:

- `strategic-planner`: file_edit, file_search, web_search (NO code execution)
- `task-executor`: file_edit, bash, file_search
- `code-reviewer`: file_search, bash, file_edit
- `steering-architect`: file_edit, file_search, bash
- `data-scientist`: bash, file_search, file_edit
- `debugger`: file_search, file_edit, bash
- `prd-writer`: file_edit, web_search, file_search (NO code execution)

## Language Note

Several agents and commands output in Chinese (code-reviewer, pr:review, mr:review, and Chinese-language agent definitions). This is intentional for the target user base.

**Note:** The debugger agent filename is `debuger.md` (without 'g') while the agent name is `debugger`.
