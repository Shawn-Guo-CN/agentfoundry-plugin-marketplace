# AgentFoundry Plugin Marketplace

Curated collection of Claude Code plugins for AI agent development — skills, commands, hooks, and agents.

## Quick Start

### 1. Add the Marketplace

In Claude Code, run:

```
/plugin marketplace add agentfoundry/agentfoundry-plugin-marketplace
```

This registers the marketplace so Claude Code can discover all plugins listed here.

### 2. Browse Available Plugins

```
/plugin
```

Navigate to **Discover** to see all available plugins from this marketplace.

### 3. Install a Plugin

```
/plugin install <plugin-name>@agentfoundry-plugin-marketplace
```

For example:

```
/plugin install commit-commands@agentfoundry-plugin-marketplace
/plugin install planning-with-files@agentfoundry-plugin-marketplace
```

### 4. Use the Plugin

Once installed, plugins activate automatically based on their type:

- **Skills** — Claude loads them when relevant context is detected
- **Commands** — Use slash commands directly (e.g. `/commit`, `/plan`)
- **Hooks** — Trigger automatically on lifecycle events (PreToolUse, PostToolUse, etc.)
- **Agents** — Available as subagents for delegation via the Task tool

## Available Plugins (24)

### Development

| Plugin | Description | Source |
|--------|-------------|--------|
| **agent-sdk-dev** | Scaffold and verify Claude Agent SDK applications in Python and TypeScript | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **feature-dev** | Guided 7-phase feature development workflow with specialised agents | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **code-review** | Automated PR code review with parallel agents and confidence-based scoring | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **code-simplifier** | Simplify and refactor code for clarity, consistency, and maintainability | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **commit-commands** | Streamlined Git workflows — AI-generated commits, commit-push-PR, branch cleanup | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **hookify** | Create custom hooks in natural language to block or warn on unwanted behaviours | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **pr-review-toolkit** | Comprehensive PR review with 6 specialised agents | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **claude-md-management** | Audit and update CLAUDE.md files — keep project memory aligned with codebase | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **frontend-design** | Generate distinctive, production-grade frontend interfaces | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |
| **web-artifacts-builder** | Build interactive web components and self-contained HTML artefacts | [anthropics/skills](https://github.com/anthropics/skills) |
| **webapp-testing** | Automated web application testing for validating functionality | [anthropics/skills](https://github.com/anthropics/skills) |
| **skill-creator** | Guide for creating effective Agent Skills — templates and best practices | [anthropics/skills](https://github.com/anthropics/skills) |
| **architect** | Software architecture specialist for system design and scalability | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **build-error-resolver** | Build and TypeScript error resolution with minimal diffs | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **api-design** | API design patterns — REST conventions, versioning, error handling | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **backend-patterns** | Backend architecture patterns — caching, queues, middleware | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **docker-patterns** | Docker best practices — multi-stage builds, compose, security hardening | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |

### Security

| Plugin | Description | Source |
|--------|-------------|--------|
| **security-guidance** | Security guidance hooks for safer coding practices | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |

### Workflow

| Plugin | Description | Source |
|--------|-------------|--------|
| **planning-with-files** | Manus-style persistent markdown planning for cross-session memory | [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) |
| **continuous-learning-v2** | Instinct-based learning system — observes sessions and evolves behaviours into skills | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |

### Creative

| Plugin | Description | Source |
|--------|-------------|--------|
| **doc-coauthoring** | Collaborative document co-authoring skill for structured writing | [anthropics/skills](https://github.com/anthropics/skills) |
| **algorithmic-art** | Generate algorithmic and generative art — patterns, fractals, visualisations | [anthropics/skills](https://github.com/anthropics/skills) |
| **ui-ux-pro-max-skill** | AI-driven UI/UX design system generator — 67 styles, 96 palettes, 100 rules | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |

### Integration

| Plugin | Description | Source |
|--------|-------------|--------|
| **github** | GitHub integration via MCP — repo operations, issues, pull requests | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |

## How It Works

This marketplace is a **distributed catalogue**. It indexes plugins from across the community — each plugin lives in its own repository and is referenced here by source.

- **Third-party plugins** — referenced by their original GitHub repo (not copied here)
- **Original plugins** — developed by AgentFoundry, stored in `plugins/`

The central index is `.claude-plugin/marketplace.json`, which follows the [Claude Code marketplace schema](https://anthropic.com/claude-code/marketplace.schema.json).

## Project Structure

```
.claude-plugin/
  marketplace.json       # Central catalogue — the index of all plugins
plugins/                 # Original plugins developed by AgentFoundry
scripts/
  validate.sh            # Marketplace validation script
.github/workflows/
  validate.yml           # CI validation on marketplace.json changes
```

## Contributing

### Referencing a third-party plugin

Add an entry to `.claude-plugin/marketplace.json`:

```json
{
  "name": "my-plugin",
  "description": "What it does",
  "source": {
    "source": "github",
    "repo": "owner/repo-name"
  },
  "category": "development"
}
```

**Source types:**

| Type | Fields | Example |
|------|--------|---------|
| `github` | `repo` (required), `path` (optional) | `"repo": "owner/repo"` |
| `url` | `url` (required) | `"url": "https://..."` |
| `local` | `path` (required) | `"path": "./plugins/my-plugin"` |

**Categories:** `development`, `security`, `workflow`, `creative`, `integration`, `style`

### Creating an original plugin

1. Create a directory under `plugins/`
2. Add `.claude-plugin/plugin.json` with plugin metadata
3. Add your skill/command/hook/agent files
4. Reference it in `marketplace.json` with `"source": { "source": "local", "path": "./plugins/my-plugin" }`

### Validation

```bash
bash scripts/validate.sh
```

Checks valid JSON, required fields, plugin entry structure, and no duplicate names.
Runs automatically via GitHub Actions on any change to `marketplace.json`.

## Licence

MIT
