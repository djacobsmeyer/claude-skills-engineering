# Claude Code Skills - Engineering Marketplace

A curated collection of engineering-focused skills and plugins for Claude Code, designed for software developers, DevOps engineers, and technical teams.

## What's in this Repository

This repository serves as both:
1. **An engineering plugin marketplace** - Skills for software development workflows, testing, git operations, CI/CD, and more
2. **A development reference** - Documentation and examples for creating engineering-specific Claude Code plugins

## About Claude Code Skills

Claude Code Skills are modular capabilities that extend Claude's functionality through organized folders containing:
- Instructions (SKILL.md files with YAML frontmatter)
- Scripts and utilities
- Reference materials and templates

Skills are **model-invoked** (Claude autonomously decides when to use them) rather than user-invoked like slash commands.

### Key Benefits for Engineering Teams
- Standardize development workflows across teams
- Automate repetitive engineering tasks
- Enforce code quality and testing standards
- Share engineering expertise via git
- Compose multiple skills for complex engineering workflows

## Available Plugins

*No plugins yet - this marketplace is ready for engineering-focused skills!*

### Suggested Engineering Skills to Add
- **Code Review Assistant** - Automated code review with linting and best practices
- **Test Generator** - Generate unit tests, integration tests, and E2E tests
- **API Documentation** - Generate OpenAPI/Swagger docs from code
- **Docker Workflow** - Container management, Dockerfile generation, docker-compose
- **CI/CD Pipeline Builder** - GitHub Actions, GitLab CI, CircleCI configuration
- **Database Migration Manager** - Schema migrations, seed data management
- **Performance Profiler** - Code performance analysis and optimization suggestions
- **Security Scanner** - Security vulnerability scanning and OWASP compliance
- **Git Workflow Manager** - Advanced git operations, PR templates, branch strategies
- **Infrastructure as Code** - Terraform, CloudFormation, Pulumi helpers

## How to Use This Marketplace

### Adding This Marketplace to Claude Code

Run the following command in Claude Code:

```bash
/plugin marketplace add djacobsmeyer/claude-skills-engineering
```

Then browse available plugins using:

```bash
/plugin
```

### Installing Individual Plugins

After adding the marketplace, use Claude Code's plugin interface to:
1. Browse available engineering plugins
2. Install plugins relevant to your stack
3. Manage installed plugins

Plugins are automatically available in your Claude Code environment after installation.

## Plugin Structure

Each plugin in this marketplace follows this directory structure:

```
plugins/
├── plugin-name/
│   ├── SKILL.md                 # Required: Skill definition with YAML frontmatter
│   ├── docs/                    # Optional: Additional documentation
│   ├── scripts/                 # Optional: Executable utilities
│   ├── templates/               # Optional: Template files
│   └── examples/                # Optional: Example usage
```

## Creating Your Own Engineering Skills

See [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md) for comprehensive guidance on:
- Understanding the skill architecture
- Designing effective engineering skills
- Writing clear SKILL.md files
- Structuring skill content with progressive disclosure
- Testing and debugging skills
- Best practices and patterns

## Marketplace JSON Format

This marketplace is registered via `.claude-plugin/marketplace.json`:

```json
{
  "name": "claude-skills-engineering",
  "owner": {
    "name": "Don Jacobsmeyer",
    "email": "hello@donjacobsmeyer.com"
  },
  "plugins": []
}
```

## Contributing

To add new plugins to this marketplace:

1. Create a new directory under `plugins/`
2. Follow the skill structure guidelines in [PLUGIN_DEVELOPMENT.md](PLUGIN_DEVELOPMENT.md)
3. Update `.claude-plugin/marketplace.json` with your plugin entry
4. Create documentation for your plugin
5. Test thoroughly with real engineering workflows
6. Submit a pull request

## Best Practices for Engineering Skills

### Writing Skills
- **Be specific in descriptions** - Include programming languages, frameworks, tools
- **Use progressive disclosure** - Keep SKILL.md focused, split complex content into separate files
- **Test with real codebases** - Verify Claude discovers and uses your skill correctly
- **Document prerequisites** - List required tools, languages, or environment setup
- **Keep focused scope** - One skill should address one engineering capability

### Naming Conventions
- Use lowercase with hyphens for skill names (e.g., `docker-workflow-manager`)
- Include tool/language names when specific (e.g., `pytest-test-generator`)
- Be descriptive but concise

### File References
- Use relative paths in markdown: `[file.md](file.md)`
- Use forward slashes (Unix style) in all paths
- Make it clear when Claude should read vs. execute files

## Limitations

### Skills Environment Constraints
- **No network access**: Skills cannot make external API calls
- **No runtime package installation**: Only pre-installed packages are available
- **No cross-surface sync**: Skills don't automatically sync between Claude.ai, API, and Claude Code

### Sharing Scope
- **Claude Code**: Personal (`~/.claude/skills/`) or project-based (`.claude/skills/`)
- **Plugins**: Distributed via marketplaces like this one

## Security Considerations

Engineering skills often execute code and scripts. We recommend:

- Installing skills only from trusted sources
- Auditing all scripts before use
- Reviewing bundled dependencies
- Being cautious of skills that modify production environments
- Testing in development environments first
- Following principle of least privilege

## Related Marketplaces

**Other marketplaces by Don Jacobsmeyer:**
- [claude-skill-plugins](https://github.com/donjacobsmeyer/claude-skill-plugins) - Productivity and knowledge work skills
- [claude-skills-personal](https://github.com/djacobsmeyer/claude-skills-personal) - Personal utilities and workflows

## Quick Start

### Creating a New Engineering Skill

1. Use the structure from [QUICK_START.md](QUICK_START.md)
2. Define prerequisites (languages, tools, frameworks)
3. Write clear step-by-step engineering workflows
4. Include code examples and expected outputs
5. Test with real development scenarios

### Common Engineering Skill Patterns

- **Code generation skills** - Generate boilerplate, configs, tests
- **Workflow automation skills** - Automate git, docker, CI/CD operations
- **Analysis skills** - Code review, security scanning, performance analysis
- **Documentation skills** - Generate docs from code annotations

## More Information

- **Claude Code Documentation**: https://docs.claude.com/en/docs/claude-code/overview
- **Agent Skills Guide**: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/overview
- **Skill Authoring Best Practices**: https://docs.claude.com/en/docs/agents-and-tools/agent-skills/best-practices
- **Claude Code Plugins**: https://docs.claude.com/en/docs/claude-code/plugins
- **Plugin Marketplaces**: https://docs.claude.com/en/docs/claude-code/plugin-marketplaces

## License

MIT License - See LICENSE file for details

## Support

For issues, questions, or suggestions:
1. Open an issue in this repository
2. Review the skill documentation in the respective plugin directory
3. Check the official Claude Code documentation

---

**Created:** 2025-11-14
**Purpose:** Engineering-focused skills marketplace for Claude Code
