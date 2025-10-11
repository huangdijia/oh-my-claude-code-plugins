# Claude Plugin Marketplace

A curated collection of custom agents and slash commands to enhance [Claude Code](https://claude.ai/code) with powerful development workflows.

## 🌟 Features

### 🤖 Specialized AI Agents

**Development Workflow Agents:**

- **strategic-planner** - Expert software architect for feature planning and technical design
- **task-executor** - Precision engineer for atomic task implementation
- **code-reviewer** - Automated code quality and security review specialist

**Supporting Agents:**

- **steering-architect** - Project analysis and documentation architect
- **data-scientist** - SQL queries, BigQuery operations, and data analysis
- **debuger** - Error troubleshooting and root cause analysis
- **prd-writer** - Product requirements document generation

### ⚡ Git Workflow Commands

**GitHub:**

- `/pr:create` - Create Pull Requests with automated branch management
- `/pr:review` - Comprehensive PR code review with structured analysis

**GitLab:**

- `/mr:create` - Create Merge Requests
- `/mr:review` - MR review with customizable scope (performance, security, style)

**Git:**

- `/commit:create` - Generate semantic commits from staged changes

## 📦 Installation

1. Clone this repository:

```bash
git clone https://github.com/huangdijia/claude-marketplace.git
cd claude-marketplace
```

2. The plugin will be automatically discovered by Claude Code through `.claude-plugin/marketplace.json`

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

### Using Slash Commands

**Create a commit:**

```bash
/commit:create
```

**Create and review PRs:**

```bash
/pr:create
/pr:review 123
```

**Review with specific scope:**

```bash
/mr:review 456 performance
/mr:review 789 security
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

## 🏗️ Project Structure

```bash
claude-marketplace/
├── .claude-plugin/
│   └── marketplace.json          # Plugin registry
└── devtools/                     # Main plugin
    ├── agents/                   # AI agent definitions
    │   ├── strategic-planner.md
    │   ├── task-executor.md
    │   ├── code-reviewer.md
    │   ├── steering-architect.md
    │   ├── data-scientist.md
    │   ├── debuger.md
    │   └── prd-writer.md
    ├── commands/                 # Slash commands
    │   ├── commit/
    │   ├── pr/
    │   └── mr/
    └── hooks/                    # Event hooks
```

## 🎯 Use Cases

### Feature Development

```
1. Plan: Use strategic-planner to design feature
2. Build: Use task-executor to implement tasks
3. Review: Use code-reviewer to validate quality
```

### Code Review Automation

```
# Automated PR review with security focus
/pr:review 123 security
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

```
/pr:review 123 performance    # Focus on performance issues
/pr:review 456 security       # Focus on security vulnerabilities
/pr:review 789 style          # Focus on code style and conventions
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

## 🤝 Contributing

Contributions are welcome! This repository is designed to be a marketplace for Claude Code plugins.

### Adding New Agents

1. Create a new `.md` file in `dev-tools/agents/`
2. Add YAML frontmatter with name, description, and tools
3. Define agent instructions in markdown

### Adding New Commands

1. Create a new `.md` file in `dev-tools/commands/<category>/`
2. Add YAML frontmatter with allowed-tools and description
3. Define command prompt with dynamic context

## 📄 License

MIT License - See LICENSE file for details

## 🔗 Links

- [Claude Code Documentation](https://docs.claude.com/en/docs/claude-code)
- [Plugin Development Guide](https://docs.claude.com/en/docs/claude-code/plugins)

## ✨ Credits

Developed by [@huangdijia](https://github.com/huangdijia)

---

**Note:** This plugin requires [Claude Code](https://claude.ai/code) to function. Make sure you have Claude Code installed and configured.
