---
name: build-skill
description: Implement features and changes from implementation plans. Takes a plan file path as input and executes the implementation steps, then reports changes. Use when you have a detailed plan document and need to code it up, or want to implement specifications written in markdown format.
allowed-tools: Read, Edit, Write, Bash, Glob, Grep
---

# Build

Implement code changes and features from a detailed implementation plan. This skill reads a plan file, follows its instructions step-by-step, and reports the completed work.

## Prerequisites

- A plan file in markdown format (typically from `/quick-plan` skill)
- The plan contains clear implementation steps
- You have access to the files that need to be modified

## Workflow

1. **Validate plan** - Confirm a plan file path has been provided
2. **Analyze plan** - Read the plan and understand all implementation requirements
3. **Implement** - Execute each step of the plan, modifying code as needed
4. **Report** - Summarize changes and show diff statistics

## Instructions

1. If no plan file path is provided, ask the user to provide it and stop
2. Read the plan file thoroughly - understand the full scope of work
3. Think deeply about the implementation approach before starting
4. Execute the plan step-by-step:
   - Create new files as specified
   - Modify existing files as outlined
   - Follow code patterns and conventions from the plan
5. After implementation, report:
   - Summary of completed work (bullet points)
   - Files changed with `git diff --stat`

## Examples

**Example 1: Building from a plan**
```
User: /build specs/authentication-system.md
Claude: [Reads authentication-system.md plan]
[Implements all steps]
Summary:
- Created JWT middleware in src/middleware/auth.ts
- Added login endpoint to src/routes/auth.ts
- Added password hashing utilities
[Shows git diff --stat output]
```

**Example 2: Implementing a feature plan**
```
User: Build the payment integration from specs/stripe-integration.md
Claude: [Reads plan and implements stripe integration]
Summary:
- Integrated Stripe API client
- Created payment endpoints
- Added webhooks for payment events
```
