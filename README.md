# AgentFoundry Plugin Marketplace

Curated collection of Claude Code plugins for AI agent development — skills, commands, hooks, and agents.

## Quick Start

### 1. Add the Marketplace

In Claude Code, run:

```
/plugin marketplace add Shawn-Guo-CN/agentfoundry-plugin-marketplace
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

## Available Plugins (27)

### Development

| Plugin | Description | Upstream |
|--------|-------------|----------|
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
| **repo-analyser** | Analyse code repositories and generate architecture documentation with Mermaid diagrams | Original (AgentFoundry) |

### Security

| Plugin | Description | Upstream |
|--------|-------------|----------|
| **security-guidance** | Security guidance hooks for safer coding practices | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |

### Workflow

| Plugin | Description | Upstream |
|--------|-------------|----------|
| **planning-with-files** | Manus-style persistent markdown planning for cross-session memory | [OthmanAdi/planning-with-files](https://github.com/OthmanAdi/planning-with-files) |
| **continuous-learning-v2** | Instinct-based learning system — observes sessions and evolves behaviours into skills | [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) |
| **pr-conventions** | PR conventions — full commit history analysis and test plan requirements | Original (AgentFoundry) |

### Creative

| Plugin | Description | Upstream |
|--------|-------------|----------|
| **doc-coauthoring** | Collaborative document co-authoring skill for structured writing | [anthropics/skills](https://github.com/anthropics/skills) |
| **algorithmic-art** | Generate algorithmic and generative art — patterns, fractals, visualisations | [anthropics/skills](https://github.com/anthropics/skills) |
| **ui-ux-pro-max-skill** | AI-driven UI/UX design system generator — 67 styles, 96 palettes, 100 rules | [nextlevelbuilder/ui-ux-pro-max-skill](https://github.com/nextlevelbuilder/ui-ux-pro-max-skill) |

### Style

| Plugin | Description | Upstream |
|--------|-------------|----------|
| **i18n-guide** | Internationalisation guide — multi-language support for frontend components | Original (AgentFoundry) |

### Integration

| Plugin | Description | Upstream |
|--------|-------------|----------|
| **github** | GitHub integration via MCP — repo operations, issues, pull requests | [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) |

## How It Works

This marketplace **vendors selected plugins locally** for fast, selective loading. Rather than pointing to remote GitHub repos at runtime (which causes duplicate clones and skill registration bloat), we copy only the plugins we want into `plugins/` and reference them as local paths.

- **Vendored third-party plugins** — selectively copied from upstream repos into `plugins/` via `update.sh`
- **Original plugins** — developed by AgentFoundry, also in `plugins/`
- **Standalone third-party plugins** — single-repo plugins referenced directly by GitHub source

The central index is `.claude-plugin/marketplace.json`, which follows the [Claude Code marketplace schema](https://anthropic.com/claude-code/marketplace.schema.json).

### Upstream Repositories

Vendored plugins are sourced from these 3 repositories:

| Repository | Plugins |
|------------|---------|
| [anthropics/claude-plugins-official](https://github.com/anthropics/claude-plugins-official) | agent-sdk-dev, feature-dev, code-review, code-simplifier, commit-commands, hookify, pr-review-toolkit, claude-md-management, frontend-design, security-guidance, github |
| [anthropics/skills](https://github.com/anthropics/skills) | doc-coauthoring, web-artifacts-builder, webapp-testing, skill-creator, algorithmic-art |
| [affaan-m/everything-claude-code](https://github.com/affaan-m/everything-claude-code) | architect, build-error-resolver, continuous-learning-v2, api-design, backend-patterns, docker-patterns |

## Project Structure

```
.claude-plugin/
  marketplace.json       # Central catalogue — the index of all plugins
plugins/                 # All vendored and original plugins
update.sh                # Sync script — pulls upstream repos and copies selected plugins
scripts/
  validate.sh            # Marketplace validation script
.github/workflows/
  validate.yml           # CI validation on marketplace.json changes
repos/                   # (gitignored) Cloned upstream repos used by update.sh
```

## Syncing Upstream Updates

To pull the latest changes from upstream repositories:

```bash
bash update.sh          # sync, commit & push
bash update.sh --dry    # sync only, preview changes without committing
```

The script clones/pulls the 3 upstream repos into `repos/` (gitignored), then copies only the selected plugins into `plugins/`.

### Adding or Removing Plugins

1. Edit the `SELECTIONS` or `AGENT_SELECTIONS` arrays in `update.sh`
2. Add or remove the corresponding entry in `.claude-plugin/marketplace.json`
3. Run `bash update.sh`

## Contributing

### Adding a standalone third-party plugin

For single-repo plugins (one repo = one plugin), add a GitHub reference to `.claude-plugin/marketplace.json`:

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

### Adding a plugin from a multi-plugin repo

For plugins that live inside a larger repository (to avoid cloning the entire repo per plugin):

1. Add the repo to the `REPOS` array in `update.sh` (if not already present)
2. Add the plugin to `SELECTIONS` (for directories) or `AGENT_SELECTIONS` (for single `.md` agent files)
3. Add the corresponding entry to `.claude-plugin/marketplace.json` with a local path: `"source": "./plugins/my-plugin"`
4. Run `bash update.sh`

### Creating an original plugin

1. Create a directory under `plugins/`
2. Add `.claude-plugin/plugin.json` with plugin metadata
3. Add your skill/command/hook/agent files
4. Reference it in `marketplace.json` with `"source": "./plugins/my-plugin"`

### Validation

```bash
bash scripts/validate.sh
```

Checks valid JSON, required fields, plugin entry structure, and no duplicate names.
Runs automatically via GitHub Actions on any change to `marketplace.json`.

**Categories:** `development`, `security`, `workflow`, `creative`, `integration`, `style`

## Licence

MIT
