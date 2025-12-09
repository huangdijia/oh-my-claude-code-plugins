# Claude Code Plugins

A curated collection of custom agents and slash commands to enhance [Claude Code](https://claude.ai/code) with powerful development workflows. [中文版](README_CN.md)

## 🌟 Features

### 🤖 Specialized AI Agents (subagents plugin)

**Development Workflow Agents:**

- **strategic-planner** - Expert software architect for feature planning and technical design
- **task-executor** - Precision engineer for atomic task implementation
- **code-reviewer** - Automated code quality and security review specialist

**Supporting Agents:**

- **steering-architect** - Project analysis and documentation architect
- **data-scientist** - SQL queries, BigQuery operations, and data analysis
- **debugger** - Error troubleshooting and root cause analysis
- **prd-writer** - Product requirements document generation

### ⚡ Git Workflow Commands

**Git Flow Branch Management (git plugin):**

- `/git:feature <name>` - Create a new feature branch from develop
- `/git:hotfix <name>` - Create a new hotfix branch from main
- `/git:flow-status` - Display comprehensive Git Flow status

**GitHub (git-flow plugin):**

- `/git-flow:pr:create` - Create Pull Requests with automated branch management
- `/git-flow:pr:review` - Comprehensive PR code review with structured analysis

**GitLab (git-flow plugin):**

- `/git-flow:mr:create` - Create Merge Requests
- `/git-flow:mr:review` - MR review with customizable scope (performance, security, style)

**Git Commit (git-flow plugin):**

- `/git-flow:commit:create` - Generate semantic commits from staged changes

### 🔌 MCP Servers (mcp plugin)

Pre-configured MCP servers for enhanced capabilities:

- **context7** - Up-to-date documentation retrieval for any library
- **sequential-thinking** - Structured problem-solving through chain of thought
- **memory** - Persistent knowledge graph for conversation context
- **tavily-mcp** - Powerful web search and content extraction
- **chrome-devtools** - Browser automation and debugging

### 🛠️ Development Skills (skills plugin)

Specialized skills for specific development workflows:

- **feature-dev** - Guided feature development with codebase understanding and architecture focus
- **code-review** - Advanced code review capabilities for quality, security, and maintainability

### 🪝 Git Hooks (git-flow plugin)

Automated workflows triggered by events:

- **php-cs-fixer** - Auto-format PHP files on write/edit
- **auto-git-add** - Automatically stage modified files
- **smart-commit** - Intelligent commit message generation

## 📦 Installation

### Install from GitHub

1. Run the following command in Claude Code:

```bash
claude plugin marketplace add huangdijia/oh-my-claude-code-plugins
```

2. Install the plugins:

```bash
claude plugin install subagents@oh-my-claude-code-plugins
claude plugin install git@oh-my-claude-code-plugins
claude plugin install git-flow@oh-my-claude-code-plugins
claude plugin install mcp@oh-my-claude-code-plugins
claude plugin install skills@oh-my-claude-code-plugins
```

## 🚀 Quick Start

### Spec-Driven Development Workflow

This plugin implements a three-phase development workflow:

#### 1. Planning Phase

Use the strategic planner to design your feature:

```markdown
Use the strategic-planner agent to help me plan a user authentication feature
```

This creates structured specs in `specs/<feature-name>/`:

- `requirements.md` - User stories with acceptance criteria
- `design.md` - Technical blueprint with diagrams
- `tasks.md` - Granular task checklist

#### 2. Execution Phase

Execute tasks one-by-one with surgical precision:

```markdown
Use the task-executor agent to implement the next task from specs/user-auth/tasks.md
```

The agent will:

- Execute exactly one task at a time
- Update task checkboxes `[ ]` → `[x]`
- Run tests before marking complete
- Support autonomous mode for unattended execution

#### 3. Review Phase

Automated quality assurance:

```bash
Use the code-reviewer agent to review my recent changes
```

### Using Development Skills

**Feature Development:**

```markdown
Use the feature-dev skill to help me implement a user authentication system
```

**Code Review:**

```markdown
Use the code-review skill to review my recent changes
```

### Using Slash Commands

**Create a commit:**

```bash
/git-flow:commit:create
```

**Create and review PRs:**

```bash
/git-flow:pr:create
/git-flow:pr:review 123
```

**Review with specific scope:**

```bash
/git-flow:mr:review 456 performance
/git-flow:mr:review 789 security
```

## 📚 Documentation

### Agent Workflow Pattern

The plugin implements a sophisticated multi-agent system:

```bash
┌─────────────────────────────────────────────────────────┐
│  Phase 1: Strategic Planning                            │
│  → Analyze requirements                                 │
│  → Create technical designs                             │
│  → Generate task checklists                             │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  Phase 2: Task Execution                                │
│  → Execute one atomic task                              │
│  → Run tests and validation                             │
│  → Mark task complete                                   │
│  → Repeat for next task                                 │
└────────────────┬────────────────────────────────────────┘
                 │
┌────────────────▼────────────────────────────────────────┐
│  Phase 3: Quality Assurance                             │
│  → Review code quality                                  │
│  → Check security issues                                │
│  → Verify maintainability                               │
└─────────────────────────────────────────────────────────┘
```

### Project Initialization

Use the steering-architect agent to set up project governance:

```markdown
Use the steering-architect agent to analyze this project
```

This creates `.ai-rules/` files:

- `product.md` - Product vision and goals
- `tech.md` - Technology stack and commands
- `structure.md` - File organization conventions

### Tool Restrictions

Each agent has specific tool access for security:

| Agent | Tools | Code Execution |
|-------|-------|----------------|
| strategic-planner | file_edit, file_search, web_search | ❌ No |
| task-executor | file_edit, bash, file_search | ✅ Yes |
| code-reviewer | file_search, bash, file_edit | ✅ Yes |
| steering-architect | file_edit, file_search, bash | ✅ Yes |
| data-scientist | bash, file_search, file_edit | ✅ Yes |
| debugger | file_search, file_edit, bash | ✅ Yes |
| prd-writer | file_edit, web_search, file_search | ❌ No |

## 🏗️ Project Structure

```bash
oh-my-claude-code-plugins/
├── .claude-plugin/
│   └── marketplace.json          # Plugin registry
└── plugins/
    ├── subagents/                # AI agents plugin
    │   └── agents/               # AI agent definitions
    │       ├── code-reviewer.md
    │       ├── data-scientist.md
    │       ├── debugger.md
    │       ├── prd-writer.md
    │       ├── steering-architect.md
    │       ├── strategic-planner.md
    │       └── task-executor.md
    ├── git/                      # Git commands plugin
    │   └── commands/             # Slash commands
    │       ├── feature.md
    │       └── hotfix.md
    ├── git-flow/                 # Git Flow automation plugin
    │   ├── commands/             # Slash commands
    │   │   ├── commit/
    │   │   │   └── create.md
    │   │   ├── mr/
    │   │   │   ├── create.md
    │   │   │   └── review.md
    │   │   ├── pr/
    │   │   │   ├── create.md
    │   │   │   └── review.md
    │   │   └── status.md
    │   └── hooks/                # Event hooks
    │       ├── auto-git-add.json
    │       ├── php-cs-fixer.json
    │       └── smart-commit.json
    ├── mcp/                      # MCP servers plugin
    │   └── servers.json
    └── skills/                   # Development skills plugin
        ├── code-review/
        │   └── SKILL.md
        └── feature-dev/
            └── SKILL.md
```

## 🎯 Use Cases

### Feature Development

```text
1. Plan: Use strategic-planner to design feature
2. Build: Use task-executor to implement tasks
3. Review: Use code-reviewer to validate quality
```

### Code Review Automation

```bash
# Automated PR review with security focus
/git-flow:pr:review 123 security
```

### Project Setup

```markdown
# Initialize project documentation
Use the steering-architect agent to set up project standards
```

### Data Analysis

```markdown
# SQL and data analysis
Use the data-scientist agent to analyze user metrics from the database
```

## 🌐 Language Support

Several components output in Chinese for the target user base:

- Code review feedback
- PR/MR review analysis
- Agent instructions (bilingual)

**Note:** The debugger agent filename is `debugger.md` (with 'g') - the previous typo has been fixed.

## 📖 Advanced Usage

### Autonomous Task Execution

Enable autonomous mode for unattended task execution:

```markdown
Use the task-executor agent in autonomous mode to complete all remaining tasks
```

The agent will:

- Execute tasks sequentially without stopping
- Mark tasks complete automatically
- Only pause on errors or completion

### Custom Scope Reviews

Focus code reviews on specific aspects:

```bash
/git-flow:pr:review 123 performance    # Focus on performance issues
/git-flow:pr:review 456 security       # Focus on security vulnerabilities
/git-flow:pr:review 789 style          # Focus on code style and conventions
```

### Spec Management

Organize features with spec directories:

```bash
specs/
├── user-authentication/
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
├── payment-integration/
│   ├── requirements.md
│   ├── design.md
│   └── tasks.md
```

## ⚙️ Configuration

The plugin is registered in `.claude-plugin/marketplace.json`:

```json
{
  "name": "oh-my-claude-code-plugins",
  "owner": {
    "name": "Deeka Wong",
    "email": "huangdijia@gmail.com"
  },
  "plugins": [
    {
      "name": "subagents",
      "source": "./plugins/subagents",
      "description": "Boost your development workflow with AI-powered agents for code review, debugging, and strategic planning.",
      "category": "development"
    },
    {
      "name": "git",
      "source": "./plugins/git",
      "description": "Enhance your Git experience with Claude's Git plugin for seamless version control.",
      "category": "development"
    },
    {
      "name": "git-flow",
      "source": "./plugins/git-flow",
      "description": "Automate Git workflows with ease using GitFlow plugin for Claude.",
      "category": "development"
    },
    {
      "name": "mcp",
      "source": "./plugins/mcp",
      "description": "MCP (Model Context Protocol) for Claude Code, enabling advanced mcp interactions.",
      "category": "development"
    },
    {
      "name": "skills",
      "source": "./plugins/skills",
      "description": "Specialized development skills for feature development and code review workflows.",
      "category": "development"
    }
  ]
}
```

## 🤝 Contributing

Contributions are welcome! This repository is designed to be a marketplace for Claude Code plugins.

### Adding New Agents

1. Create a new `.md` file in `plugins/subagents/agents/`
2. Add YAML frontmatter with name, description, and tools
3. Define agent instructions in markdown

### Adding New Commands

1. Create a new `.md` file in appropriate plugin directory:
   - `plugins/git/commands/` for git commands
   - `plugins/git-flow/commands/` for git-flow commands
2. Add YAML frontmatter with allowed-tools and description
3. Define command prompt with dynamic context

### Adding New Hooks

1. Create a new `.json` file in `plugins/git-flow/hooks/`
2. Configure the hook event and command to execute

## 📄 License

MIT License - See LICENSE file for details

## 🔗 Links

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Plugin Development Guide](https://docs.claude.com/en/docs/claude-code/plugins)

## ✨ Credits

Developed by [@huangdijia](https://github.com/huangdijia)

---

**Note:** This plugin requires [Claude Code](https://claude.ai/code) to function. Make sure you have Claude Code installed and configured.
