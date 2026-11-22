#!/usr/bin/env bash
set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
AGENTIC_DIR="$REPO_DIR/agentic-os"
VAULT_DEST="$HOME/obsidian/Agentic OS"

INSTALL_BREW=false
SKIP_REMOTE_SKILLS=false

for arg in "$@"; do
  case "$arg" in
    --brew) INSTALL_BREW=true ;;
    --skip-remote-skills) SKIP_REMOTE_SKILLS=true ;;
  esac
done

echo "🚀 Starting Agentic OS & Personal Config Bootstrap..."

backup_if_exists() {
  local target="$1"
  if [ -f "$target" ] && [ ! -L "$target" ]; then
    cp "$target" "${target}.bak"
  fi
}

install_with_home() {
  local src="$1"
  local dst="$2"
  mkdir -p "$(dirname "$dst")"
  sed "s|__HOME__|$HOME|g" "$src" > "$dst"
}

# =========================================
# 1. Shell & Terminal Configs
# =========================================
echo "📦 [1/6] Installing Shell, Git & Editor configs..."
backup_if_exists "$HOME/.zshrc"
cmp -s "$REPO_DIR/.zshrc" "$HOME/.zshrc" || cp "$REPO_DIR/.zshrc" "$HOME/.zshrc"

if ! cmp -s "$REPO_DIR/.gitconfig" "$HOME/.gitconfig" 2>/dev/null; then
  backup_if_exists "$HOME/.gitconfig"
  cp "$REPO_DIR/.gitconfig" "$HOME/.gitconfig"
fi

[ -f "$REPO_DIR/.tmux.conf" ] && cp "$REPO_DIR/.tmux.conf" "$HOME/.tmux.conf"
[ -f "$REPO_DIR/.vimrc" ] && cp "$REPO_DIR/.vimrc" "$HOME/.vimrc"
mkdir -p "$HOME/.vim"
[ -f "$REPO_DIR/.editorconfig" ] && cp "$REPO_DIR/.editorconfig" "$HOME/.vim/.editorconfig"

if [ ! -f "$HOME/.zshrc.local" ]; then
  cat > "$HOME/.zshrc.local" <<'EOF'
# Local machine secrets and API keys (ignored by Git)
# export OMNIROUTE_API_KEY="your-key-here"
EOF
  chmod 600 "$HOME/.zshrc.local"
fi

# =========================================
# 2. Multi-Engine Kernels (AGY Gemini, Codex, Claude)
# =========================================
echo "🧠 [2/6] Installing Kernels (GEMINI.md, CLAUDE.md, AGENTS.md)..."
mkdir -p "$HOME/.gemini/agents" "$HOME/.gemini/skills" \
         "$HOME/.claude/agents" "$HOME/.claude/hooks" "$HOME/.claude/skills" \
         "$HOME/.codex/agents" "$HOME/.codex/skills"

install_with_home "$AGENTIC_DIR/kernels/GEMINI.md" "$HOME/.gemini/GEMINI.md"
install_with_home "$AGENTIC_DIR/kernels/CLAUDE.md" "$HOME/.claude/CLAUDE.md"
install_with_home "$AGENTIC_DIR/kernels/AGENTS.md" "$HOME/.codex/AGENTS.md"

install_with_home "$AGENTIC_DIR/kernels/gemini-settings.json" "$HOME/.gemini/settings.json"
install_with_home "$AGENTIC_DIR/kernels/claude-settings.json" "$HOME/.claude/settings.json"

for agent_file in "$AGENTIC_DIR/agents/"*.md; do
  fname="$(basename "$agent_file")"
  install_with_home "$agent_file" "$HOME/.gemini/agents/$fname"
  install_with_home "$agent_file" "$HOME/.claude/agents/$fname"
  install_with_home "$agent_file" "$HOME/.codex/agents/$fname"
done

for hook_file in "$AGENTIC_DIR/claude-hooks/"*; do
  fname="$(basename "$hook_file")"
  install_with_home "$hook_file" "$HOME/.claude/hooks/$fname"
  chmod +x "$HOME/.claude/hooks/$fname"
done

# =========================================
# 3. Orca Runtime Hooks & Skills (~/.orca)
# =========================================
echo "🐋 [3/6] Installing Orca hooks and scripts (~/.orca)..."
mkdir -p "$HOME/.orca/agent-hooks" "$HOME/.orca/scripts" "$HOME/.orca/skills"
install_with_home "$AGENTIC_DIR/orca/creed.md" "$HOME/.orca/creed.md"

for hook in "$AGENTIC_DIR/orca/agent-hooks/"*; do
  fname="$(basename "$hook")"
  install_with_home "$hook" "$HOME/.orca/agent-hooks/$fname"
  chmod +x "$HOME/.orca/agent-hooks/$fname"
done

for script in "$AGENTIC_DIR/orca/scripts/"*; do
  fname="$(basename "$script")"
  install_with_home "$script" "$HOME/.orca/scripts/$fname"
done

for skill in "$AGENTIC_DIR/orca/skills/"*; do
  fname="$(basename "$skill")"
  install_with_home "$skill" "$HOME/.orca/skills/$fname"
done

