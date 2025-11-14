# Sandbox Configuration Templates

Comprehensive configuration templates for different development scenarios. Copy and customize for your project's needs.

## Table of Contents

- [Web Development](#web-development)
- [Python Data Science](#python-data-science)
- [Node.js Backend](#nodejs-backend)
- [Ruby on Rails](#ruby-on-rails)
- [Go Development](#go-development)
- [Rust Development](#rust-development)
- [High Security (Untrusted Code)](#high-security-untrusted-code)
- [API Integration](#api-integration)
- [DevOps/Infrastructure](#devopsinfrastructure)
- [Mobile Development](#mobile-development)

---

## Web Development

For frontend projects using npm, yarn, or pnpm with common CDNs and APIs.

**Use case:** React, Vue, Angular, Next.js, Svelte projects

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.npm",
      "~/.nvm",
      "~/.yarn",
      "~/.pnpm-store",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.config/gcloud",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "registry.npmjs.org",
      "*.npmjs.org",
      "registry.yarnpkg.com",
      "*.cloudflare.com",
      "*.cloudfront.net",
      "cdn.jsdelivr.net",
      "unpkg.com",
      "fonts.googleapis.com",
      "fonts.gstatic.com",
      "api.github.com",
      "raw.githubusercontent.com"
    ]
  }
}
```

---

## Python Data Science

For data analysis, machine learning, and scientific computing projects.

**Use case:** Jupyter, pandas, numpy, scikit-learn, PyTorch, TensorFlow

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.local/lib/python3.9",
      "~/.local/lib/python3.10",
      "~/.local/lib/python3.11",
      "~/.local/lib/python3.12",
      "~/data",
      "~/datasets",
      "~/notebooks",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.kaggle",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "pypi.org",
      "*.pypi.org",
      "files.pythonhosted.org",
      "*.anaconda.org",
      "conda.anaconda.org",
      "raw.githubusercontent.com",
      "*.huggingface.co",
      "github.com",
      "*.github.io"
    ]
  }
}
```

---

## Node.js Backend

For Express, Nest.js, or other Node.js server applications.

**Use case:** REST APIs, GraphQL servers, microservices

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.npm",
      "~/.nvm",
      "/tmp",
      "/var/log/app"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "/etc/passwd",
      "/etc/shadow"
    ],
    "allowedDomains": [
      "registry.npmjs.org",
      "*.npmjs.org",
      "api.github.com",
      "smtp.gmail.com",
      "smtp.sendgrid.net",
      "api.stripe.com",
      "api.twilio.com",
      "*.mongodb.net",
      "*.amazonaws.com"
    ]
  }
}
```

---

## Ruby on Rails

For Rails applications with bundler and common Ruby gems.

**Use case:** Rails web apps, Sinatra, Ruby scripts

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.gem",
      "~/.bundle",
      "~/.rbenv",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "rubygems.org",
      "*.rubygems.org",
      "api.github.com",
      "raw.githubusercontent.com",
      "*.herokuapp.com"
    ]
  }
}
```

---

## Go Development

For Go projects with module downloads and common tooling.

**Use case:** Go CLI tools, microservices, web servers

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/go",
      "~/.cache/go-build",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "proxy.golang.org",
      "sum.golang.org",
      "*.golang.org",
      "github.com",
      "*.github.com",
      "api.github.com"
    ]
  }
}
```

---

## Rust Development

For Rust projects using cargo and crates.io.

**Use case:** Rust applications, CLI tools, system programming

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.cargo",
      "~/.rustup",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "crates.io",
      "*.crates.io",
      "static.crates.io",
      "index.crates.io",
      "github.com",
      "*.github.com",
      "raw.githubusercontent.com"
    ]
  }
}
```

---

## High Security (Untrusted Code)

Minimal permissions for running untrusted or experimental code.

**Use case:** Testing third-party code, security research, code review

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}/sandbox"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.gcp",
      "~/.azure",
      "~/.config",
      "~/.gnupg",
      "/etc",
      "/var",
      "/usr",
      "/System",
      "/Library"
    ],
    "allowedDomains": [],
    "allowUnsandboxedCommands": false
  }
}
```

**Notes:**
- No network access by default
- Limited to single subdirectory
- Blocks escape hatch
- Add domains only as absolutely necessary

---

## API Integration

For projects primarily making API calls to external services.

**Use case:** Integration scripts, API clients, webhooks

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.config"
    ],
    "allowedDomains": [
      "api.stripe.com",
      "api.openai.com",
      "api.anthropic.com",
      "*.twilio.com",
      "api.sendgrid.com",
      "hooks.slack.com",
      "*.googleapis.com",
      "graph.microsoft.com"
    ]
  }
}
```

**Customize:** Replace with your specific API endpoints

---

## DevOps/Infrastructure

For infrastructure-as-code and deployment scripts.

**Use case:** Terraform, Ansible, deployment automation

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.terraform.d",
      "~/.ansible",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "~/.gcp",
      "/etc/passwd"
    ],
    "allowedDomains": [
      "registry.terraform.io",
      "releases.hashicorp.com",
      "checkpoint-api.hashicorp.com",
      "galaxy.ansible.com",
      "github.com",
      "*.github.com"
    ]
  }
}
```

**Warning:** Be cautious with infrastructure code - verify before running

---

## Mobile Development

For React Native, Flutter, or mobile app development.

**Use case:** Mobile app development, cross-platform frameworks

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.npm",
      "~/.pub-cache",
      "~/Android/Sdk",
      "~/Library/Android",
      "/tmp"
    ],
    "deniedDirectories": [
      "~/.ssh",
      "~/.aws",
      "/etc",
      "/var"
    ],
    "allowedDomains": [
      "registry.npmjs.org",
      "pub.dev",
      "*.pub.dev",
      "maven.google.com",
      "jcenter.bintray.com",
      "repo1.maven.org",
      "dl.google.com"
    ]
  }
}
```

---

## Template Variables

All templates support these variables:

- `${workspaceFolder}` - Current project directory
- `~` - User home directory
- `*` - Wildcard for domains (use carefully)

## Combining Templates

You can merge multiple templates for polyglot projects:

```json
{
  "sandbox": {
    "enabled": true,
    "allowedDirectories": [
      "${workspaceFolder}",
      "~/.npm",
      "~/.local/lib/python3.11",
      "/tmp"
    ],
    "allowedDomains": [
      "registry.npmjs.org",
      "pypi.org",
      "*.npmjs.org",
      "*.pypi.org"
    ]
  }
}
```

## Testing Your Configuration

After applying a template:

1. Enable sandbox: `/sandbox`
2. Test file access: `ls ${workspaceFolder}`
3. Test package install: `npm install` or `pip install`
4. Monitor permission requests in Claude Code output
5. Refine based on actual needs

## Security Checklist

Before using any template:

- [ ] Verify all `allowedDirectories` are necessary
- [ ] Confirm `deniedDirectories` includes sensitive paths
- [ ] Review each domain in `allowedDomains`
- [ ] Remove wildcards where possible
- [ ] Test with minimal permissions first
- [ ] Document why each permission is needed

---

**Last Updated:** 2025-11-14
**Version:** 1.0.0
