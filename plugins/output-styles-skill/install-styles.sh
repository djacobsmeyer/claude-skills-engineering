#!/bin/bash

# Output Styles Installation Script
# Copies output style templates to ~/.claude/output-styles/

set -e

# Define source and destination
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SOURCE_DIR="$SCRIPT_DIR/output-styles"
DEST_DIR="$HOME/.claude/output-styles"

# Colors for output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

echo -e "${BLUE}Installing Claude Code Output Styles${NC}"
echo "Source: $SOURCE_DIR"
echo "Destination: $DEST_DIR"
echo ""

# Create destination directory if it doesn't exist
if [ ! -d "$DEST_DIR" ]; then
    echo -e "${YELLOW}Creating directory: $DEST_DIR${NC}"
    mkdir -p "$DEST_DIR"
fi

# Copy all style files
if [ ! -d "$SOURCE_DIR" ]; then
    echo -e "${YELLOW}Error: Source directory not found: $SOURCE_DIR${NC}"
    exit 1
fi

# Copy each style file
INSTALLED_COUNT=0
while IFS= read -r -d '' file; do
    filename=$(basename "$file")
    if cp "$file" "$DEST_DIR/$filename"; then
        echo -e "${GREEN}✓${NC} Installed: $filename"
        ((INSTALLED_COUNT++))
    fi
done < <(find "$SOURCE_DIR" -maxdepth 1 -type f -name "*.md" -print0)

echo ""
echo -e "${GREEN}✓ Installation complete!${NC}"
echo -e "Installed $INSTALLED_COUNT output styles to: $DEST_DIR"
echo ""
echo "Available styles:"
ls -1 "$DEST_DIR" | sed 's/^/  • /'
