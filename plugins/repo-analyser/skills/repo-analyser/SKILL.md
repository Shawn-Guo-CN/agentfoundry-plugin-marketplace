---
name: repo-analyser
description: Analyse code repositories and generate comprehensive architecture documentation. Use when the user asks to: analyse a codebase, understand project structure, document architecture, generate a codebase overview, review repo organisation, or map out how a project works.
---

# Repository Analyser

Generate comprehensive architecture analysis for TypeScript and Python codebases.

## Workflow

### 1. Initial Discovery

Identify project type and structure:

```bash
# Check for key config files
ls -la *.json *.toml *.yaml *.yml 2>/dev/null
ls -la src/ app/ lib/ packages/ 2>/dev/null
```

Key indicators:
- `package.json` → Node.js/TypeScript
- `pyproject.toml` / `requirements.txt` → Python

### 2. Map Project Structure

Use Glob to understand directory layout:
- `**/*.ts` or `**/*.py` for source files
- `**/index.ts` or `**/__init__.py` for module boundaries
- `**/*.test.*` or `**/test_*.py` for test locations

### 3. Identify Core Modules

Core modules have high import counts and contain core logic. Search for:
- Files with many imports from other modules
- Domain entities, services, controllers
- Entry points (main.ts, app.py, main.py, routes, and etc.)

### 4. Analyse Dependencies between Modules

Read key files to understand relationships:
- Import statements reveal module dependencies
- Config files show external dependencies
- Barrel exports (`index.ts`, `__all__`) define public APIs

### 5. Identify Core Classes and Functions

Core classes have high import counts and are listed as public APIs. Core functions of these classes are the public methods called by other modules. Search for:
- Classes with many imports from other modules
- Functions with many calls from other modules

### 6. Analyse Workflows Specified by Core Classes and Functions

A "workflow" in TypeScript or Python is typically the repeatable sequence from idea → code → test → build/package → run/deploy, plus the tools and conventions that make it reliable. It's defined by the project's entry points, dependency system, build/test commands, environment configuration, and the CI/CD steps that enforce them. It's composed of local developer loops (edit–run–debug), quality gates (lint/format/type-check/tests), and release automation (versioning, artifacts, deployments). Search for:
- Config files, then read the primary command list (`package.json` scripts or `pyproject.toml`/Makefile/CI YAML) to see the intended steps and order.

### 7. Review

Review all the content you generated after the above steps, and double check whether the content matches with the codebase.

### 8. Generate Analysis

Output to `docs/Arch_Analysis.md` in the repo root following the template in [references/analysis-template.md](references/analysis-template.md).
You always need to write in simplified Chinese for the final report!

## Language-Specific Guidance

- **TypeScript/JavaScript**: See [references/ts-patterns.md](references/ts-patterns.md)
- **Python**: See [references/python-patterns.md](references/python-patterns.md)

## Output Location

Write analysis to `ARCHITECTURE.md` in the repository root. If the file exists, confirm with the user before overwriting.
