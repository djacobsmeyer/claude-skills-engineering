# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Repository Purpose

This is a curated marketplace of Claude Code Skills and plugins for personal use and experimentation. It serves as both a plugin marketplace and a development reference for creating Claude Code skills.

## Architecture Overview

### Core Concepts

**Claude Code Skills** are modular capabilities that extend Claude's functionality. Unlike slash commands (user-invoked), skills are **model-invoked** — Claude autonomously decides when to use them based on relevance to the user's request.

**Key principle**: Skills use progressive disclosure to manage context efficiently:
1. **Metadata (Level 1)**: YAML frontmatter with `name` and `description` — always loaded at startup (~100 tokens per skill)
2. **Instructions (Level 2)**: Main SKILL.md content — loaded when Claude determines relevance
3. **Resources (Level 3)**: Supporting files, scripts, templates — loaded only when referenced

This architecture allows many skills to be installed without context overhead.

### Repository Structure

```
claude-skill-plugins/
├── .claude-plugin/
│   └── marketplace.json          # Marketplace metadata & plugin registry
├── plugins/
│   ├── create-new-skills/        # Meta-skill for creating new skills
│   │   ├── SKILL.md              # Main skill definition
│   │   └── docs/                 # Progressive disclosure of detailed docs
│   └── [other-skills]/
├── README.md                      # Main marketplace documentation
├── QUICK_START.md                 # Quick 5-minute skill creation guide
├── PLUGIN_DEVELOPMENT.md          # Comprehensive skill development guide
└── CONTRIBUTING.md               # Contribution guidelines
```

### Plugin Directory Structure

Each plugin follows this pattern (minimal to complex):

```
plugins/your-skill/
├── SKILL.md                      # Required: Skill metadata & main instructions
├── docs/                         # Optional: Additional documentation
│   ├── advanced.md              # Advanced features/workflows
│   ├── reference.md             # API/detailed reference
│   └── guide.md                 # Extended guides
├── scripts/                      # Optional: Executable utilities
│   ├── helper.py
│   └── validator.sh
├── templates/                    # Optional: Template files
│   └── template.txt
└── examples/                     # Optional: Example usage files
    └── example.md
```

## Creating and Modifying Skills

### Essential Files for Skill Development

1. **SKILL.md** (required)
   - YAML frontmatter: `name`, `description`, optional `allowed-tools`
   - Instructions section: Prerequisites, Workflow, Supporting details
   - Examples section: 2-4 concrete usage examples
   - Should be under 5k tokens for core content

2. **marketplace.json** (for marketplace registration)
   - Must be updated whenever a new plugin is added
   - Required fields: `name`, `source`
   - Recommended fields: `description`, `version`, `author`, `keywords`

3. **Supporting documentation** (progressive disclosure)
   - Use separate files for advanced features to keep SKILL.md focused
   - Reference via relative paths: `[advanced.md](advanced.md)`

### Key Guidelines for Descriptions

The description is critical for skill discovery. It must:
- State what the skill does (specific, not vague)
- Include when Claude should use it (trigger conditions)
- Mention keyword phrases users would encounter
- Be under 1024 characters

**Good examples**:
- "Extract text and tables from PDF files, fill forms, merge documents. Use when working with PDF files or when the user mentions PDFs, forms, or document extraction."
- "Analyze Excel spreadsheets, create pivot tables, and generate charts. Use when working with Excel files, spreadsheets, or analyzing tabular data in .xlsx format."

**Bad examples**:
- "Helps with documents" (vague, no trigger words)
- "For files" (too generic)

### Naming Conventions

- Use lowercase with hyphens: `code-reviewer`, `pdf-processor`, `data-validator`
- Be descriptive but concise
- Avoid generic terms like `tool`, `util`, `stuff`

## Common Development Tasks

### Adding a New Skill to the Marketplace

1. Create skill directory: `mkdir -p plugins/your-skill-name`
2. Write `SKILL.md` with proper YAML frontmatter and content sections
3. Create supporting files in `docs/`, `scripts/`, or `templates/` as needed
4. Update `.claude-plugin/marketplace.json` with a new plugin entry
5. Test by asking Claude questions that match the skill description
6. Commit: `git add plugins/your-skill-name .claude-plugin/marketplace.json && git commit -m "Add your-skill-name plugin"`

### Testing a Skill

**Automated checks**:
```bash
# Verify SKILL.md exists
ls -la plugins/your-skill/SKILL.md

# Check YAML syntax (first 10 lines should be valid)
head -n 10 plugins/your-skill/SKILL.md

# Validate marketplace.json is valid JSON
python3 -m json.tool .claude-plugin/marketplace.json
```

**Manual testing**:
1. Ask Claude a question matching the skill's description
2. Verify Claude uses the skill (look for skill activation)
3. Walk through the instructions yourself — do they work?
4. Refine based on Claude's behavior

