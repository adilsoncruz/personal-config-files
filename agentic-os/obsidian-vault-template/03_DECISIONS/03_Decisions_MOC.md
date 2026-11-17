---
type: moc
status: active
updated_at: 2026-11-17
tags:
  - moc
---

# 🏛️ 03 Decisions — Architecture Decision Records (ADRs)

Conectado a: [[00_HOME]]

Decisões técnicas tomadas com agentes para que futuras sessões respeitem restrições e padrões definidos.

- [[ADR_001_Zero_Server_Obsidian_Memory|ADR 001: Memória Obsidian Zero-Server via Disco Local + Skill]]
- [[ADR_002_Codebase_Memory_Graph_First|ADR 002: Prioridade ao Grafo codebase-memory-mcp sobre Grep/Glob]]
- [[ADR_003_Native_AGY_Model_Routing|ADR 003: Roteamento Nativo de Modelos no AGY (Sem Jev Externo)]]

```dataview
TABLE project, status, updated_at
FROM "03_DECISIONS"
WHERE type = "adr"
SORT updated_at DESC
```
