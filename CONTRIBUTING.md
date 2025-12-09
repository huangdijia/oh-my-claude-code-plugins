# Contributing to Claude Code Plugins

Thank you for your interest in contributing to this project! This guide will help you get started.

## 🤝 How to Contribute

### Reporting Issues

If you find a bug or have a suggestion:

1. Check existing [issues](https://github.com/huangdijia/claude-code-plugins/issues)
2. Create a new issue with:
   - Clear title and description
   - Steps to reproduce (for bugs)
   - Expected vs actual behavior
   - Environment details

### Development Setup

1. Fork the repository
2. Clone your fork:
   ```bash
   git clone https://github.com/your-username/claude-code-plugins.git
   cd claude-code-plugins
   ```
3. Add upstream remote:
   ```bash
   git remote add upstream https://github.com/huangdijia/claude-code-plugins.git
   ```
4. Create a feature branch:
   ```bash
   git checkout -b feature/your-feature-name
   ```

## 📝 Contribution Guidelines

### Adding New Plugins

1. Create plugin directory under `plugins/`
2. Add `plugin.json` with metadata
3. Implement plugin functionality
4. Add plugin to `.claude-plugin/marketplace.json`
5. Update documentation

### Plugin Structure

Each plugin should follow this structure:

```
plugins/your-plugin/
├── plugin.json           # Plugin metadata
├── agents/              # AI agents (if any)
├── commands/            # Slash commands
├── hooks/               # Event hooks
└── skills/              # Skill definitions
```

### Metadata Requirements

All plugins must include:

- `name`: Unique plugin identifier
- `version`: Semantic version
- `description`: Clear functionality description
- `author`: Your name/contact
- `license`: License type
- `engines`: Claude Code version requirements

### Code Style

- Use YAML frontmatter for metadata
- Follow markdown best practices
- Include examples in documentation
- Use consistent naming conventions

## 🧪 Testing

Before submitting:

1. Test plugin functionality
2. Validate configuration:
   ```bash
   claude plugin validate
   ```
3. Check for linting errors:
   ```bash
   claude plugin lint
   ```
4. Test in fresh Claude Code session

## 📤 Submitting Changes

1. Commit your changes:
   ```bash
   git commit -m "feat: add new plugin for X"
   ```
2. Push to your fork:
   ```bash
   git push origin feature/your-feature-name
   ```
3. Create pull request

### Pull Request Requirements

- Clear title and description
- Link to related issues
- Test steps documented
- Screenshots if applicable
- Update documentation

## 🏷️ Release Process

Releases are automated using semantic-release:

- `feat:` - Feature (minor version)
- `fix:` - Bug fix (patch version)
- `docs:` - Documentation only (no version bump)
- `chore:` - Maintenance (no version bump)

## 📜 Code of Conduct

1. Be respectful and inclusive
2. Welcome newcomers
3. Focus on constructive feedback
4. Follow Claude Code terms of service

## 🎯 Priority Areas

We're especially interested in:

- New AI agents for specialized tasks
- Additional Git workflow automations
- More MCP server integrations
- Performance monitoring tools
- Security enhancement plugins

## 📞 Getting Help

- Create an issue for questions
- Check existing documentation
- Review Claude Code official docs

## 🏆 Recognition

Contributors will be:
- Listed in README.md
- Mentioned in release notes
- Invited to maintainer team (for significant contributions)

Thank you for contributing! 🙏