### Debugging Skills That Claude Doesn't Use

| Issue | Solution |
|-------|----------|
| Description too vague | Make specific: "Extract tables from PDFs" not "Helps with documents" |
| Missing trigger words | Include exact phrases users would type |
| YAML syntax error | Validate first 10 lines: `head -n 10 plugins/your-skill/SKILL.md` |
| Wrong file path | Ensure skill at `.claude/skills/name/SKILL.md` (project) or `~/.claude/skills/name/SKILL.md` (personal) |
| Instructions unclear | Use numbered steps, add code examples, state expected outcomes |

## Important Files and Their Purposes

- **README.md**: Main marketplace overview, skill organization, best practices
- **QUICK_START.md**: 5-minute skill creation template and checklist
- **PLUGIN_DEVELOPMENT.md**: Comprehensive guide covering skill architecture, progressive disclosure, testing, and best practices
- **CONTRIBUTING.md**: Contributor guidelines, skill structure requirements, submission process
- **plugins/create-new-skills/**: Meta-skill example with comprehensive documentation

## File Path Conventions

- Always use **relative paths** in markdown: `[file.md](file.md)` not `/absolute/path`
- Always use **forward slashes**: `scripts/helper.py` not `scripts\helper.py`
- Verify referenced files exist in the skill directory

## Marketplace Registration

When adding a skill to the marketplace:

1. Update `.claude-plugin/marketplace.json` with entry:
```json
{
  "name": "your-skill-name",
  "source": "./plugins/your-skill-name",
  "description": "What this skill does",
  "version": "1.0.0",
  "author": "Your Name",
  "keywords": ["keyword1", "keyword2"]
}
```

2. Required fields: `name`, `source`
3. Recommended fields: `description`, `version`, `author`, `keywords`

## Progressive Disclosure Pattern

When creating complex skills:

1. **SKILL.md** (common case, under 5k tokens)
   - Core workflow
   - Basic instructions
   - 2-4 essential examples

2. **docs/advanced.md** (advanced features)
   ```markdown
   For advanced usage, see [advanced.md](advanced.md).
   ```

3. **docs/reference.md** (detailed API/reference)
   ```markdown
   For detailed API reference, see [reference.md](reference.md).
   ```

4. **scripts/** (executable utilities)
   - Deterministic operations
   - Clear input/output
   - Document usage in SKILL.md

Claude only reads additional files when needed, keeping context efficient.

## Skill Scope Guidelines

**Focused skills** (✓ good):
- "PDF form filling"
- "Excel data analysis"
- "Git commit message helper"

**Too broad** (✗ split into multiple skills):
- "Document processing" (split by document type)
- "Data tools" (split by data type or operation)
- "General coding assistance" (too vague, better as specific tools)

## Common Skill Patterns

### Pattern 1: Simple Single-File Skill
- Just SKILL.md
- No supporting files
- Under 5k tokens
- Best for focused, single-purpose capabilities

### Pattern 2: Read-Only Skill
```yaml
---
name: Code Reader
description: Read and analyze code without modifying
allowed-tools: Read, Grep, Glob
---
```

### Pattern 3: Multi-File Skill
- SKILL.md for common case
- docs/advanced.md for advanced features
- docs/reference.md for API reference
- scripts/ for utilities

## Validation Checklist Before Committing

- [ ] SKILL.md has valid YAML frontmatter (`name` and `description`)
- [ ] Description is specific with trigger words/phrases
- [ ] Instructions are clear, numbered, and actionable
- [ ] At least 2 concrete examples provided
- [ ] Skill has been tested (Claude successfully uses it)
- [ ] All file paths use relative references with forward slashes
- [ ] Supporting files are referenced correctly
- [ ] marketplace.json entry is added with required fields
- [ ] Naming follows conventions (lowercase, hyphens)
- [ ] No unnecessary files committed (.DS_Store, __pycache__, .pyc, etc.)

## Resources

- **Official Claude Code Docs**: https://docs.claude.com/en/docs/claude-code/overview
- **Skills Best Practices**: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices
- **Agent Skills Guide**: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview
- **Claude Code Plugins**: https://docs.claude.com/en/docs/claude-code/plugins
- **Plugin Marketplaces**: https://docs.claude.com/en/docs/claude-code/plugin-marketplaces

## Key Differences: Skills vs Slash Commands

- **Skills**: Model-invoked, Claude autonomously uses them when relevant
- **Slash commands**: User-invoked, explicitly triggered with `/command`
- **Skills require clear descriptions** so Claude knows when to use them
- **Skills can be composed** — multiple skills working together

## Marketplace Distribution Scope

- **Claude Code**: Skills available via local installation (project `.claude/skills/` or personal `~/.claude/skills/`)
- **Plugins**: Distributed via marketplaces like this one
- **Sharing**: Project skills automatically shared via git with team
