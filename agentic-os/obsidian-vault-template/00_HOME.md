---
type: moc
status: active
updated_at: 2026-11-17
tags:
  - moc
  - agentic-os
---

# 🧠 Agentic OS — Neural Hub

> **Ponto de entrada único para agentes (Claude Code & Gemini/Antigravity).**
> Os agentes usam *Progressive Disclosure*: começam por este índice, seguem apenas os `[[wikilinks]]` relevantes e gravam estado nas camadas abaixo.

## 🗺️ Camadas de Memória (Maps of Content)

- 📥 [[00_Inbox_MOC|00 Inbox (Triagem Rápida)]]
- 🚀 [[01_Projects_MOC|01 Projects (Contexto de Repositórios)]]
- 📋 [[02_Specs_MOC|02 Specs (Feature Interviewer & Planos)]]
- 🏛️ [[03_Decisions_MOC|03 Decisions (ADRs & Arquitetura)]]
- 🔄 [[04_Sessions_MOC|04 Sessions (Handoffs entre Conversas)]]
- 📚 [[05_Knowledge_MOC|05 Knowledge (Runbooks & Aprendizados)]]
- 📅 [[2026-11-17|06 Daily Log (Hoje)]]

---

## ⚡ Jarvis Intent Queue (`#jarvis`)

> Adicione tarefas rápidas abaixo com `- [ ] #jarvis ...` e diga **"processar fila"** ou **"briefing do dia"** no AGY.

- [ ] #jarvis Revisar pendências do projeto [[PRJ_Open_PDF_Generator]]

```dataview
TASK
FROM ""
WHERE !completed AND contains(text, "#jarvis")
```

---

## 🚀 Projetos Ativos

```dataview
TABLE status AS "Status", repo_path AS "Repositório", updated_at AS "Atualizado"
FROM "01_PROJECTS"
WHERE type = "project"
SORT updated_at DESC
```

## 📋 Últimas Specs (Feature Interviewer)

```dataview
TABLE project AS "Projeto", status AS "Status", updated_at AS "Data"
FROM "02_SPECS"
WHERE type = "spec"
SORT updated_at DESC
LIMIT 5
```

## 🔄 Últimos Handoffs de Sessão

```dataview
TABLE project AS "Projeto", agent AS "Agente", next_action AS "Próxima Ação"
FROM "04_SESSIONS"
WHERE type = "session"
SORT updated_at DESC
LIMIT 5
```

## 🏛️ Decisões Arquiteturais (ADRs)

```dataview
TABLE project AS "Projeto", status AS "Status", updated_at AS "Data"
FROM "03_DECISIONS"
WHERE type = "adr"
SORT updated_at DESC
LIMIT 5
```
