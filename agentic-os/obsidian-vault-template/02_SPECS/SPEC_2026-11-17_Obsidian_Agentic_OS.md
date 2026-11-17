---
type: spec
project: "[[PRJ_Agentic_OS]]"
status: approved
updated_at: 2026-11-17
tags:
  - spec
  - agentic-os
---

# 📋 Spec: Implementação do Obsidian Agentic OS

Conectado a: [[02_Specs_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## 🎯 Goal (Objetivo)
Transformar o Obsidian em uma camada de memória persistente real no padrão **Claude Agentic OS**, com leitura por *Progressive Disclosure*, escrita determinística em disco (zero servidor/MCP para falhar) e visualização por cores no Graph View.

## ✅ Acceptance Criteria
1. Vault criado em `__HOME__/obsidian/Agentic OS` com 7 camadas estruturadas (`00_HOME`, `00_INBOX` a `06_DAILY` e `99_TEMPLATES`).
2. Graph View (`.obsidian/graph.json`) pré-configurado com 7 grupos de cores por pasta/tag e plugin `dataview` instalado.
3. Skill `obsidian-memory` instalada em `~/.agents/skills`, `~/.claude/skills` e `~/.gemini/skills`.
4. `CLAUDE.md` e `GEMINI.md` sincronizados com os módulos: **Codebase Memory**, **Obsidian Memory**, **ADHD Output Style** e **Feature Interviewer**.

## 🚧 Constraints & Non-Goals
- Sem dependência de Ollama, banco externo ou servidor MCP em background para ler/gravar notas de engenharia.
- Não carregar o vault inteiro no contexto; usar sempre `00_HOME.md` e MOCs como índice inicial.

## 🗺️ Implementation Plan
1. Criar estrutura de diretórios e `.obsidian` no vault `Agentic OS`.
2. Criar `00_HOME.md`, MOCs, Templates e notas iniciais conectadas via `[[wikilinks]]`.
3. Criar a skill `obsidian-memory` com regras claras de *When to Read* e *When to Write*.
4. Atualizar `CLAUDE.md` e `GEMINI.md` com o protocolo unificado.
