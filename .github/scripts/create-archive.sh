#!/bin/bash
# Create release archive script

set -e

VERSION="$1"
ARCHIVE_NAME="claude-code-plugins-${VERSION#v}"

if [[ -z "$VERSION" ]]; then
    echo "Error: VERSION parameter is required"
    exit 1
fi

echo "Creating archive for version: $VERSION"
echo "Archive name: $ARCHIVE_NAME.tar.gz"

# Create a temporary directory
TEMP_DIR=$(mktemp -d)
echo "Working in temporary directory: $TEMP_DIR"

# Ensure temp directory is cleaned up on exit
trap 'rm -rf "$TEMP_DIR"' EXIT

# Create directory structure in temp
mkdir -p "$TEMP_DIR/claude-code-plugins"

# List what will be copied
echo "Files to be included:"
find . -type f -name "*.md" -o -name "*.json" -o -name "VERSION" -o -name "*.txt" | head -20

# Copy essential files
echo "Copying files..."

# Copy all markdown files (docs, README, etc.)
find . -maxdepth 1 -name "*.md" -type f -exec cp {} "$TEMP_DIR/claude-code-plugins/" \;

# Copy VERSION file
cp VERSION "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || echo "VERSION file not found"

# Copy .claude-plugin directory
cp -r .claude-plugin "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || echo ".claude-plugin directory not found"

# Copy plugins directory
cp -r plugins "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || echo "plugins directory not found"

# Copy any license files
cp -r LICENSE* "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || true

# Copy .gitignore if exists
cp .gitignore "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || true

# Verify files were copied
echo "Files copied to temp directory:"
find "$TEMP_DIR/claude-code-plugins" -type f | head -20

# Create the archive
echo "Creating archive..."
tar -czf "${ARCHIVE_NAME}.tar.gz" -C "$TEMP_DIR" claude-code-plugins

# Verify archive was created
if [[ -f "${ARCHIVE_NAME}.tar.gz" ]]; then
    echo "✅ Archive created successfully: ${ARCHIVE_NAME}.tar.gz"
    echo "Archive contents:"
    tar -tzf "${ARCHIVE_NAME}.tar.gz" | head -30
    ls -lh "${ARCHIVE_NAME}.tar.gz"
else
    echo "❌ Archive creation failed"
    exit 1
fi