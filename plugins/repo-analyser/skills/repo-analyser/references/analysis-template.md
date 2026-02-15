# Analysis Output Template

Generate analysis following this structure. Adapt sections based on what's relevant to the specific codebase.

---

## Output Structure

```markdown
# [Project Name] Architecture Analysis

## Overview
- **Type**: [Web app | API | Library | CLI | Monorepo]
- **Primary Language**: [TypeScript | Python | Mixed]
- **Framework**: [Next.js | FastAPI | Django | NestJS | etc.]
- **Architecture Style**: [Layered | Feature-based | DDD | Microservices]

## Project Structure
[Visual tree of key directories with brief descriptions]
[Mermaid-implemented UML diagrams to review the project main structure]

## Entry Points
[How to run/use the project]
- Development: `command`
- Production: `command`
- Key API endpoints or CLI commands

## Core Modules

### [Module Name]
- **Purpose**: [One sentence]
- **Location**: `path/to/module`
- **Key Files**:
  - `file.ts` - [purpose]
- **Dependencies**: [Internal modules this depends on, use Mermaid to visualize ERD]
- **Dependents**: [Modules that depend on this]

[Repeat for each core module]

## Core Data Flows
[Describe how data moves through the system]
- Entry points (API routes, CLI commands, event handlers)
- Processing layers
- Data persistence
- Use Mermaid flowchart to visualize

[Repeat for each core data flow]

## Key Events
[Describe how events are processed through the system]
- Entry functions
- Data models
- Use Mermaid sequence diagram to visualize

[Repeat for each key event]

## Key Patterns
[Patterns identified in the codebase]
- Pattern 1: [Where and how it's used]
- Pattern 2: [Where and how it's used]

## External Dependencies
[Notable third-party integrations]
| Dependency | Purpose | Used In |
|------------|---------|---------|

```

---

## Analysis Guidelines

### Determining "Core" Modules
Core modules are those that:
1. Contain primary business logic
2. Are imported by many other modules
3. Define domain entities or key abstractions
4. Handle critical flows (auth, payments, data processing)

Exclude from core: utilities, constants, types-only files, test helpers.

### Determining "Core" Classes and Functions
Core classes and functions are those that:
1. Appear in `__init__.py` (and the equivalent for TypeScript)
2. Are imported by many other modules
3. Called by the entry points

### Describing Data Flow
Trace a typical request/operation through the system:
1. Where does input enter?
2. What validation/transformation occurs?
3. What business logic processes it?
4. Where is data persisted or output?

### Identifying Patterns
Look for:
- Repeated structural patterns across modules
- Consistent naming conventions
- Shared base classes or interfaces
- Common error handling approaches
