# Quick Start: Creating a Claude Code Skill

A quick reference guide to create your first Claude Code skill for this marketplace.

## TL;DR - 5-Minute Skill Creation

### 1. Create the directory
```bash
mkdir -p plugins/your-skill-name
```

### 2. Write SKILL.md
```markdown
---
name: Your Skill Name
description: Clear description of what this does and when to use it
---

# Your Skill Name

## Instructions

1. Step one with specific guidance
2. Step two with any prerequisites
3. Step three with expected output

## Examples

### Example: Describe the use case

User request:
```
Example user request here
```

You would:
1. Do this first step
2. Do this second step
3. Return clear result
```

### 3. Update marketplace.json
```bash
cat >> .claude-plugin/marketplace.json << 'EOF'
{
  "name": "your-skill-name",
  "source": "./plugins/your-skill-name",
  "description": "What this skill does",
  "version": "1.0.0"
}
EOF
```

### 4. Test it
Ask Claude a question matching your description. It should use your skill!

### 5. Commit
```bash
git add plugins/your-skill-name .claude-plugin/marketplace.json
git commit -m "Add your-skill-name plugin"
```

## Skill Anatomy

### Minimal skill (SKILL.md only)
```
your-skill/
└── SKILL.md
```

### Typical skill (with docs)
```
your-skill/
├── SKILL.md
├── advanced.md
└── examples/
    └── example.md
```

### Complex skill (with scripts)
```
your-skill/
├── SKILL.md
├── docs/
│   └── reference.md
├── scripts/
│   └── helper.py
└── templates/
    └── template.txt
```

## SKILL.md Template

```markdown
---
name: [Skill Name - max 64 chars]
description: [What this does and when to use it - max 1024 chars.
             Include specific triggers and use cases.]
---

# [Skill Name]

## Instructions

### Prerequisites
- [List any required packages, environment setup, etc.]

### Workflow

1. **[Step 1 title]**: [Clear guidance]
   - [Sub-point if needed]
   - [Options or variations]

2. **[Step 2 title]**: [Clear guidance]
   - [Sub-point if needed]

3. **[Step 3 title]**: [Clear guidance]

## Examples

### Example 1: [Specific use case]

User request:
```
[Exact user request here]
```

You would:
1. [First action]
2. [Second action with specifics]
3. [Final action and result]

Result: [What Claude produces]
```

## Key Points

✅ **Write clear descriptions**
- Include what your skill does
- Include when Claude should use it
- Use specific language Claude would encounter

❌ **Avoid**
- Vague descriptions like "Helps with X"
- Overly complex SKILL.md files (>5k tokens)
- Multiple unrelated capabilities in one skill

✅ **Structure instructions well**
- Number steps clearly
- Include prerequisites
- Provide concrete examples
- State expected outcomes

## Description Examples

### ✅ Good (Specific, includes triggers)
```
Extract text and tables from PDF files, fill forms, merge documents.
Use when working with PDF files or when the user mentions PDFs,
forms, or document extraction.
```

### ❌ Bad (Vague, unclear triggers)
```
Helps with documents
```

## Progressive Disclosure

**Keep SKILL.md focused** on the common case (under 5k tokens):
```markdown
For advanced usage, see [advanced.md](advanced.md).
For detailed API reference, see [reference.md](reference.md).
```

Then create separate files:
- `advanced.md` - Advanced features
- `reference.md` - Complete API reference
- `scripts/` - Executable utilities

Claude only reads these when needed!

## Testing Your Skill

1. **File structure**
   ```bash
   ls -la plugins/your-skill-name/SKILL.md
   ```

2. **Syntax check**
   ```bash
   head -n 10 plugins/your-skill-name/SKILL.md
   ```

3. **Manual testing**
   - Ask Claude a question matching your description
   - Does it use your skill?
   - If not, description may be too vague

4. **Workflow testing**
   - Follow the instructions yourself
   - Do they work?
   - Are they clear?

## Naming Conventions

- Lowercase with hyphens: `code-reviewer`, `pdf-processor`
- Descriptive but concise
- Avoid generic names: ✅ `git-commit-helper` vs ❌ `tool`

## Common Patterns

### Pattern 1: Single-file skill
Best for: Simple, focused capabilities
Structure: Just SKILL.md (under 5k tokens)

### Pattern 2: Read-only skill
Add tool restriction:
```yaml
---
name: Code Reader
description: Read and analyze code without modifying
allowed-tools: Read, Grep, Glob
---
```

### Pattern 3: Multi-file skill
Best for: Complex workflows with advanced features
```
skill/
├── SKILL.md              # Common case
├── advanced.md           # Advanced usage
├── reference.md          # API reference
└── scripts/
    └── helper.py
```

## Marketplace.json Entry

```json
{
  "name": "your-skill-name",
  "source": "./plugins/your-skill-name",
  "description": "What this skill does",
  "version": "1.0.0",
  "author": "Your Name",
  "keywords": ["keyword1", "keyword2"],
  "homepage": "https://github.com/you/repo",
  "license": "MIT"
}
```

Required: `name`, `source`
Recommended: `description`, `version`, `author`

## Skill Ideas to Get Started

- **Code Review**: Review code for best practices and issues
- **Documentation**: Generate or improve documentation
- **Data Analysis**: Analyze CSV/JSON data and create reports
- **Testing**: Generate or improve test cases
- **Git Helper**: Assist with git workflows and commit messages
- **Refactoring**: Identify refactoring opportunities
- **API Documentation**: Parse and document APIs
- **Migration**: Guide code migrations or upgrades

## Checklist Before Committing

- [ ] SKILL.md exists and is valid YAML
- [ ] Description is specific and includes triggers
- [ ] Instructions are clear and numbered
- [ ] At least 2 examples are provided
- [ ] Skill has been tested with Claude
- [ ] File paths in SKILL.md use forward slashes
- [ ] Supporting files are referenced with relative paths
- [ ] marketplace.json entry is added
- [ ] Naming follows conventions (lowercase, hyphens)
- [ ] No unnecessary files committed (.DS_Store, __pycache__, etc.)

## Troubleshooting

**Claude doesn't use my skill**
- Make description more specific and include trigger words
- Check YAML syntax: `head -n 10 SKILL.md`
- Verify file at: `plugins/name/SKILL.md`

**Claude uses my skill but gets confused**
- Simplify instructions
- Add more examples
- Break complex workflows into numbered steps
- Use code blocks for example commands

**File not found errors**
- Use relative paths: `[file.md](file.md)` not `/absolute/path`
- Use forward slashes: `scripts/helper.py` not `scripts\helper.py`
- Verify files exist in your skill directory

## Next Steps

1. **Learn more**: Read [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md)
2. **Study examples**: Check `plugins/create-new-skills/SKILL.md`
3. **Reference docs**: See `plugins/create-new-skills/docs/`
4. **Start creating**: Make your first skill!

## Resources

- 📚 [Plugin Development Guide](PLUGIN_DEVELOPMENT.md)
- 📚 [Main Marketplace README](README.md)
- 📖 [Claude Code Docs](https://docs.claude.com/en/docs/claude-code/overview)
- 📖 [Skills Best Practices](https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices)
- 🎓 [Create New Skills Meta-Skill](plugins/create-new-skills/SKILL.md)

---

**Happy skill creating!** 🎉

Your skills will transform Claude Code from a general-purpose tool into a specialist for your domain.
