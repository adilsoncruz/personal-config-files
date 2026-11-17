---
type: adr
project: "[[PRJ_Agentic_OS]]"
status: accepted
updated_at: 2026-11-17
tags:
  - adr
---

# 🏛️ ADR 002: Separação entre Memória de Código (Grafo) e Memória Episódica (Obsidian)

Conectado a: [[03_Decisions_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## Contexto
Agentes precisam saber tanto **como o código está estruturado agora** quanto **por que decisões foram tomadas no passado**.

## Decisão
1. **Descoberta de código estrutural (Funções, Call Chains, Classes):** Usar sempre `codebase-memory-mcp` (`search_graph`, `trace_path`, `get_code_snippet`).
2. **Contexto de produto, specs, decisões arquiteturais (ADRs) e handoffs entre sessões:** Usar o vault `__HOME__/obsidian/Agentic OS`.