# =========================================
# 4. Skills Catalog (~/.agents/skills + Symlinks)
# =========================================
echo "🛠️  [4/6] Installing Bundled Skills & .skill-lock.json..."
mkdir -p "$HOME/.agents/skills" "$HOME/.gemini/antigravity-cli/skills"
cp "$AGENTIC_DIR/skills/.skill-lock.json" "$HOME/.agents/.skill-lock.json"

for skill_dir in "$AGENTIC_DIR/skills/"*/; do
  skill_name="$(basename "$skill_dir")"
  target_dir="$HOME/.agents/skills/$skill_name"
  mkdir -p "$target_dir"
  cp -R "${skill_dir%/}/." "$target_dir/"
  find "$target_dir" -type f \( -name "*.md" -o -name "*.json" -o -name "*.sh" -o -name "*.py" \) \
    -exec sed -i '' "s|__HOME__|$HOME|g" {} +
done

if [ "$SKIP_REMOTE_SKILLS" = false ] && command -v python3 >/dev/null 2>&1; then
  echo "🌐 Restoring remote skills from .skill-lock.json..."
  python3 - "$HOME/.agents/.skill-lock.json" "$HOME/.agents/skills" <<'PYEOF'
import json, os, shutil, subprocess, tempfile, sys

lock_path, skills_root = sys.argv[1], sys.argv[2]
data = json.load(open(lock_path))["skills"]

missing_by_url = {}
for name, info in data.items():
    dest = os.path.join(skills_root, name)
    if not os.path.exists(dest):
        missing_by_url.setdefault(info["sourceUrl"], []).append((name, info["skillPath"]))

if not missing_by_url:
    print("   All locked skills already installed.")
    sys.exit(0)

with tempfile.TemporaryDirectory() as tmp:
    for idx, (url, items) in enumerate(missing_by_url.items(), 1):
        repo_dir = os.path.join(tmp, f"repo_{idx}")
        print(f"   Cloning {url} ({len(items)} skills)...")
        res = subprocess.run(["git", "clone", "--depth", "1", url, repo_dir], capture_output=True, text=True)
        if res.returncode != 0:
            print(f"   ⚠️ Warning: could not clone {url}")
            continue
        for name, skill_md_rel in items:
            src_folder = os.path.join(repo_dir, os.path.dirname(skill_md_rel))
            dst_folder = os.path.join(skills_root, name)
            if os.path.exists(src_folder) and not os.path.exists(dst_folder):
                shutil.copytree(src_folder, dst_folder)
PYEOF
fi

# Symlink core skills across Gemini, Codex, and Claude
for core_skill in obsidian-memory jarvis-mode orca-cli computer-use yagni-kiss-sine feature-interviewer codebase-memory daily-summary reverse-engineer-anything release-it system-design ddia-systems security-audit; do
  if [ -d "$HOME/.agents/skills/$core_skill" ]; then
    ln -sfn "$HOME/.agents/skills/$core_skill" "$HOME/.gemini/skills/$core_skill"
    ln -sfn "$HOME/.agents/skills/$core_skill" "$HOME/.codex/skills/$core_skill"
    ln -sfn "$HOME/.agents/skills/$core_skill" "$HOME/.claude/skills/$core_skill"
  fi
done

for claude_skill in "$AGENTIC_DIR/skills/"*/; do
  sname="$(basename "$claude_skill")"
  if [ "$sname" != "ai-pdf-template-importer" ] && [ -d "$HOME/.agents/skills/$sname" ]; then
    ln -sfn "$HOME/.agents/skills/$sname" "$HOME/.claude/skills/$sname"
  fi
done

# =========================================
# 5. Obsidian Agentic OS Vault (Non-Destructive)
# =========================================
echo "📓 [5/6] Bootstrapping Obsidian Vault at $VAULT_DEST..."
mkdir -p "$VAULT_DEST"
rsync -a --ignore-existing "$AGENTIC_DIR/obsidian-vault-template/" "$VAULT_DEST/"
find "$VAULT_DEST" -type f -name "*.md" -exec sed -i '' "s|__HOME__|$HOME|g" {} +

# =========================================
# 6. Mise Runtimes & Homebrew Bundle (mise, Insomnia, DBX, Obsidian)
# =========================================
echo "🔧 [6/7] Configuring Mise runtimes (~/.config/mise/config.toml)..."
if mkdir -p "$HOME/.config/mise" 2>/dev/null; then
  backup_if_exists "$HOME/.config/mise/config.toml"
  cp "$REPO_DIR/mise/config.toml" "$HOME/.config/mise/config.toml"
else
  echo "   ⚠️ Could not write to $HOME/.config/mise (sandboxed); run ./install.sh directly in terminal to apply."
fi

if [ "$INSTALL_BREW" = true ]; then
  if command -v brew >/dev/null 2>&1; then
    echo "🍺 [7/7] Running brew bundle (mise, insomnia, dbx, obsidian, etc.)..."
    brew bundle --file="$REPO_DIR/Brewfile"
  fi
  if command -v mise >/dev/null 2>&1; then
    echo "⚙️  Installing Mise toolchains (Go, Java, Maven, Node, Python, uv)..."
    mise install
  fi
else
  echo "🍺 [7/7] Skipping Homebrew & Mise downloads (pass --brew to install Brewfile + mise runtimes)."
fi

echo "✅ Agentic OS & Personal Config installation complete!"
