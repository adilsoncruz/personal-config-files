---
type: adr
project: "[[PRJ_Agentic_OS]]"
status: accepted
updated_at: 2026-11-17
tags:
  - adr
  - agentic-os
---

# 🏛️ ADR 003: Roteamento Nativo de Modelos no AGY (Sem Jev Externo)

Conectado a: [[03_Decisions_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## Contexto
No Claude Code, usuários instalam o `jev-router` (TypeSafe AI) para rotear prompts entre Haiku, Sonnet e Opus. No entanto, o ambiente principal utilizado aqui é o **AGY (Antigravity Gemini)**, que já possui suporte nativo a tiers de modelos em `invoke_subagent` e `swarm`.

## Decisão
Usar o roteamento nativo do AGY via regra global no `GEMINI.md` (`<!-- model-routing:start -->`), classificando subtarefas em 3 tiers sem depender de API externa:
1. **`flash_lite` (Tier 1):** Triagem rápida, formatação, buscas simples e leitura de notas no Obsidian.
2. **`flash` (Tier 2):** Código padrão, testes unitários, documentação e verificações intermediárias.
3. **`pro` / `inherit` (Tier 3):** Arquitetura complexa, debugging profundo e auditorias.

## Consequências
- **Positivas:** Economia de cota e menor latência em subtarefas sem precisar de proxy ou chave da TypeSafe AI.
- **Trade-offs:** A conversa principal mantém o modelo selecionado pelo usuário, delegando o roteamento automático para subagentes e workers do swarm.
