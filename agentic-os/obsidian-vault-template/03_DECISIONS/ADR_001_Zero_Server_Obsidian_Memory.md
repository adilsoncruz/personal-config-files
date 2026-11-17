---
type: adr
project: "[[PRJ_Agentic_OS]]"
status: accepted
updated_at: 2026-11-17
tags:
  - adr
  - agentic-os
---

# 🏛️ ADR 001: Memória Obsidian Zero-Server via Disco Local + Skill

Conectado a: [[03_Decisions_MOC]] | Projeto: [[PRJ_Agentic_OS]] | Spec: [[SPEC_2026-11-17_Obsidian_Agentic_OS]]

## Contexto
Servidores MCP customizados via `npx` podem falhar silenciosamente ou adicionar latência, enquanto o vault do Obsidian já reside localmente em `__HOME__/obsidian/Agentic OS` como arquivos Markdown puros.

## Decisão
Usar acesso nativo de filesystem (`Read`/`Write`/`Edit`/`Grep`) guiado pela skill `obsidian-memory` e pelo protocolo em `CLAUDE.md` / `GEMINI.md`. O `vaultbridge-mcp` permanece dedicado apenas aos vaults de mídia/personagens (`YURA` e `Mochi's Curious Life`).

## Consequências
- **Positivas:** Zero processos extras rodando, 100% confiável tanto no Claude Code quanto no Gemini/Antigravity, edição imediata de frontmatter YAML e `[[wikilinks]]`.
- **Trade-offs:** Exige que a regra de caminho do vault esteja explícita no `CLAUDE.md` e `GEMINI.md`.
