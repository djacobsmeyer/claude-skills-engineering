# Xano Backend Builder

Build no-code backend services with Xano using MCP server integration.

## Installation

### 1. Install Plugin

Install from Claude Code marketplace or add this repository URL.

### 2. Configure Credentials

**Option A: Environment Variables (Recommended for command-line users)**

Add to your shell profile (`~/.zshrc` or `~/.bashrc`):

```bash
export XANO_MCP_URL="https://your-workspace.n7.xano.io/x2/mcp/meta/mcp/sse"
export XANO_MCP_TOKEN="your_xano_mcp_token_here"
```

Then restart Claude Code.

**Option B: Local Settings File (Recommended for Claude Desktop)**

1. Copy `.env.example` to create your own credentials file:
   ```bash
   cp .env.example ~/.xano-credentials
   ```

2. Edit `~/.xano-credentials` with your actual values:
   ```bash
   export XANO_MCP_URL="https://your-workspace.n7.xano.io/x2/mcp/meta/mcp/sse"
   export XANO_MCP_TOKEN="your_xano_mcp_token_here"
   ```

3. Source it in your shell profile:
   ```bash
   # Add to ~/.zshrc or ~/.bashrc
   [ -f ~/.xano-credentials ] && source ~/.xano-credentials
   ```

### 3. Get Your Xano Credentials

1. Log in to https://xano.com
2. Go to **Settings → Metadata API & MCP Server**
3. Copy your **MCP Server URL**
4. Click **Generate Access Token** and copy it
5. **Important**: Token shows only once - save it securely

### 4. Restart Claude Code

After setting environment variables, restart Claude Code completely.

## Verifying Setup

In Claude Code, ask:
- "What Xano tools are available?"
- "Create a test table in Xano"

If tools aren't available, check:
1. Environment variables are set: `echo $XANO_MCP_TOKEN`
2. Claude Code was restarted
3. Plugin is enabled in settings

## Security Notes

- **Never commit** `.env` or credential files to git
- Store credentials in files outside this repository
- Use a password manager for your Xano token
- Rotate tokens periodically
- **This repo's `.gitignore`** already excludes `.env` files

## Usage

See [SKILL.md](SKILL.md) for complete documentation on building backend services with Xano.
