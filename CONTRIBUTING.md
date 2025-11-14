# Contributing to Claude Code Skills Marketplace

Thank you for your interest in contributing skills to this marketplace! This guide explains how to add your own Claude Code skills and plugins.

## Table of Contents

1. [Before You Start](#before-you-start)
2. [Skill Development](#skill-development)
3. [Testing](#testing)
4. [Submission](#submission)
5. [Code of Conduct](#code-of-conduct)

## Before You Start

### Prerequisites

- Basic understanding of Claude Code and how it works
- Familiarity with markdown and YAML syntax
- A skill you've tested and refined

### Resources

- **Quick Start**: [QUICK_START.md](QUICK_START.md) - Fast guide to creating skills
- **Development Guide**: [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md) - Comprehensive guidance with real examples
- **Marketplace README**: [README.md](README.md) - Overview and best practices
- **Skill Examples in This Marketplace:**
  - [create-new-skills](plugins/create-new-skills/SKILL.md) - Meta-skill with comprehensive docs
  - [book-authoring-suite](plugins/book-authoring-suite/) - Complex suite with guides + commands
  - [manage-worktrees-skill](plugins/manage-worktrees-skill/) - Skill with slash commands
  - [marketplace-manager](plugins/marketplace-manager/) - Focused validation skill
  - [video-processor](plugins/video-processor/) - Skill with production Python utilities

## Skill Development

### 1. Create Your Skill

Follow the guidelines in [QUICK_START.md](QUICK_START.md) or [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md):

```bash
mkdir -p plugins/your-skill-name
# Create SKILL.md with proper structure
```

### 2. Structure Your Skill

Recommended structure:

```
plugins/your-skill-name/
├── SKILL.md              # Required: Main skill definition
├── README.md             # Optional: Quick overview
├── docs/                 # Optional: Additional documentation
│   ├── advanced.md
│   └── reference.md
├── scripts/              # Optional: Executable utilities
│   └── helper.py
└── examples/             # Optional: Example files
    └── example.md
```

### 3. Write SKILL.md

Your `SKILL.md` must include:

**YAML Frontmatter:**
```yaml
---
name: Your Skill Name
description: Clear description including what it does and when to use it
---
```

**Content Sections:**
- `## Instructions` - Step-by-step guidance
- `## Examples` - At least 2 concrete examples

See [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md#skillmd-structure) for complete guidance.

### 4. Key Requirements

✅ **Must haves:**
- Valid YAML frontmatter with `name` and `description`
- Clear, specific description (include trigger words)
- Instructions that Claude can execute
- At least 2 examples
- Relative paths for file references

❌ **Avoid:**
- Vague descriptions like "Helps with X"
- SKILL.md files over 5k tokens (use supporting files instead)
- Absolute file paths
- Assuming dependencies are installed

### 5. Common Skill Patterns

Different skills work best with different structures. Choose based on your needs:

**Pattern 1: Simple Single-File Skill**
- Just SKILL.md
- Simple, focused capability
- Example: `marketplace-manager`

**Pattern 2: Skill with Supporting Documentation**
- SKILL.md + docs/
- Complex skill with progressive disclosure
- Example: `create-new-skills`

**Pattern 3: Skill with Utilities/Scripts**
- SKILL.md + scripts/
- Deterministic operations delegated to scripts
- Example: `video-processor`

**Pattern 4: Skill Suite with Multiple Components**
- Root SKILL.md + guides/ + commands/
- Large ecosystem of related features
- Example: `book-authoring-suite`

**Pattern 5: Skill with Slash Commands**
- SKILL.md + commands/
- Model-invoked skill + user-invoked commands
- Example: `manage-worktrees-skill`

See [Real-World Examples in PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md#real-world-examples-in-this-marketplace) for detailed explanations of each pattern.

## Testing

### 1. Verify Structure

```bash
# Check file exists
ls -la plugins/your-skill-name/SKILL.md

# View frontmatter
head -n 10 plugins/your-skill-name/SKILL.md
```

### 2. Manual Testing

1. Ask Claude a question that matches your skill's description
2. Verify Claude uses your skill
3. Follow the instructions yourself - do they work?
4. Refine based on Claude's behavior

### 3. Checklist

- [ ] SKILL.md has valid YAML frontmatter
- [ ] Description is specific with trigger words
- [ ] Instructions are clear and numbered
- [ ] At least 2 examples provided
- [ ] Skill works when Claude uses it
- [ ] All file paths use relative references
- [ ] No unnecessary files included
- [ ] Naming follows conventions (lowercase, hyphens)

## Submission

### 1. Update marketplace.json

Add your plugin entry to `.claude-plugin/marketplace.json`:

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

**Required fields:**
- `name` - Kebab-case identifier
- `source` - Path to your plugin directory

**Recommended fields:**
- `description` - What the skill does
- `version` - Semantic version (e.g., "1.0.0")
- `author` - Your name/org
- `keywords` - Search terms

### 2. Commit Your Changes

```bash
git add plugins/your-skill-name
git add .claude-plugin/marketplace.json
git commit -m "Add your-skill-name plugin"
```

Use a clear commit message:
- ✅ "Add pdf-processor plugin for PDF extraction"
- ❌ "Add stuff"

### 3. Review Your Submission

Before committing, verify:

```bash
# Check valid JSON
python3 -m json.tool .claude-plugin/marketplace.json

# View your changes
git diff --cached
```

## Naming Conventions

**For skill names:**
- Lowercase only
- Use hyphens to separate words
- Be descriptive but concise
- Avoid generic terms

**Examples:**
- ✅ Good: `code-reviewer`, `pdf-form-filler`, `data-validator`
- ❌ Poor: `Tool`, `my-skill`, `util`, `stuff`

## Best Practices

### Description Writing

Make your description compelling and specific:

```yaml
description: Extract text and tables from PDF files, fill forms, merge documents.
             Use when working with PDF files or when the user mentions PDFs,
             forms, or document extraction.
```

Include:
- What the skill does
- When Claude should use it
- Specific keywords users would mention

### Instruction Writing

Structure as numbered steps:

```markdown
## Instructions

### Prerequisites
- Required packages or setup

### Workflow

1. **Step one title**: Clear guidance
   - Sub-point
   - Options

2. **Step two title**: Clear guidance

3. **Step three title**: Clear guidance
```

### Example Writing

Provide concrete, realistic examples:

```markdown
### Example 1: Common use case

User request:
```
Specific request here
```

You would:
1. First action
2. Second action
   ```bash
   actual command or code
   ```
3. Final action

Result: What Claude produces
```

### File Organization

Use progressive disclosure:
- **SKILL.md** - Common case (under 5k tokens)
- **docs/** - Additional documentation
- **scripts/** - Executable utilities
- **examples/** - Example files

## Common Patterns

### Pattern 1: Simple skill
Best for focused, single-purpose capabilities.
- Single SKILL.md file
- No supporting files
- Clean, concise instructions

### Pattern 2: Read-only skill
Best for analysis without modification.
```yaml
---
name: Code Reader
description: Read and analyze code
allowed-tools: Read, Grep, Glob
---
```

### Pattern 3: Multi-file skill
Best for complex workflows.
```
skill/
├── SKILL.md
├── advanced.md
├── reference.md
└── scripts/
    └── helper.py
```

## Troubleshooting Common Issues

### Claude doesn't use my skill

**Likely cause**: Description too vague

**Solution**: Make your description more specific
- Include exact phrases users would type
- List specific use cases
- Example: "Extract tables from PDFs" not "Helps with documents"

### Claude uses the skill but can't execute

**Likely cause**: Unclear instructions

**Solution**:
- Use numbered steps
- Be explicit about what Claude should do
- Include code examples
- State expected outcomes

### Files not found

**Likely cause**: Incorrect paths

**Solution**:
- Use relative paths: `[file.md](file.md)`
- Use forward slashes: `scripts/helper.py`
- Verify files exist in your directory

## Review Process

1. **Automated checks**
   - Valid marketplace.json JSON
   - SKILL.md exists and is valid YAML
   - File paths are relative

2. **Manual review**
   - Description quality and specificity
   - Instruction clarity
   - Example quality
   - Overall usefulness

3. **Testing**
   - Claude successfully discovers the skill
   - Instructions work as described
   - Examples are realistic

## Questions or Issues?

1. Check [QUICK_START.md](QUICK_START.md) for quick answers
2. Review [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md) for detailed guidance
3. Look at existing skills in `plugins/` for examples
4. Check Claude Code docs at https://docs.claude.com/

## After Your Submission

Once your skill is added to the marketplace:

1. **Announce it** (optional) - Share what you built
2. **Gather feedback** - Ask users about their experience
3. **Iterate** - Update based on feedback
4. **Document changes** - Update version in marketplace.json

### Updating Your Skill

To update an existing skill:

1. Make changes to SKILL.md or supporting files
2. Update version number in marketplace.json
3. Commit with clear message: "Update your-skill-name to v1.1.0"

## License

By contributing to this marketplace, you agree that your skills are shared under the same license as this project. Ensure your skills don't include proprietary or restricted code.

## Code of Conduct

- Be respectful and professional
- Provide high-quality, tested skills
- Document your work clearly
- Be responsive to feedback
- Don't submit skills from untrusted sources
- Respect intellectual property and licenses

## Examples of Great Skills

Good skills to learn from:
- `plugins/create-new-skills/` - Comprehensive meta-skill
- Well-documented skills with supporting files
- Skills with clear, specific descriptions
- Skills with 3+ concrete examples

## Thank You!

Thank you for contributing to the Claude Code Skills Marketplace! Your skills help others extend Claude Code's capabilities and build specialized agents for their domains.

---

**Need help?** Check the resources above or refer to official Claude Code documentation at https://docs.claude.com/
