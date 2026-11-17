---
type: knowledge
area: "architecture"
project: "[[PRJ_Agentic_OS]]"
updated_at: 2026-11-17
tags:
  - knowledge
---

# 📚 Arquitetura Multi-Engine (~/.agents, ~/.claude, ~/.gemini)

Conectado a: [[05_Knowledge_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## Estrutura Local na Máquina
1. **`~/.agents/skills/`:** Repositório central com 130+ skills compartilhadas.
2. **`~/.gemini/`:** Configuração do Gemini CLI e Antigravity (`GEMINI.md`, `settings.json`, `agents/`, `skills/`).
3. **`~/.codex/`:** Configuração do OpenAI Codex CLI (`AGENTS.md`, `agents/`, `skills/`).
4. **`~/.claude/`:** Configuração do Claude Code (`CLAUDE.md`, `settings.json`, `hooks/`, `agents/`, `skills/`).
5. **`__HOME__/obsidian/Agentic OS`:** Memória persistente compartilhada entre todos os 3 engines (AGY, Codex e Claude).
