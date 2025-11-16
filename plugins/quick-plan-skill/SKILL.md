---
name: quick-plan-skill
description: Create detailed engineering implementation plans for features or fixes based on user requirements. Generates comprehensive specifications with technical approach, step-by-step implementation, and testing strategy. Use when you need to plan before building, create detailed specs for complex features, or document the approach to solve a problem.
allowed-tools: Read, Write, Edit, Glob, Grep
---

# Quick Plan

Create comprehensive implementation plans that serve as blueprints for actual development work. This skill analyzes requirements, thinks through the approach, and generates a detailed specification document.

## Prerequisites

- Clear description of what needs to be built or fixed
- Understanding of the codebase structure (run `/prime` first if needed)
- Time to think through the technical approach

## Workflow

1. **Analyze requirements** - Parse the user's request deeply
2. **Design solution** - Think through technical approach and architecture
3. **Document plan** - Create comprehensive markdown specification
4. **Generate filename** - Create descriptive kebab-case filename
5. **Save and report** - Write to `specs/` directory with summary

## Instructions

When creating a plan:

1. **Problem Statement** - Clearly state what the user wants to build/fix
2. **Objectives** - List specific, measurable objectives
3. **Technical Approach** - Describe architecture decisions and why
4. **Implementation Steps** - Step-by-step guide another dev could follow
5. **Code Examples** - Include pseudo-code or examples for complex parts
6. **Edge Cases** - Consider error handling and scalability
7. **Testing Strategy** - How to validate the implementation
8. **Success Criteria** - How to know it's done

Output format:
- Use proper markdown with clear sections
- Include code examples or pseudo-code
- Consider edge cases and error handling
- Save to `specs/<descriptive-name>.md` with kebab-case naming
- Make it detailed enough that another developer could implement it

## Examples

**Example 1: Planning a feature**
```
User: Create a plan for adding dark mode support
Claude: [Analyzes requirements]
[Designs technical approach]
[Creates comprehensive plan]
File: specs/dark-mode-implementation.md
Key Components:
- Theme context provider
- CSS variable system
- localStorage persistence
- Component theme switching
```

**Example 2: Planning a refactor**
```
User: Plan how to refactor our authentication system to use OAuth2
Claude: [Analyzes current system and requirements]
[Designs OAuth2 integration approach]
File: specs/oauth2-migration.md
Key Components:
- OAuth provider setup
- Token management
- User migration strategy
- Fallback for existing sessions
```
