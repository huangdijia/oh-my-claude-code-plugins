# GitHub Actions Workflows

This document describes the GitHub Actions workflows used to validate and maintain the oh-my-claude-code-plugins project.

## 🔄 Workflows Overview

### 1. Plugin Validation (`.github/workflows/validate.yml`)

**Triggers:**

- Push to `main` or `develop` branches
- Pull requests to `main` or `develop`
- Manual dispatch

**Validations:**

- ✅ Plugin configuration validation using `claude plugin validate .`
- ✅ JSON syntax checking
- ✅ YAML frontmatter validation
- ✅ Plugin structure verification
- ✅ Agent file validation
- ✅ Command file validation
- ✅ Hook file validation
- ✅ Documentation presence check

### 2. Pull Request Checks (`.github/workflows/pr-check.yml`)

**Triggers:**

- Pull request opened, synchronized, or reopened

**Checks:**

- ✅ Plugin configuration validation
- ✅ Breaking change detection
- ✅ Plugin dependency verification
- ✅ Lint checks (whitespace, formatting)
- ✅ Security scan (secret detection)
- ✅ Automated PR comment with change summary

### 3. Release (`.github/workflows/release.yml`)

**Triggers:**

- Git tag push (`v*`)
- Manual dispatch with version input

**Features:**

- ✅ Comprehensive validation before release
- ✅ Automatic release notes generation
- ✅ GitHub release creation
- ✅ Archive asset upload
- ✅ VERSION file update
- ✅ Dry run support for testing

### 4. Scheduled Health Check (`.github/workflows/health-check.yml`)

**Triggers:**

- Daily at 2 AM UTC
- Manual dispatch

**Monitoring:**

- ✅ Plugin health status
- ✅ Stale file detection
- ✅ Security audit
- ✅ Performance metrics collection
- ✅ External dependency checks (MCP packages)

## 📊 Validation Details

### Plugin Configuration Validation

The workflows validate:

1. **Marketplace Configuration** (`.claude-plugin/marketplace.json`)
   - Required fields presence
   - Plugin metadata consistency
   - Source file existence

2. **Plugin Metadata** (`plugins/*/plugin.json`)
   - JSON syntax
   - Required fields
   - Version format

3. **Agent Files** (`plugins/subagents/agents/*.md`)
   - YAML frontmatter validation
   - Required fields: `name`, `description`, `tools`
   - Tool permissions

4. **Command Files** (`plugins/*/commands/**/*.md`)
   - YAML frontmatter validation
   - Required fields: `allowed-tools` or `description`
   - Argument definitions

5. **Hook Files** (`plugins/*/hooks/*.json`)
   - JSON syntax validation
   - Hook configuration structure

## 🚀 Release Process

### Automated Release

1. Create and push a version tag:

   ```bash
   git tag v1.0.0
   git push origin v1.0.0
   ```

2. GitHub Actions will:
   - Validate the entire project
   - Generate release notes
   - Create GitHub release
   - Upload release archive
   - Update VERSION file

### Manual Release

1. Go to Actions tab in GitHub
2. Select "Release" workflow
3. Click "Run workflow"
4. Enter version number (e.g., `v1.0.0`)
5. Optionally enable dry run for testing

## 🔧 Troubleshooting

### Common Issues

1. **Validation Failures**
   - Check the workflow logs for specific error messages
   - Ensure all referenced files exist
   - Validate JSON/YAML syntax locally

2. **Permission Errors**
   - Ensure workflow has necessary permissions:
     - `contents: read` for validation
     - `contents: write` and `releases: write` for releases

3. **Claude Code CLI Issues**
   - The workflow installs Claude Code CLI automatically
   - Uses official installation script from claude.ai

### Local Testing

Before pushing changes, test locally:

```bash
# Validate plugin configuration
claude plugin validate .

# Check JSON syntax
find . -name "*.json" -exec jq . {} \;

# Test YAML frontmatter
npm install -g js-yaml
for file in plugins/**/*.md; do
  awk '/^---/{flag=1;next;flag&&/^---/{flag=0;next}flag' "$file" | js-yaml
done
```

## 📈 Metrics and Monitoring

The health check workflow collects:

- Number of agents, commands, and hooks
- Plugin health status
- External dependency availability
- Security scan results

## 🛡️ Security

The workflows include:

- Secret detection (basic pattern matching)
- Executable file permission checks
- Dependency validation for MCP packages
- No external credentials stored in workflows

## 🔄 Continuous Integration

All changes go through:

1. **Push Validation** - Ensures code quality on every push
2. **PR Validation** - Additional checks before merging
3. **Release Validation** - Comprehensive checks before release
4. **Health Monitoring** - Ongoing project health tracking
