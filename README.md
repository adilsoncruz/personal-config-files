# Personal Config Files & Agentic OS (`macOS`)

Complete bootstrap repository for my macOS development environment and **Multi-Engine Agentic OS** (**AGY Gemini**, **OpenAI Codex**, **Claude Code**, **Orca**, and **Obsidian Memory**).

---

## 📦 What This Installs

1. **Multi-Engine AI Kernels (`agentic-os/kernels/`):**
   - `~/.gemini/GEMINI.md` & `settings.json` (Antigravity / Gemini CLI)
   - `~/.codex/AGENTS.md` (OpenAI Codex CLI)
   - `~/.claude/CLAUDE.md` & `settings.json` (Claude Code CLI)
   - Shared modules: **Codebase Memory Graph**, **Obsidian Memory (`Agentic OS`)**, **Native Model Routing (`flash_lite`/`flash`/`pro`)**, **Jarvis Mode**, **ADHD Output Style**, and **Feature Interviewer**.
2. **Skills Catalog (`agentic-os/skills/`):**
   - 35+ bundled custom & domain skills (`obsidian-memory`, `jarvis-mode`, `orca-cli`, `computer-use`, `ai-pdf-template-importer`, full `aws-*` suite, `codebase-memory`, `feature-interviewer`, `reverse-engineer-anything`).
   - `.skill-lock.json` auto-hydrator for 100+ additional community skills (Blender pipeline, Orca workflows).
3. **Orca Orchestration & Hooks (`agentic-os/orca/` & `claude-hooks/`):**
   - `~/.orca/` agent hooks, `creed.md`, scripts, and codebase-memory discovery gates.
4. **Obsidian `Agentic OS` Vault (`~/obsidian/Agentic OS`):**
   - Non-destructive bootstrap (`rsync --ignore-existing`) with pre-configured **7-color Graph View** (`.obsidian/graph.json`), `dataview` plugin, Maps of Content (`00_HOME.md`, `00_INBOX` to `06_DAILY`), and YAML frontmatter templates (`99_TEMPLATES/`).
5. **Shell, Git, Mise & Homebrew (`.zshrc`, `.gitconfig`, `mise/config.toml`, `Brewfile`):**
   - Clean Zsh setup (`mise`, `starship`, `colima`, `ollama`, `codex-auto`, `local-ai`) with secrets isolated in `~/.zshrc.local`.
   - **Mise runtimes (`mise/config.toml`):** Go `1.27.1`, Java `21.0.2` & `graalvm-community-21.0.2`, Maven `3.10.0`, Node `26.12.1` & `20.20.2`, Python `3.14.7` & `3.12.15`, `uv`.
   - **Homebrew Casks & Formulae (`Brewfile`):** Includes `mise`, **Insomnia** (`cask "insomnia"`), **DBX** (`cask "dbx"`), **Obsidian** (`cask "obsidian"`), Docker/Colima, AWS CLI, and Ollama.

---

## 🚀 Quick Install (1 Command)

```bash
git clone https://github.com/adilsoncruz/personal-config-files.git ~/projects/personal-config-files
cd ~/projects/personal-config-files
chmod +x install.sh
./install.sh
```

### Optional Flags

- **Install Homebrew packages, casks & CLI tools from `Brewfile`:**
  ```bash
  ./install.sh --brew
  ```
- **Offline / fast mode (skip cloning remote repositories from `.skill-lock.json`):**
  ```bash
  ./install.sh --skip-remote-skills
  ```

---

## 🔐 Secrets & Portability

- All paths in `agentic-os/` use the `__HOME__` placeholder and are dynamically expanded to `$HOME` during `./install.sh`.
- Machine-specific API keys (e.g., `OMNIROUTE_API_KEY`) live exclusively in `~/.zshrc.local` (`chmod 600`), which is never tracked by Git.
