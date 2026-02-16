#!/usr/bin/env bash
#
# update.sh — Sync selected plugins from upstream repositories
#
# Clones/pulls upstream repos into repos/, then copies only the
# selected plugins into plugins/ for local vendoring.
# If any plugin files changed, commits and pushes automatically.
#
# Usage:
#   bash update.sh          # sync, commit & push
#   bash update.sh --dry    # sync only, no commit/push
#
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPOS_DIR="$ROOT_DIR/repos"
PLUGINS_DIR="$ROOT_DIR/plugins"
DRY_RUN=false

if [[ "${1:-}" == "--dry" ]]; then
  DRY_RUN=true
fi

# ─── Upstream repositories ───────────────────────────────────────────
# repo-key|clone-url
REPOS=(
  "claude-plugins-official|https://github.com/anthropics/claude-plugins-official.git"
  "skills|https://github.com/anthropics/skills.git"
  "everything-claude-code|https://github.com/affaan-m/everything-claude-code.git"
  "planning-with-files|https://github.com/OthmanAdi/planning-with-files.git"
  "ui-ux-pro-max-skill|https://github.com/nextlevelbuilder/ui-ux-pro-max-skill.git"
)

# ─── Plugin selections (directories) ─────────────────────────────────
# local-name|repo-key|path-in-repo
#
# To add or remove plugins, edit this list.
# Each entry copies repo-key/path-in-repo/ → plugins/local-name/
#
SELECTIONS=(
  # ── anthropics/claude-plugins-official ──
  "agent-sdk-dev|claude-plugins-official|plugins/agent-sdk-dev"
  "feature-dev|claude-plugins-official|plugins/feature-dev"
  "code-review|claude-plugins-official|plugins/code-review"
  "code-simplifier|claude-plugins-official|plugins/code-simplifier"
  "commit-commands|claude-plugins-official|plugins/commit-commands"
  "hookify|claude-plugins-official|plugins/hookify"
  "pr-review-toolkit|claude-plugins-official|plugins/pr-review-toolkit"
  "claude-md-management|claude-plugins-official|plugins/claude-md-management"
  "frontend-design|claude-plugins-official|plugins/frontend-design"
  "security-guidance|claude-plugins-official|plugins/security-guidance"
  "github|claude-plugins-official|external_plugins/github"

  # ── anthropics/skills ──
  "doc-coauthoring|skills|skills/doc-coauthoring"
  "web-artifacts-builder|skills|skills/web-artifacts-builder"
  "webapp-testing|skills|skills/webapp-testing"
  "skill-creator|skills|skills/skill-creator"
  "algorithmic-art|skills|skills/algorithmic-art"

  # ── standalone repos (whole repo = single plugin) ──
  "planning-with-files|planning-with-files|."
  "ui-ux-pro-max-skill|ui-ux-pro-max-skill|."

  # ── affaan-m/everything-claude-code (skills) ──
  "continuous-learning-v2|everything-claude-code|skills/continuous-learning-v2"
  "api-design|everything-claude-code|skills/api-design"
  "backend-patterns|everything-claude-code|skills/backend-patterns"
  "docker-patterns|everything-claude-code|skills/docker-patterns"
)

# ─── Agent selections (single .md files) ─────────────────────────────
# local-name|repo-key|path-to-file.md
#
# Agents in everything-claude-code are single .md files, not directories.
# Each entry wraps the .md into a minimal plugin structure:
#   plugins/local-name/.claude-plugin/plugin.json
#   plugins/local-name/agents/local-name.md
#
AGENT_SELECTIONS=(
  # ── affaan-m/everything-claude-code (agents) ──
  "architect|everything-claude-code|agents/architect.md"
  "build-error-resolver|everything-claude-code|agents/build-error-resolver.md"
)

# ─── Step 1: Clone or pull upstream repos ─────────────────────────────
echo "=== Syncing upstream repositories ==="
mkdir -p "$REPOS_DIR"

for entry in "${REPOS[@]}"; do
  IFS='|' read -r repo_key repo_url <<< "$entry"
  repo_path="$REPOS_DIR/$repo_key"

  if [ -d "$repo_path/.git" ]; then
    echo "  Pulling $repo_key..."
    git -C "$repo_path" pull --quiet --ff-only 2>/dev/null || {
      echo "    ff-only failed, resetting to origin..."
      git -C "$repo_path" fetch --quiet
      branch="$(git -C "$repo_path" symbolic-ref --short HEAD 2>/dev/null || echo main)"
      git -C "$repo_path" reset --hard "origin/$branch" --quiet
    }
  else
    echo "  Cloning $repo_key..."
    git clone --quiet "$repo_url" "$repo_path"
  fi
done

# ─── Step 2: Copy selected plugins ───────────────────────────────────
echo ""
echo "=== Copying selected plugins ==="

for entry in "${SELECTIONS[@]}"; do
  IFS='|' read -r name repo_key src_path <<< "$entry"

  src="$REPOS_DIR/$repo_key/$src_path"
  dst="$PLUGINS_DIR/$name"

  if [ ! -d "$src" ]; then
    echo "  ! $name: source not found at $repo_key/$src_path — skipping"
    continue
  fi

  # Clean copy — remove old, replace with upstream
  rm -rf "$dst"
  cp -R "$src" "$dst"
  # Strip .git if copying a whole repo (path = ".")
  rm -rf "$dst/.git"

  echo "  + $name <- $repo_key/$src_path"
done

# Copy agent .md files with wrapper plugin structure
for entry in "${AGENT_SELECTIONS[@]}"; do
  IFS='|' read -r name repo_key src_path <<< "$entry"

  src="$REPOS_DIR/$repo_key/$src_path"
  dst="$PLUGINS_DIR/$name"

  if [ ! -f "$src" ]; then
    echo "  ! $name: source not found at $repo_key/$src_path — skipping"
    continue
  fi

  # Create wrapper plugin structure
  rm -rf "$dst"
  mkdir -p "$dst/.claude-plugin" "$dst/agents"
  cp "$src" "$dst/agents/$name.md"

  cat > "$dst/.claude-plugin/plugin.json" <<PJEOF
{
  "name": "$name",
  "description": "Agent: $name (vendored from $repo_key)",
  "agents": ["./agents/$name.md"]
}
PJEOF

  echo "  + $name <- $repo_key/$src_path (agent wrapper)"
done

# ─── Step 3: Commit and push if changed ──────────────────────────────
echo ""
echo "=== Checking for changes ==="
cd "$ROOT_DIR"

if [ -n "$(git status --porcelain plugins/)" ]; then
  if $DRY_RUN; then
    echo "  Changes detected (dry run — skipping commit)."
    git status --short plugins/
  else
    echo "  Changes detected — committing..."
    git add plugins/
    git commit -m "chore: sync vendored plugins from upstream repos"
    git push
    echo "  Committed and pushed."
  fi
else
  echo "  No changes detected."
fi

echo ""
echo "Done."
