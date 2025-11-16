---
name: prime-skill
description: Quickly understand and load a codebase by examining repository structure, README, and AI documentation. Use when starting work on a new project, need to refresh context about how a project is organized, or want to get a quick overview of a codebase's architecture and purpose.
allowed-tools: Bash, Read, Glob
---

# Prime

Quickly understand and load a codebase context. This skill examines the repository structure, documentation, and AI docs to give you a comprehensive overview of how the project is organized and what it does.

## Prerequisites

- You're in a git repository or project directory
- The project has a README.md file
- Optionally, the project has an `ai_docs/` directory with additional documentation

## Workflow

1. **List repository files** - Get an overview of what's tracked in the repository
2. **Read main README** - Understand the project's purpose and structure
3. **Read AI documentation** - Load any additional AI-focused documentation if it exists
4. **Summarize understanding** - Provide a concise summary of the codebase

## Instructions

Execute these sections in order to understand the codebase:

1. Run `git ls-files` to see what's tracked
2. Read and analyze `@README.md` to understand project purpose
3. If available, read and analyze `@ai_docs/README.md` for technical architecture
4. Summarize your findings in a clear, structured format

## Examples

**Example 1: Priming a Node.js project**
```
User: Prime this codebase for me
Claude: [Lists files with git ls-files]
[Reads README.md]
[Reads ai_docs/README.md if exists]
Summary: This is a Node.js web application with...
```

**Example 2: Getting quick context**
```
User: I'm back on this project, what was it about?
Claude: [Executes prime workflow]
Summary: TypeScript-based CLI tool for...
```
