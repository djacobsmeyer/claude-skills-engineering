---
name: output-styles-skill
description: Configure and understand different output formatting styles for Claude Code responses. Provides templates for bullet-points, markdown, YAML, HTML, and specialized formats like TTS summaries and observable tool diffs. Use when you want to control output formatting, need structured data output, or want specialized rendering for specific use cases.
allowed-tools: Read, Bash
---

# Output Styles

Configure different output formatting styles to control how Claude Code presents information. This skill provides multiple templates for different communication needs and includes an automatic installation script.

## Prerequisites

- Understanding of your preferred output format
- Optional: Claude Code with output style configuration support
- Bash available for running installation script

## Quick Start: Install All Styles

To automatically install all 12 output style templates to your Claude Code configuration:

```bash
bash ./install-styles.sh
```

This will copy all styles to `~/.claude/output-styles/` and make them available for use in your Claude Code configuration.

## Available Styles

The output-styles directory contains 12 formatting templates:

1. **bullet-points.md** - Concise bullet-point format
2. **markdown-focused.md** - Clean markdown with emphasis on structure
3. **yaml-structured.md** - YAML-formatted structured output
4. **table-based.md** - Table-formatted presentation
5. **html-structured.md** - HTML-structured output
6. **ultra-concise.md** - Minimal, ultra-condensed format
7. **genui.md** - UI-friendly generation format
8. **tts-summary-base.md** - Base TTS (text-to-speech) summary format
9. **tts-summary.md** - Enhanced TTS summary format
10. **tts-summary-base-diffs.md** - TTS format with code diffs
11. **observable-tools-diffs.md** - Observable tool integration with diffs
12. **observable-tools-diffs-tts.md** - Observable tools with TTS and diffs

## Workflow

1. **Identify need** - Determine what output format best suits your use case
2. **Review template** - Read the appropriate style template
3. **Apply format** - Use the template to structure responses
4. **Validate** - Ensure output matches the template structure

## Installation & Setup

### Step 1: Install Styles to Your System

Run the installation script to copy all style templates:

```bash
bash ./install-styles.sh
```

**What it does:**
- Creates `~/.claude/output-styles/` directory if needed
- Copies all 12 style templates from the plugin
- Confirms installation with a list of installed styles

### Step 2: Reference Styles in Configuration

After installation, you can reference these styles in:
- Claude Code hooks (in `.claude/hooks/`)
- Claude Code settings (`.claude/settings.json`)
- Custom commands and workflows

## Using Output Styles

### Best Use Cases

- **For reports/documentation** → Use `markdown-focused.md`
- **For structured data** → Use `yaml-structured.md` or `table-based.md`
- **For concise updates** → Use `bullet-points.md` or `ultra-concise.md`
- **For accessibility** → Use `tts-summary.md`
- **For tool integration** → Use `observable-tools-diffs.md`

### Applying Styles in Hooks

Styles are typically applied via hooks. Reference them in your hook configuration:

```json
{
  "event": "output",
  "command": "apply-style",
  "style": "~/.claude/output-styles/bullet-points.md"
}
```

### Viewing Available Styles

After installation, list available styles:

```bash
ls -1 ~/.claude/output-styles/
```

## Examples

**Example 1: Getting bullet-point summaries**
```
User: Use the bullet-points style for all future responses
Claude: [Configures output style]
All subsequent responses use condensed bullet-point format
```

**Example 2: Using structured YAML output**
```
User: Show results in YAML format
Claude: [Applies yaml-structured style]
Response output matches YAML template structure
```
