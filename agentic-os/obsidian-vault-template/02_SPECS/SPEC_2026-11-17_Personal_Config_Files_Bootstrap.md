---
type: spec
project: "[[PRJ_Agentic_OS]]"
status: approved
updated_at: 2026-11-17
tags:
  - spec
  - agentic-os
---

# 📋 Spec: Instalador Completo `personal-config-files` (Agentic OS + Shell + Orca)

Conectado a: [[02_Specs_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## 🎯 Goal (Objetivo)
Atualizar o repositório `https://github.com/adilsoncruz/personal-config-files` (em `__HOME__/projects/personal-config-files`) com um script `install.sh` idempotente capaz de instalar e restaurar em qualquer Mac toda a arquitetura **Agentic OS** (AGY Gemini, Codex, Claude, Orca, Skills, Vault Obsidian e Shell).

## ✅ Acceptance Criteria
1. **Multi-Engine Kernels & Hooks:** Instalar `GEMINI.md`, `CLAUDE.md`, `AGENTS.md`, `settings.json` (parametrizados com `$HOME`), subagentes (`codebase-memory*`) e hooks (`~/.claude/hooks` e `~/.orca`).
2. **Skills Híbridas:** Versionar no Git as skills autorais (`obsidian-memory`, `jarvis-mode`, `ai-pdf-template-importer`, `img2threejs`, `orca-cli`, `computer-use`) + `.skill-lock.json` com comando automático para restaurar as 130+ skills públicas.
3. **Obsidian Vault Bootstrap:** Criar `/Users/<user>/obsidian/Agentic OS` com `.obsidian/graph.json` colorido, plugin `dataview`, MOCs e `99_TEMPLATES/` sem sobrescrever notas já existentes (`cp -n` / `rsync --ignore-existing`).
4. **Shell & Pacotes:** Incluir `Brewfile`, `.zshrc` sanitizado e `.gitconfig` (sem tokens/chaves privadas).
5. **Segurança Zero-Leak:** Nenhuma credencial (`oauth_creds.json`, `auth.json`, tokens) comitada; todos os caminhos usam `$HOME`.

## 🚧 Constraints & Risks
- **Risco de sobrescrita:** O `install.sh` deve fazer backup automático (`*.bak`) antes de substituir `.zshrc` ou configs existentes, e nunca sobrescrever notas já criadas no vault Obsidian.
- **Risco de vazamento de segredos:** Filtrar variáveis de ambiente ou chaves de API do `.zshrc` para um `.zshrc.local` ignorado no Git.

## 🗺️ Implementation Plan
1. Clonar `https://github.com/adilsoncruz/personal-config-files` em `__HOME__/projects/personal-config-files` e inspecionar a estrutura atual.
2. Exportar e sanitizar (`$HOME`) os Kernels (`GEMINI.md`, `CLAUDE.md`, `AGENTS.md`), hooks (`~/.claude/hooks`, `~/.orca`), subagentes e skills customizadas.
3. Exportar o esqueleto do vault `Agentic OS` (`.obsidian/`, MOCs e `99_TEMPLATES/`) e configs de shell (`Brewfile`, `.zshrc`, `.gitconfig`).
4. Criar o `install.sh` idempotente + atualizar `README.md` com instruções de 1 comando.
5. Validar o `git status` / `git diff` garantindo zero segredos antes de comitar.
