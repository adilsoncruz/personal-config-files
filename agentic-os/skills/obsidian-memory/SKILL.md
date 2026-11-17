---
name: obsidian-memory
description: Persistent episodic and architectural memory in the Obsidian vault "__HOME__/obsidian/Agentic OS". Use when starting a project/feature to read prior specs, ADRs, and session handoffs, or when saving Feature Interviewer specs, architecture decisions (ADRs), session handoffs, daily logs, and reusable engineering knowledge.
---

# Obsidian Memory (`Agentic OS`)

Vault path: `__HOME__/obsidian/Agentic OS`

## Architecture & Progressive Disclosure

Never read the entire vault into context. Always navigate in funnel order:
1. Read `__HOME__/obsidian/Agentic OS/00_HOME.md` or the specific MOC (`01_PROJECTS/01_Projects_MOC.md`, `02_SPECS/02_Specs_MOC.md`, `03_DECISIONS/03_Decisions_MOC.md`, `04_SESSIONS/04_Sessions_MOC.md`, `05_KNOWLEDGE/05_Knowledge_MOC.md`).
2. Follow only the relevant `[[wikilinks]]` for the active project or task.
3. Use direct local filesystem tools (`read_file`/`write_file`/`edit_file` or `Read`/`Write`/`Edit`) — no external MCP server or Ollama daemon is required.

## Folder Map & Naming Conventions

| Folder | Purpose | Naming Pattern | Required Tag |
| :--- | :--- | :--- | :--- |
| `00_INBOX/` | Quick uncategorized captures | `<Title>.md` | `#inbox` |
| `01_PROJECTS/` | Project hubs & repo paths | `PRJ_<Project_Name>.md` | `#project` |
| `02_SPECS/` | Approved Feature Interviewer specs | `SPEC_YYYY-MM-DD_<Slug>.md` | `#spec` |
| `03_DECISIONS/` | Architecture Decision Records (ADRs) | `ADR_NNN_<Slug>.md` | `#adr` |
| `04_SESSIONS/` | Cross-session handoffs & progress | `SES_YYYY-MM-DD_<Slug>.md` | `#session` |
| `05_KNOWLEDGE/` | Runbooks, root causes, patterns | `KNW_<Slug>.md` | `#knowledge` |
| `06_DAILY/` | Daily execution log | `YYYY-MM-DD.md` | `#daily` |
| `99_TEMPLATES/` | Note templates | `TPL_<Type>.md` | — |

## When to Read (Read Triggers)

1. **Before starting a feature, refactor, or architecture change:** Check `01_PROJECTS/` and `03_DECISIONS/` for existing project context and ADRs.
2. **When resuming prior work:** Read the latest note in `04_SESSIONS/` or `06_DAILY/`.

## When to Write (Write Triggers)

1. **After Feature Interviewer approval:** Save the confirmed spec to `02_SPECS/SPEC_YYYY-MM-DD_<Slug>.md` and link it in `02_Specs_MOC.md` and the project note.
2. **When an architectural decision is made:** Create `03_DECISIONS/ADR_NNN_<Slug>.md` and link it in `03_Decisions_MOC.md`.
3. **At session handoff or milestone completion:** Create `04_SESSIONS/SES_YYYY-MM-DD_<Slug>.md`, link it in `04_Sessions_MOC.md`, and append a summary line to `06_DAILY/YYYY-MM-DD.md`.

## Graph Hygiene Rule (Zero Orphan Nodes)

Every note created or updated MUST:
1. Include valid YAML frontmatter (`type`, `project`, `status`, `updated_at`, `tags`).
2. Link back to its layer MOC (e.g., `Conectado a: [[02_Specs_MOC]] | Projeto: [[PRJ_...]]`) so Obsidian's Graph View stays connected and color-coded.
