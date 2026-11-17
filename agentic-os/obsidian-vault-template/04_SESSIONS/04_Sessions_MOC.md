---
type: moc
status: active
updated_at: 2026-11-17
tags:
  - moc
---

# 🔄 04 Sessions — Handoffs de Sessão

Conectado a: [[00_HOME]]

Estado persistido ao encerrar ou pausar tarefas para continuidade imediata em novas conversas.

- [[SES_2026-11-17_Bootstrap_Agentic_OS|Sessão 2026-11-17: Bootstrap do Vault Agentic OS]]

```dataview
TABLE project, agent, status, next_action, updated_at
FROM "04_SESSIONS"
WHERE type = "session"
SORT updated_at DESC
```
