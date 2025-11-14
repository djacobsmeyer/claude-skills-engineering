# Plugin Development Guide

This guide explains how to create and contribute skills/plugins to the Claude Code Skills Marketplace.

## Table of Contents

1. [Understanding Skills](#understanding-skills)
2. [Skill Architecture](#skill-architecture)
3. [Creating a Skill](#creating-a-skill)
4. [SKILL.md Structure](#skillmd-structure)
5. [Progressive Disclosure](#progressive-disclosure)
6. [Testing Skills](#testing-skills)
7. [Best Practices](#best-practices)
8. [Contributing to the Marketplace](#contributing-to-the-marketplace)

## Understanding Skills

### What is a Skill?

A Claude Code Skill is a directory containing a `SKILL.md` file with:
- **YAML frontmatter** - Metadata (name, description)
- **Instructions** - Procedural guidance for Claude
- **Supporting files** - Scripts, templates, documentation (optional)

### Model-Invoked vs User-Invoked

- **Skills** are **model-invoked** - Claude autonomously decides when to use them based on relevance
- **Slash commands** are **user-invoked** - You explicitly type `/command` to trigger them

This means skills require clear descriptions so Claude knows when to use them.

### Where Skills Live

In Claude Code, skills are stored in two locations:

**Personal Skills** (for individual use):
```
~/.claude/skills/
├── my-skill-1/
│   └── SKILL.md
└── my-skill-2/
    └── SKILL.md
```

**Project Skills** (for team collaboration via git):
```
.claude/skills/
├── team-skill-1/
│   └── SKILL.md
└── team-skill-2/
    └── SKILL.md
```

**Marketplace Plugins** (distributed via this repository):
```
plugins/
├── plugin-name-1/
│   └── SKILL.md
└── plugin-name-2/
    └── SKILL.md
```

## Skill Architecture

### The Three Levels of Progressive Disclosure

Skills use progressive disclosure to manage context efficiency:

#### Level 1: Metadata (Always Loaded)
- **Content**: YAML frontmatter (`name` and `description`)
- **When**: At startup
- **Token cost**: ~100 tokens per skill
- **Purpose**: Helps Claude discover when to use the skill

```yaml
---
name: Your Skill Name
description: What this does and when to use it
---
```

#### Level 2: Instructions (Loaded When Triggered)
- **Content**: Main body of SKILL.md
- **When**: When Claude decides the skill is relevant
- **Token cost**: Under 5k tokens
- **Purpose**: Procedural guidance and workflows

#### Level 3+: Resources (Loaded As Needed)
- **Content**: Supporting files, scripts, templates
- **When**: Only when referenced
- **Token cost**: Effectively unlimited
- **Purpose**: Reference materials and utilities

This architecture means:
- You can install many skills without context penalty
- Additional files don't consume tokens until accessed
- Skills can include comprehensive documentation without bloat

### Directory Structure

Minimal skill (single capability):
```
my-skill/
└── SKILL.md
```

Typical skill (with supporting documentation):
```
my-skill/
├── SKILL.md              # Main instructions
├── advanced.md           # Optional: Advanced usage
├── reference.md          # Optional: API reference
└── examples/             # Optional: Example files
    └── example.txt
```

Complex skill (with scripts and templates):
```
my-skill/
├── SKILL.md
├── docs/
│   ├── guide.md
│   └── reference.md
├── scripts/
│   ├── helper.py
│   └── validator.py
└── templates/
    ├── template1.txt
    └── template2.txt
```

## Creating a Skill

### Step 1: Plan Your Skill

Answer these questions:
1. **What capability** does this skill add?
2. **When should Claude use it?** (triggers/situations)
3. **What expertise** does it package?
4. **What supporting files** does it need?

Document your answers - they inform your description and structure.

### Step 2: Create the Directory

For this marketplace, create a new plugin directory:

```bash
mkdir -p plugins/your-skill-name
```

For naming conventions:
- Use lowercase with hyphens (e.g., `pdf-processor`, `code-reviewer`)
- Be descriptive but concise
- Avoid generic names

### Step 3: Write SKILL.md

Create `plugins/your-skill-name/SKILL.md` with three main sections:

```markdown
---
name: Your Skill Name
description: What this does and when to use it
---

# Your Skill Name

## Instructions

[Step-by-step guidance for Claude]

## Examples

[Concrete usage examples]
```

### Step 4: Add Supporting Files (Optional)

As your skill grows:
1. Keep SKILL.md focused (ideally under 5k tokens)
2. Create separate files for:
   - Advanced usage (`advanced.md`)
   - API reference (`reference.md`)
   - Detailed workflows (`workflows.md`)
3. Reference them in SKILL.md using relative paths

### Step 5: Create Scripts (Optional)

For deterministic operations, create executable scripts:

```bash
mkdir -p plugins/your-skill-name/scripts
```

Scripts should:
- Have clear input/output
- Return parseable results
- Include inline dependencies (for Python scripts)
- Be executable: `chmod +x scripts/*.py`

### Step 6: Write Documentation

Document your skill for users:
- What does it do?
- When should they use it?
- What are the prerequisites?
- What are common use cases?

### Step 7: Test the Skill

After creating your skill:

1. **Verify structure**: Check the file exists at the right path
2. **Check YAML**: Validate frontmatter syntax
3. **Test discovery**: Ask Claude questions matching your description
4. **Test execution**: Verify Claude can run through the workflow
5. **Refine**: Update description/instructions based on behavior

### Step 8: Commit and Register

For this marketplace:
1. Commit your skill to git
2. Update `.claude-plugin/marketplace.json` with your plugin entry
3. Submit a pull request or commit to main

## SKILL.md Structure

### YAML Frontmatter

Required fields:
```yaml
---
name: Skill Name              # Max 64 characters
description: Clear, specific  # Max 1024 characters. Include what AND when
---
```

Optional fields (Claude Code only):
```yaml
---
name: Skill Name
description: Description
allowed-tools: Read, Grep, Glob  # Restrict tool access if needed
---
```

### Description Best Practices

**Good description** (specific, includes when):
```
Extract text and tables from PDF files, fill forms, merge documents.
Use when working with PDF files or when the user mentions PDFs, forms, or document extraction.
```

**Bad description** (vague, unclear trigger):
```
Helps with documents
```

Your description should:
- State what the skill does
- Include trigger words/phrases Claude would encounter
- Be specific, not generic
- Help Claude decide when to use it

### Instructions Section

Structure as:
1. **Prerequisites** - Required setup, dependencies, tools
2. **Workflow** - Numbered steps for the process
3. **Additional context** - Error handling, variations, advanced usage

Example:
```markdown
## Instructions

### Prerequisites
- Requires `pypdf` and `pdfplumber` packages
- Works with PDF files only

### Workflow

1. **Extract text from PDF**:
   ```python
   import pdfplumber
   with pdfplumber.open("doc.pdf") as pdf:
       text = pdf.pages[0].extract_text()
   ```

2. **Process extracted text**:
   - Clean whitespace
   - Identify sections
   - Structure output

3. **Return results**:
   - Summary of extraction
   - Any warnings or issues
```

### Examples Section

Provide 2-4 concrete examples showing:
- Different use cases
- Various input types
- Step-by-step execution
- Expected outcomes

```markdown
## Examples

### Example 1: Extract Text from PDF

User request:
```
Extract all text from report.pdf
```

You would:
1. Use pdfplumber to extract text
2. Clean formatting
3. Present organized text
4. Suggest next steps
```

### Real-World Examples in This Marketplace

Learn from existing plugins:

**1. book-authoring-suite** - Complex skill with multiple components
- `plugins/book-authoring-suite/SKILL.md` - Root meta-skill with workflow overview
- `plugins/book-authoring-suite/guides/` - Progressive disclosure (5 detailed guides)
- `plugins/book-authoring-suite/commands/` - 5 slash commands for on-demand execution
- **Pattern**: Large suite split across guides + commands for both automatic and explicit control

**2. manage-worktrees-skill** - Skill with slash commands
- `plugins/manage-worktrees-skill/SKILL.md` - Autonomous worktree management skill
- `plugins/manage-worktrees-skill/commands/` - 3 commands for explicit control
- **Pattern**: Model-invoked skill complemented by slash commands for power users

**3. marketplace-manager** - Validation and maintenance skill
- `plugins/marketplace-manager/SKILL.md` - Comprehensive validation workflow
- **Pattern**: Focused skill with detailed, step-by-step procedures

**4. video-processor** - Skill with script utilities
- `plugins/video-processor/SKILL.md` - Video processing guidance
- `plugins/video-processor/scripts/video_processor.py` - Production Python script
- **Pattern**: Skill that delegates to robust utility scripts

**5. create-new-skills** - Meta-skill teaching skill creation
- `plugins/create-new-skills/SKILL.md` - Guidance for creating skills
- `plugins/create-new-skills/docs/` - Comprehensive documentation
- **Pattern**: Meta-skill with extensive supporting documentation

Each demonstrates different organizational patterns you can use in your own skills.

## Progressive Disclosure

Progressive disclosure is key to efficient skills. Here's how to structure it:

### Level 1: Metadata
```yaml
---
name: PDF Processing
description: Extract text and tables from PDF files, fill forms, merge documents.
             Use when working with PDFs, forms, or document extraction.
---
```

### Level 2: Core Instructions
Keep SKILL.md focused on common tasks:
```markdown
# PDF Processing

## Instructions

Quick text extraction workflow...

For form filling, see [FORMS.md](FORMS.md).
```

### Level 3: Supporting Files
Create separate files for specific scenarios:

`FORMS.md` - Form filling workflow
`REFERENCE.md` - Complete API reference
`scripts/extract_forms.py` - Utility script

Claude reads these only when relevant, keeping context efficient.

### When to Split Content

Move content to separate files when:
- SKILL.md exceeds 5k tokens
- Content is scenario-specific
- Multiple advanced workflows exist
- Detailed API reference is needed

## Testing Skills

### Automated Discovery Test

1. **Verify file structure**:
   ```bash
   ls -la plugins/your-skill/SKILL.md
   ```

2. **Check YAML syntax**:
   ```bash
   head -n 10 plugins/your-skill/SKILL.md
   ```

3. **Validate file paths** in SKILL.md references

### Manual Testing

1. **Ask discovery questions** - Ask Claude questions matching your description
2. **Observe Claude's behavior** - Does it use your skill?
3. **Test the workflow** - Do the instructions work as intended?
4. **Check for clarity** - Are steps clear and executable?

### Debugging

If Claude doesn't use your skill:

| Issue | Solution |
|-------|----------|
| Description too vague | Add specific triggers and use cases |
| YAML syntax error | Check frontmatter format |
| Wrong file path | Verify `.claude/skills/name/SKILL.md` |
| Instructions unclear | Simplify steps, add examples |

If skill has errors during execution:

| Issue | Solution |
|-------|----------|
| Dependencies missing | List in description, doc prerequisites |
| Script not executable | `chmod +x scripts/*.py` |
| File path issues | Use forward slashes, verify relative paths |

## Best Practices

### Scope and Focus

✅ **Focused**:
- "PDF form filling"
- "Excel data analysis"
- "Git commit messages"

❌ **Too broad**:
- "Document processing" (split into multiple skills)
- "Data tools" (split by data type or operation)

### Description Writing

✅ **Clear and specific**:
```
Analyze Excel spreadsheets, create pivot tables, and generate charts.
Use when working with Excel files, spreadsheets, or analyzing tabular data
in .xlsx format.
```

❌ **Vague**:
```
For files
```

Include:
- What the skill does
- When to use it
- Key trigger words

### File Organization

✅ **Progressive disclosure**:
```
skill/
├── SKILL.md           # Core workflow
├── advanced.md        # Advanced usage
└── reference.md       # Detailed reference
```

❌ **Everything in SKILL.md**:
- Bloats context window
- Makes instructions hard to follow
- Inefficient for common tasks

### Naming Conventions

✅ **Good names**:
- `pdf-form-filler` (clear purpose)
- `data-validator` (descriptive)
- `code-reviewer` (specific function)

❌ **Poor names**:
- `tool` (too generic)
- `util` (vague)
- `MySkill` (uppercase, unclear purpose)

### Documentation

Every skill should include:
- Clear description of what it does
- When Claude should use it
- Prerequisites and dependencies
- Step-by-step workflow
- Concrete examples
- Common patterns or edge cases

### Scripts Best Practices

If including scripts:

1. **Make them deterministic**:
   - Same input → same output
   - No random elements or external dependencies
   - Clear error messages

2. **Include dependencies** (Python example):
   ```python
   # /// script
   # requires-python = ">=3.10"
   # dependencies = ["pandas", "matplotlib"]
   # ///
   ```

3. **Return clear output**:
   - Parseable results
   - Meaningful error messages
   - Summary of actions taken

4. **Document usage** in SKILL.md:
   ```bash
   python scripts/analyzer.py input.csv
   ```

## Contributing to the Marketplace

### Adding Your Skill to This Marketplace

1. **Create your skill** following the guidelines above
2. **Test thoroughly** using the testing guidelines
3. **Update marketplace.json**:
   ```json
   {
     "name": "your-skill-name",
     "source": "./plugins/your-skill-name",
     "description": "What this skill does",
     "version": "1.0.0",
     "keywords": ["keyword1", "keyword2"]
   }
   ```
4. **Commit to git**:
   ```bash
   git add plugins/your-skill-name
   git add .claude-plugin/marketplace.json
   git commit -m "Add your-skill-name plugin"
   ```

### Marketplace.json Fields

Required:
- `name` - Kebab-case plugin identifier
- `source` - Path to plugin directory or git URL

Optional but recommended:
- `description` - What the plugin does
- `version` - Semantic version (e.g., "1.0.0")
- `author` - Your name or organization
- `keywords` - Search terms for discovery
- `homepage` - Link to documentation
- `repository` - Git repository URL
- `license` - License information

### Versioning

Follow semantic versioning:
- `MAJOR.MINOR.PATCH` (e.g., `1.2.3`)
- MAJOR: Breaking changes
- MINOR: New features
- PATCH: Bug fixes

### Documentation for Contributors

Each plugin should include:

1. **README.md** (optional) - Quick start and overview
2. **PLUGIN_README.md** - How to use this specific plugin
3. **In-SKILL.md docs** - Progressive disclosure of instructions
4. **Examples** - Concrete usage patterns

## Quick Reference

### Creating a Simple Skill

```bash
# 1. Create directory
mkdir -p plugins/my-skill

# 2. Create SKILL.md
cat > plugins/my-skill/SKILL.md << 'EOF'
---
name: My Skill
description: Does something useful. Use when user asks for X.
---

# My Skill

## Instructions

1. Step one
2. Step two
3. Step three

## Examples

### Example 1: Basic usage
User request: "Do thing X"
Result: ...
EOF

# 3. Test the skill
# Ask Claude: "Do thing X" - it should use your skill

# 4. Update marketplace.json
# Add your plugin entry

# 5. Commit
git add plugins/my-skill .claude-plugin/marketplace.json
git commit -m "Add my-skill plugin"
```

### Common Skill Patterns

**Pattern 1: Simple single-file skill**
- Single SKILL.md
- No supporting files
- Under 5k tokens

**Pattern 2: Skill with tool restrictions**
- Add `allowed-tools` to frontmatter
- Restrict Claude's capabilities
- Good for read-only or safe operations

**Pattern 3: Multi-file skill**
- Core SKILL.md with common tasks
- Separate files for advanced features
- Supporting scripts and templates
- Progressive disclosure

## Resources

- Official Skill Architecture: `plugins/create-new-skills/docs/claude_code_agent_skills_overview.md`
- Official Skill Guide: `plugins/create-new-skills/docs/claude_code_agent_skills.md`
- Design Principles: `plugins/create-new-skills/docs/blog_equipping_agents_with_skills.md`
- Claude Code Docs: https://docs.claude.com/en/docs/claude-code/overview
- Skills Best Practices: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices

## Summary

Creating effective Claude Code skills requires:

1. ✅ Clear descriptions with triggers
2. ✅ Focused, actionable instructions
3. ✅ Progressive disclosure of content
4. ✅ Concrete examples
5. ✅ Thorough testing
6. ✅ Clear documentation
7. ✅ Composable, reusable capabilities

Start simple, test early, iterate based on feedback. Your skills will transform Claude into a specialist for your domain.
