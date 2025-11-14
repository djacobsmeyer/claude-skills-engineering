---
name: sandbox-manager
description: Configure and manage Claude Code sandboxing for secure code execution. Use when user mentions sandboxing, security isolation, untrusted code, network restrictions, filesystem permissions, or wants to configure Claude Code security settings. Helps enable/disable sandbox mode, configure permissions, troubleshoot compatibility issues, and provide scenario-based configurations.
allowed-tools: Read, Write, Edit, Bash, Grep
---

# Sandbox Manager Skill

Helps users configure and manage Claude Code's sandboxing feature for secure, isolated code execution.

## Prerequisites

- Claude Code installed (Linux or macOS only - Windows not supported)
- Understanding of your project's security requirements
- Access to `.claude/settings.json` or `~/.claude/settings.json`

## When to Use Sandboxing

**Enable sandboxing when:**
- Working with untrusted or third-party code
- Testing potentially dangerous scripts
- Running unfamiliar repositories
- Need to restrict network or filesystem access
- Working in shared environments

**Skip sandboxing when:**
- Using tools incompatible with sandbox (docker, watchman)
- Need full system access for legitimate reasons
- Working with fully trusted code only
- Performance is critical and trust is established

## Workflow

### 1. Enable Sandbox Mode

To enable sandboxing for the current session:
```bash
/sandbox
```

This activates with sensible defaults:
- Read/write access to current working directory
- Read-only access to rest of filesystem (except denied locations)
- Network proxy requiring permission for new domains

### 2. Configure Sandbox Settings

Edit `.claude/settings.json` (project-level) or `~/.claude/settings.json` (global):

**Basic configuration:**
```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "/path/to/project",
      "/path/to/data"
    ],
    "deniedDirectories": [
      "/etc",
      "/var",
      "~/.ssh",
      "~/.aws"
    ],
    "allowedDomains": [
      "github.com",
      "api.example.com",
      "*.trusted-cdn.com"
    ]
  }
}
```

### 3. Apply Scenario-Based Configuration

Choose a configuration template based on your use case (see [Configuration Templates](docs/configuration-templates.md)):

- **Web Development** - Allow npm registry, CDNs, common APIs
- **Python Data Science** - Allow PyPI, data sources, Jupyter
- **General Development** - Balanced permissions for most projects
- **High Security** - Minimal permissions for untrusted code
- **API Integration** - Specific API endpoints only

### 4. Troubleshoot Compatibility Issues

**Docker conflicts:**
- Sandboxing and Docker don't work together
- Either disable sandbox or use devcontainers instead
- Use `dangerouslyDisableSandbox: true` in tool calls if necessary

**Watchman conflicts:**
- Watchman (used by some file watchers) incompatible with sandbox
- Disable watchman or run without sandbox

**Network restrictions:**
- New domains trigger permission requests
- Add known domains to `allowedDomains` in settings
- Use wildcards for CDNs: `*.cloudfront.net`

**Permission denied errors:**
- Check if path is in `allowedDirectories`
- Ensure path isn't in `deniedDirectories`
- Use absolute paths in configuration

### 5. Verify Sandbox Status

Check if sandbox is active:
```bash
# Sandbox shows status when enabled
/sandbox
```

Test filesystem restrictions:
```bash
# Should succeed (working directory)
ls .

# May require permission (outside working directory)
ls /usr/local
```

Test network restrictions:
```bash
# Should prompt for permission (new domain)
curl https://example.com
```

## Configuration Templates

### Web Development Projects
```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.npm",
      "~/.nvm",
      "/tmp"
    ],
    "allowedDomains": [
      "registry.npmjs.org",
      "*.npmjs.org",
      "*.cloudflare.com",
      "*.cloudfront.net",
      "api.github.com"
    ]
  }
}
```

### Python Data Science
```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.local/lib/python*",
      "~/data",
      "/tmp"
    ],
    "allowedDomains": [
      "pypi.org",
      "*.pypi.org",
      "files.pythonhosted.org",
      "*.anaconda.org",
      "raw.githubusercontent.com"
    ]
  }
}
```

### High Security (Untrusted Code)
```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}/sandbox-only"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.config",
      "/etc",
      "/var",
      "/usr",
      "/System"
    ],
    "allowedDomains": []
  }
}
```

### API Integration Projects
```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "/tmp"
    ],
    "allowedDomains": [
      "api.stripe.com",
      "api.openai.com",
      "*.your-api.com"
    ]
  }
}
```

## Key Limitations

1. **OS Support:** Linux and macOS only (no Windows support)
2. **Docker incompatibility:** Cannot use Docker commands while sandboxed
3. **Tool compatibility:** Some tools (watchman) don't work in sandbox
4. **Network filtering:** Blocks domains, but doesn't inspect traffic content
5. **Performance:** Minimal overhead but present
6. **Nested sandboxing:** Weaker protection in Docker environments (Linux)

