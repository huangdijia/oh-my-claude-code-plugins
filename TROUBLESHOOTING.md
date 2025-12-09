# Troubleshooting Guide

This document provides solutions to common issues with oh-my-claude-code-plugins.

## 🔧 Installation Issues

### Plugin Not Found

**Error**: `Plugin not found: subagents@oh-my-claude-code-plugins`

**Solutions**:
1. Verify marketplace is added:
   ```bash
   claude plugin marketplace list
   ```
2. Re-add marketplace:
   ```bash
   claude plugin marketplace add huangdijia/oh-my-claude-code-plugins
   ```
3. Refresh plugin cache:
   ```bash
   claude plugin refresh
   ```

### Permission Denied

**Error**: `Permission denied accessing plugin files`

**Solutions**:
1. Check file permissions:
   ```bash
   ls -la .claude-plugin/
   chmod 644 .claude-plugin/marketplace.json
   ```
2. Verify ownership:
   ```bash
   sudo chown -R $USER:$USER .claude-plugin/
   ```

## 🤖 Agent Issues

### Agent Not Responding

**Symptoms**: Agent outputs nothing or generic response

**Solutions**:
1. Check agent file exists and is readable
2. Verify YAML frontmatter is valid:
   ```yaml
   ---
   name: agent-name
   description: ...
   tools: ...
   ---
   ```
3. Check for syntax errors in agent instructions

### Agent Tools Not Working

**Symptoms**: Agent reports tool not available

**Solutions**:
1. Verify tools are listed in agent frontmatter
2. Check Claude Code has necessary permissions
3. Ensure correct tool names are used

## ⚡ Command Issues

### Command Not Found

**Error**: `/git:feature command not found`

**Solutions**:
1. Verify plugin is installed:
   ```bash
   claude plugin list
   ```
2. Check command file exists:
   ```bash
   ls plugins/git/commands/
   ```
3. Validate YAML frontmatter in command file

### Arguments Not Passed

**Symptoms**: Command says no arguments provided

**Solutions**:
1. Check `argument-hint` in frontmatter
2. Verify command usage format:
   ```bash
   /git:feature my-feature-name
   ```
3. Look for argument parsing errors

## 🔌 MCP Issues

### Server Connection Failed

**Error**: `Failed to start MCP server: context7`

**Solutions**:
1. Check required environment variables:
   ```bash
   echo $CONTEXT7_API_KEY
   ```
2. Verify npm package exists:
   ```bash
   npx -y @upstash/context7-mcp --version
   ```
3. Check network connectivity

### Environment Variables Missing

**Symptoms**: MCP server fails to start with env error

**Solutions**:
1. Set missing variables:
   ```bash
   export CONTEXT7_API_KEY=your_key_here
   export TAVILY_API_KEY=your_key_here
   ```
2. Add to shell profile:
   ```bash
   echo 'export CONTEXT7_API_KEY=your_key_here' >> ~/.zshrc
   ```
3. Use `.env` file:
   ```bash
   echo "CONTEXT7_API_KEY=your_key_here" > .env
   ```

## 🪝 Hook Issues

### Hooks Not Triggering

**Symptoms**: Git hooks not executing

**Solutions**:
1. Verify hook file exists:
   ```bash
   ls plugins/git-flow/hooks/
   ```
2. Check JSON syntax:
   ```bash
   cat plugins/git-flow/hooks/smart-commit.json | jq .
   ```
3. Test hook manually:
   ```bash
   # Edit a file and check if commit is created
   echo "test" >> test.txt
   ```

### Hook Command Fails

**Error**: Hook command exits with non-zero status

**Solutions**:
1. Test command manually
2. Check required tools are installed
3. Verify file paths in command
4. Check environment variables

## 📦 Plugin Management

### Update Issues

**Error**: `Plugin update failed`

**Solutions**:
1. Remove and reinstall:
   ```bash
   claude plugin remove subagents
   claude plugin install subagents@oh-my-claude-code-plugins
   ```
2. Clear plugin cache:
   ```bash
   claude plugin cache clean
   ```

### Version Conflicts

**Symptoms**: Multiple versions causing conflicts

**Solutions**:
1. Check installed versions:
   ```bash
   claude plugin list --versions
   ```
2. Remove conflicting versions:
   ```bash
   claude plugin remove plugin-name@version
   ```
3. Reinstall specific version:
   ```bash
   claude plugin install plugin-name@version
   ```

## 🐛 Debug Mode

Enable debug logging:

```bash
export CLAUDE_DEBUG=1
export CLAUDE_LOG_LEVEL=debug
```

Check logs:
```bash
tail -f ~/.claude/logs/claude.log
```

## 📞 Getting Help

If issues persist:

1. Check [GitHub Issues](https://github.com/huangdijia/oh-my-claude-code-plugins/issues)
2. Create new issue with:
   - Claude Code version
   - Plugin version
   - Error message
   - Steps to reproduce
   - System information

3. Include debug logs:
   ```bash
   claude --version
   claude plugin list
   ```

## 🔍 Common Fixes

### Reset Everything

```bash
# Remove all plugins
claude plugin remove --all

# Clear cache
claude plugin cache clean

# Reinstall
claude plugin marketplace add huangdijia/oh-my-claude-code-plugins
claude plugin install subagents@oh-my-claude-code-plugins
claude plugin install git@oh-my-claude-code-plugins
claude plugin install git-flow@oh-my-claude-code-plugins
claude plugin install mcp@oh-my-claude-code-plugins
```

### Validate Configuration

```bash
# Check marketplace.json
cat .claude-plugin/marketplace.json | jq .

# Validate plugin.json files
find plugins/ -name plugin.json -exec echo "Checking {}" \; -exec cat {} \;
```