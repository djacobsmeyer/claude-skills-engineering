---
name: directory-tree-viewer
description: Display directory structure as a formatted tree. Use when the user needs to visualize a directory structure, analyze folder organization, or share a file tree view. Supports custom paths via the /tree command.
allowed-tools: Bash, Read
---

# Directory Tree Viewer

A skill for generating visual representations of directory structures in various formats. Useful for understanding project layout, documenting folder organization, or visualizing file hierarchies.

## Features

- Display directory trees with visual formatting
- Support for custom paths via slash command
- Ignore common build/dependency directories by default
- Multiple output formats (text tree, indented, etc.)

## Prerequisites

- No special dependencies required
- Works with any directory on the system
- The slash command `/tree` provides convenient path-based access

## Workflow

### Basic Usage: Current Working Directory

When you need to see the structure of the current working directory, use the Bash tool with the `tree` command:

```bash
tree -L 3 -a
```

This displays up to 3 levels of the directory structure with all files (including hidden ones).

### Advanced Usage: Custom Path via /tree Command

Use the custom slash command `/tree` with a file path argument to view any directory:

```
/tree /path/to/directory
```

The slash command accepts optional arguments:
- Path (required): The directory to visualize
- Depth (optional): Number of levels to display (default: 3)

### Tree Command Options

Common options when using the `tree` command directly:

- `-L N`: Limit depth to N levels
- `-a`: Show all files including hidden ones
- `-I 'pattern'`: Ignore files matching pattern
- `-d`: Directories only
- `-h`: Human-readable file sizes

## Examples

### Example 1: View Plugin Directory Structure

Display the structure of the current plugins directory:

```bash
tree -L 2 plugins/
```

Output shows all plugins and their first-level contents.

### Example 2: Use /tree Command with Custom Path

Ask Claude to show the structure of a specific directory:

> "Show me the structure of the src directory"

Claude will invoke: `/tree src`

### Example 3: Deep Directory Exploration

Explore nested structures with multiple levels:

```bash
tree -L 5 -I 'node_modules|.git|dist'
```

This shows up to 5 levels while excluding common dependency/build directories.

### Example 4: File-Only Tree

Display only files without directories:

```bash
tree -f --dirsfirst
```

## Troubleshooting

**Tree command not available**: The `tree` command may not be installed on all systems. Use `ls -R` as a fallback:

```bash
ls -R /path/to/directory
```

**Too much output**: Reduce depth with `-L 2` or filter with `-I 'pattern'`

**Permission denied**: Some directories may require elevated permissions. Use `ls -la` instead.

## See Also

- [Using Bash for file exploration](https://docs.claude.com/en/docs/claude-code/tools)
- [Glob patterns for file matching](https://docs.claude.com/en/docs/claude-code/tools)