## Best Practices

### Security
- **Always deny sensitive directories:** `~/.ssh`, `~/.aws`, `~/.config`
- **Use principle of least privilege:** Only allow necessary domains
- **Review permission requests:** Don't auto-approve without understanding
- **Test in sandbox first:** Before running untrusted code

### Configuration
- **Use wildcards carefully:** `*.cdn.com` is broad - be specific when possible
- **Project-level settings:** Use `.claude/settings.json` for project-specific needs
- **Global baseline:** Set strict defaults in `~/.claude/settings.json`
- **Document exceptions:** Comment why certain permissions are needed

### Workflow
- **Enable for new repos:** Default to sandboxed when cloning unknown code
- **Disable when needed:** Use escape hatch for trusted operations
- **Check tool compatibility:** Verify your stack works with sandbox before enabling
- **Monitor permission requests:** Track what's being accessed

## Troubleshooting Guide

### "Permission denied" when accessing project files
**Solution:** Add project directory to `allowedDirectories`:
```json
"allowedDirectories": ["${workspaceFolder}"]
```

### Network requests failing silently
**Solution:** Check Claude Code output for permission prompts, or add domains:
```json
"allowedDomains": ["api.example.com"]
```

### Docker commands not working
**Solution:** Sandboxing conflicts with Docker. Either:
- Disable sandbox for this session
- Use `dangerouslyDisableSandbox: true` in Bash tool calls
- Use devcontainers instead

### Package manager can't download dependencies
**Solution:** Add package registry to allowed domains:
```json
"allowedDomains": [
  "registry.npmjs.org",
  "pypi.org",
  "rubygems.org"
]
```

### Tool runs outside sandbox unexpectedly
**Solution:** Check if using escape hatch. Disable in settings:
```json
{
  "sandbox": {
    "allowUnsandboxedCommands": false
  }
}
```

## Examples

### Example 1: Enable sandbox for untrusted repository

**User:** "I cloned a repo from GitHub that I don't fully trust. Can you help me run it safely?"

**Response:**
```
I'll help you set up sandboxing for secure execution:

1. First, let me enable sandbox mode:
/sandbox

2. I'll create a restricted configuration for this untrusted code:

[Creates .claude/settings.json with high-security template]

3. This configuration:
   - Restricts filesystem access to this project only
   - Blocks all network access by default
   - Denies access to your credentials and config files

4. When you run the code, you'll be prompted for any permission requests.
   Review each carefully before approving.

Would you like me to run the project's setup now, or would you like to
review the configuration first?
```

### Example 2: Configure sandbox for web development

**User:** "I need to work on a Next.js project. How do I set up sandboxing?"

**Response:**
```
I'll configure sandboxing optimized for Next.js development:

[Edits .claude/settings.json with web development template including:]
- npm registry access
- Common CDN domains
- Your project directory
- node_modules and package cache locations

This allows:
- npm install and package downloads
- CDN resources for development
- API calls to common services
- Full access to your project files

The sandbox will still protect:
- Your SSH keys and credentials
- System configuration files
- Other projects on your machine

Sandbox is now configured. Run /sandbox to enable it for this session.
```

### Example 3: Troubleshoot Docker conflict

**User:** "I enabled sandbox but now docker commands don't work"

**Response:**
```
Docker and Claude Code's sandbox mode are incompatible. You have three options:

1. **Disable sandbox for this session** (if you trust the code):
   Run commands without /sandbox enabled

2. **Use selective unsandboxing** (for specific docker commands):
   I can pass dangerouslyDisableSandbox: true for docker-specific operations

3. **Use devcontainers instead** (recommended for untrusted code):
   Set up a devcontainer which provides isolation + Docker access

Which approach fits your security needs?
```

### Example 4: Debug permission issues

**User:** "Sandbox keeps blocking my Python script from reading data files"

**Response:**
```
Let me help debug the permission issue:

1. First, where are your data files located?
[User provides: ~/datasets/]

2. I see the issue - your data directory isn't in allowedDirectories.
Let me update your settings:

[Edits settings.json to add ~/datasets/ to allowedDirectories]

3. The sandbox now allows:
   - Read/write to your project directory
   - Read/write to ~/datasets/
   - Read-only to system libraries

Try running your script again. If it still fails, check for:
- Network requests (will need domain allowlist)
- Writing to /tmp (can add if needed)
- Other file locations being accessed
```

## Related Resources

- **Configuration Templates:** See [docs/configuration-templates.md](docs/configuration-templates.md)
- **Official Docs:** https://code.claude.com/docs/en/sandboxing
- **Security Best Practices:** https://code.claude.com/docs/en/security

## Version

1.0.0 - Initial release with configuration templates and troubleshooting guide
