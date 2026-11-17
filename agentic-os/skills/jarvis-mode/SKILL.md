---
name: jarvis-mode
description: Personal Agentic OS assistant ("Jarvis Mode") for AGY Gemini integrated with the Obsidian vault "__HOME__/obsidian/Agentic OS". Activates when the user says "jarvis", "briefing do dia", "bom dia jarvis", "fechar dia", "processar fila", or asks for a spoken voice summary.
---

# Jarvis Mode (AGY + Obsidian Command Center)

Vault path: `__HOME__/obsidian/Agentic OS`

## 1. Morning / Session Briefing (`"briefing do dia"` / `"bom dia jarvis"`)

1. Delegate a fast lookup (`invoke_subagent` with `Model: "flash_lite"`, `TypeName: "research"`) to read:
   - `__HOME__/obsidian/Agentic OS/00_HOME.md` (specifically the `⚡ Jarvis Intent Queue` section)
   - `__HOME__/obsidian/Agentic OS/04_SESSIONS/04_Sessions_MOC.md` (and the newest session file)
   - `__HOME__/obsidian/Agentic OS/00_INBOX/00_Inbox_MOC.md`
2. Create or update today's Daily Log at `__HOME__/obsidian/Agentic OS/06_DAILY/YYYY-MM-DD.md` (using `99_TEMPLATES/TPL_Daily_Log.md` structure).
3. Present a concise ADHD-friendly briefing (max 5 items):
   - **Última Sessão:** Onde paramos e qual era o próximo passo.
   - **Fila `#jarvis` Aberta:** Tarefas pendentes marcadas com `- [ ] #jarvis`.
   - **Próxima Ação (< 2 min):** A ação nº 1 recomendada para começar agora.

## 2. Intent Queue Execution (`"processar fila"` / `"jarvis fila"`)

1. Read open `- [ ] #jarvis` tasks from `__HOME__/obsidian/Agentic OS/00_HOME.md` (or search for `- \[ \] .*#jarvis` inside `__HOME__/obsidian/Agentic OS`).
2. Route each task to the appropriate AGY model tier (`flash_lite` for lookups/notes, `flash` for standard edits, `pro`/`inherit` for architecture).
3. As each item completes, update the Markdown checkbox from `- [ ] #jarvis` to `- [x] #jarvis ✅ (YYYY-MM-DD)` and log the delivery in `06_DAILY/YYYY-MM-DD.md`.

## 3. End-of-Day / Session Wrap-Up (`"fechar dia"` / `"jarvis handoff"`)

1. Write a new session handoff note in `__HOME__/obsidian/Agentic OS/04_SESSIONS/SES_YYYY-MM-DD_<Slug>.md`.
2. Link it in `__HOME__/obsidian/Agentic OS/04_SESSIONS/04_Sessions_MOC.md` and `__HOME__/obsidian/Agentic OS/06_DAILY/YYYY-MM-DD.md`.
3. State the single next action for tomorrow.

## 4. Local Voice Output (`"jarvis voz"` or when voice is requested)

When the user asks Jarvis to speak the summary aloud, run macOS native PT-BR TTS in the terminal (max 2 short sentences so it finishes in < 8 seconds):
```bash
say -v Luciana -r 205 "Resumo pronto. Temos 1 tarefa na fila do Jarvis para o projeto Open PDF Generator."
```
