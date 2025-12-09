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

# Copy files using find to avoid issues with changing files
echo "Copying files..."
find . -maxdepth 1 \
    ! -name '.git' \
    ! -name '.github' \
    ! -name '*.tar.gz' \
    ! -name 'node_modules' \
    ! -name '.DS_Store' \
    ! -name '*.log' \
    -exec cp -r {} "$TEMP_DIR/claude-code-plugins/" \;

# Copy necessary metadata files
cp -r VERSION "$TEMP_DIR/claude-code-plugins/" 2>/dev/null || echo "VERSION file not found, skipping"

# Create the archive
echo "Creating archive..."
tar -czf "${ARCHIVE_NAME}.tar.gz" -C "$TEMP_DIR" claude-code-plugins

echo "✅ Archive created successfully: ${ARCHIVE_NAME}.tar.gz"
ls -lh "${ARCHIVE_NAME}.tar.gz"