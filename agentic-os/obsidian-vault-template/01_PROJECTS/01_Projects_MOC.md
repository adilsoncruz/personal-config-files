---
type: moc
status: active
updated_at: 2026-11-17
tags:
  - moc
---

# 🚀 01 Projects — Mapa de Projetos

Conectado a: [[00_HOME]]

## Projetos Registrados

- [[PRJ_Agentic_OS|Agentic OS (Workspace Multi-Agente)]]
- [[PRJ_Open_PDF_Generator|Open PDF Generator & Snapshot Testing]]
- [[PRJ_Mock_Platform|Mock Platform]]

```dataview
TABLE status, stack, repo_path, updated_at
FROM "01_PROJECTS"
WHERE type = "project"
SORT updated_at DESC
```
