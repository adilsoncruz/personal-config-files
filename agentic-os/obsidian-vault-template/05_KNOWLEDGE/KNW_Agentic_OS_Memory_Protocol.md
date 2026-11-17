---
type: knowledge
area: "workflow"
project: "[[PRJ_Agentic_OS]]"
updated_at: 2026-11-17
tags:
  - knowledge
  - agentic-os
---

# 📚 Protocolo de Leitura e Escrita do Agentic OS

Conectado a: [[05_Knowledge_MOC]] | Projeto: [[PRJ_Agentic_OS]]

## 1. Quando Consultar (Read Triggers)
1. **Início de nova feature/arquitetura:** Ler `00_HOME.md` → `01_PROJECTS/PRJ_<Nome>.md` e ADRs vinculados em `03_DECISIONS/`.
2. **Retomada de trabalho ("continuar de onde paramos"):** Ler a nota mais recente em `04_SESSIONS/`.
3. **Dúvida sobre padrão ou bug recorrente:** Buscar em `05_KNOWLEDGE/`.

## 2. Quando Gravar (Write Triggers)
1. **Após aprovação no Feature Interviewer:** Criar spec em `02_SPECS/SPEC_YYYY-MM-DD_<Titulo>.md` e linkar no projeto.
2. **Ao tomar decisão arquitetural relevante:** Criar ADR em `03_DECISIONS/ADR_NNN_<Titulo>.md`.
3. **Ao finalizar tarefa longa ou pedir handoff:** Criar nota em `04_SESSIONS/SES_YYYY-MM-DD_<Titulo>.md` e registrar no Daily Log (`06_DAILY/YYYY-MM-DD.md`).

## 3. Regra de Ouro do Grafo
Toda nota criada **deve** conter:
- Frontmatter YAML com `type`, `project`, `status`, `updated_at`, `tags`.
- Pelo menos um link para o seu MOC (`[[01_Projects_MOC]]`, `[[02_Specs_MOC]]`, etc.) e para o projeto (`[[PRJ_...]]`) para nunca criar nós órfãos no Graph View.
