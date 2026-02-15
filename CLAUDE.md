# AgentFoundry Plugin Marketplace

## Project Overview

Curated marketplace of Claude Code plugins (skills, commands, hooks, agents) for AI agent development.
Primarily collects and organises community plugins, with original plugins developed over time.

## Architecture

Distributed marketplace — this repository acts as a **catalogue/index only**.

- **Third-party plugins** are referenced by their original GitHub repo (not stored here)
- **Original plugins** developed by AgentFoundry live in `plugins/`
- The central index is `.claude-plugin/marketplace.json`

## Directory Structure

```
.claude-plugin/
  marketplace.json     # Central catalogue of all plugins
.github/
  workflows/
    validate.yml       # CI validation on marketplace.json changes
plugins/               # Original plugins developed by AgentFoundry
  my-plugin/
    .claude-plugin/
      plugin.json      # Plugin metadata
    skills/
      my-skill/
        SKILL.md       # Skill content
scripts/
  validate.sh          # Marketplace validation script
```

## Marketplace Format

`.claude-plugin/marketplace.json` follows the Claude Code marketplace schema:

```json
{
  "$schema": "https://anthropic.com/claude-code/marketplace.schema.json",
  "name": "agentfoundry-plugin-marketplace",
  "plugins": [
    {
      "name": "plugin-name",
      "description": "What it does",
      "source": {
        "source": "github",
        "repo": "owner/repo-name"
      },
      "category": "development"
    }
  ]
}
```

### Plugin Source Types

- `github` — references an external GitHub repo (`"repo": "owner/repo"`)
- `url` — references a URL (`"url": "https://..."`)
- relative path — references an original plugin in `plugins/` (`"source": "./plugins/my-plugin"`)

## Conventions

- All English text must use British English spelling (e.g. organise, colour, catalogue, analyse)
- Plugin names use kebab-case
- Third-party plugins are referenced, not copied — point to original repos
- Original plugins follow the `.claude-plugin/plugin.json` + `skills/` structure
- Every plugin entry in marketplace.json must have: name, source, category

## Installation

Users install plugins via Claude Code's native plugin system:
```
/plugin marketplace add Shawn-Guo-CN/agentfoundry-plugin-marketplace
```

## Validation

```bash
bash scripts/validate.sh
```

Checks: valid JSON, required fields, plugin entry structure, no duplicate names.
Runs automatically via GitHub Actions on any change to marketplace.json.
