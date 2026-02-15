#!/usr/bin/env bash
set -euo pipefail

# AgentFoundry Marketplace Validator
# Validates .claude-plugin/marketplace.json structure and plugin entries.

MARKETPLACE_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
MARKETPLACE_JSON="${MARKETPLACE_ROOT}/.claude-plugin/marketplace.json"

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m'

errors=0
warnings=0

log_ok()    { echo -e "${GREEN}  ✓${NC} $*"; }
log_error() { echo -e "${RED}  ✗${NC} $*"; errors=$((errors + 1)); }
log_warn()  { echo -e "${YELLOW}  ⚠${NC} $*"; warnings=$((warnings + 1)); }

echo "Validating marketplace.json..."
echo "──────────────────────────────"

# Check file exists
if [[ ! -f "$MARKETPLACE_JSON" ]]; then
  log_error "marketplace.json not found at ${MARKETPLACE_JSON}"
  exit 1
fi
log_ok "marketplace.json exists"

# Validate JSON syntax
if ! python3 -c "import json; json.load(open('${MARKETPLACE_JSON}'))" 2>/dev/null; then
  log_error "Invalid JSON syntax"
  exit 1
fi
log_ok "Valid JSON syntax"

# Validate required fields and plugin entries
python3 <<PYEOF
import json
import sys

with open("${MARKETPLACE_JSON}") as f:
    data = json.load(f)

errors = 0
warnings = 0

def ok(msg):
    print(f"\033[0;32m  ✓\033[0m {msg}")

def error(msg):
    global errors
    print(f"\033[0;31m  ✗\033[0m {msg}")
    errors += 1

def warn(msg):
    global warnings
    print(f"\033[1;33m  ⚠\033[0m {msg}")
    warnings += 1

# Required top-level fields
for field in ["name", "description", "owner", "plugins"]:
    if field not in data:
        error(f"Missing required field: {field}")
    else:
        ok(f"Field '{field}' present")

# Owner validation
owner = data.get("owner", {})
if isinstance(owner, dict):
    if "name" not in owner:
        error("owner.name is required")
    if "url" not in owner:
        warn("owner.url is recommended")

# Plugins validation
plugins = data.get("plugins", [])
if not isinstance(plugins, list):
    error("'plugins' must be an array")
    sys.exit(1)

ok(f"Found {len(plugins)} plugin(s)")

seen_names = set()
for i, plugin in enumerate(plugins):
    prefix = f"plugins[{i}]"

    # Required plugin fields
    name = plugin.get("name")
    if not name:
        error(f"{prefix}: missing 'name'")
    elif name in seen_names:
        error(f"{prefix}: duplicate plugin name '{name}'")
    else:
        seen_names.add(name)

    if "description" not in plugin:
        warn(f"{prefix} ({name}): missing 'description'")

    if "category" not in plugin:
        warn(f"{prefix} ({name}): missing 'category'")

    # Source validation
    source = plugin.get("source")
    if not source:
        error(f"{prefix} ({name}): missing 'source'")
    elif isinstance(source, dict):
        src_type = source.get("source")
        if src_type == "github":
            if "repo" not in source:
                error(f"{prefix} ({name}): github source requires 'repo'")
            else:
                ok(f"{prefix} ({name}): valid github source → {source['repo']}")
        elif src_type == "url":
            if "url" not in source:
                error(f"{prefix} ({name}): url source requires 'url'")
            else:
                ok(f"{prefix} ({name}): valid url source")
        elif src_type == "local":
            if "path" not in source:
                error(f"{prefix} ({name}): local source requires 'path'")
            else:
                ok(f"{prefix} ({name}): local plugin → {source['path']}")
        else:
            error(f"{prefix} ({name}): unknown source type '{src_type}'")

print()
print("──────────────────────────────")
print(f"Results: {len(plugins)} plugins, {errors} error(s), {warnings} warning(s)")

if errors > 0:
    sys.exit(1)
PYEOF

validate_exit=$?

echo ""
if [[ $validate_exit -eq 0 ]]; then
  echo -e "${GREEN}Validation passed.${NC}"
else
  echo -e "${RED}Validation failed.${NC}"
  exit 1
fi
