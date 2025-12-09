#!/bin/bash
# Claude Code CLI Installation Script for GitHub Actions

set -e

echo "Installing Claude Code CLI..."

# Try to install using the official script
if command -v curl &> /dev/null; then
    # Download and run the installer in bash explicitly
    bash <(curl -fsSL https://claude.ai/install.sh) || {
        echo "Failed to install using official script, trying alternative method..."
        # Fallback method
        if [[ "$RUNNER_OS" == "Linux" ]]; then
            # For Linux runners
            mkdir -p ~/.local/bin
            wget -qO- https://claude.ai/install.sh | bash -s -- -p ~/.local/bin || {
                echo "Installing claude-code via npm as fallback..."
                npm install -g @anthropic-ai/claude-code
            }
        fi
    }
else
    echo "curl not available, cannot install Claude Code CLI"
    exit 1
fi

# Add to PATH
echo "$HOME/.local/bin" >> $GITHUB_PATH

# Verify installation
if command -v claude &> /dev/null; then
    echo "Claude Code CLI installed successfully"
    claude --version || echo "Version check failed but installation may have succeeded"
else
    echo "Claude Code CLI installation failed"
    exit 1
fi