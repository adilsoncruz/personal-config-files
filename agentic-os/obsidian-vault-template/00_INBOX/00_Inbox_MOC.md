---
type: moc
status: active
updated_at: 2026-11-17
tags:
  - moc
---

# 📥 00 Inbox — Captura Rápida

Conectado a: [[00_HOME]]

Notas rápidas, ideias ainda não classificadas ou rascunhos capturados durante sessões antes de virarem [[02_Specs_MOC|Spec]], [[03_Decisions_MOC|ADR]] ou [[05_Knowledge_MOC|Knowledge]].

```dataview
LIST
FROM "00_INBOX"
WHERE file.name != "00_Inbox_MOC"
SORT file.mtime DESC
```
