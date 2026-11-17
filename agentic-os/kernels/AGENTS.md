<!-- codebase-memory-mcp:start -->
# Codebase Memory

## Codebase Knowledge Graph (codebase-memory-mcp)

This project uses codebase-memory-mcp to maintain a knowledge graph of the codebase.
ALWAYS prefer MCP graph tools over grep/glob/file-search for code discovery.

### Priority Order
1. `search_graph` — find functions, classes, routes, variables by pattern
2. `trace_path` — trace who calls a function or what it calls
3. `get_code_snippet` — read specific function/class source code
4. `check_index_coverage` — validate candidate paths and missed ranges before claims
5. `query_graph` — run Cypher queries for complex patterns
6. `get_architecture` — high-level project summary

### Evidence tiers
- **Scout (Tier 1):** quick positive lookup with few calls and targeted source checks. Mark it provisional; do not make negative or exhaustive claims.
- **Verify (Tier 2, default):** task-directed graph evidence, relevant trace directions, exact snippets for material claims, and relevant pagination.
- **Auditor (Tier 3):** bounded-scope full verification with current generation, complete relevant pagination, both call directions and broader relationships when material, and every limitation disclosed.
- After candidate paths are known in any tier, call `check_index_coverage` once with every evidence path. Add relevant scopes for negative or exhaustive claims. A clean result means no recorded gap, not proof of completeness. For partial, skipped, excluded, stale, pending, or unknown coverage, read/grep the reported ranges or scope before relying on graph results.

### When to fall back to grep/glob
- Searching for string literals, error messages, config values
- Searching non-code files (Dockerfiles, shell scripts, configs)
- When MCP tools return insufficient results

### Examples
- Find a handler: `search_graph(name_pattern=".*OrderHandler.*")`
- Who calls it: `trace_path(function_name="OrderHandler", direction="inbound")`
- Read source: `get_code_snippet(qualified_name="pkg/orders.OrderHandler")`

### Session resets and subagents
- At session start or after compaction, confirm the nearest graph project and generation with `list_projects` or `index_status`, then choose Scout, Verify, or Auditor.
- Before spawning a subagent, query the graph and coverage in the parent. Pass the tier, project, generation/freshness, bounded scope, queries and pagination state, qualified symbols, paths, call-chain findings, coverage evidence with ranges/reasons, source fallback already performed, and unresolved questions in the delegated task context.
- Do not assume subagents inherit MCP access or the parent conversation. If a child lacks MCP tools, it must not call or claim MCP access. It should use the supplied evidence and read/grep exact source, especially every reported missed-coverage range.
<!-- codebase-memory-mcp:end -->

<!-- obsidian-memory:start -->
## Obsidian Memory (`Agentic OS`)

Persistent architectural and episodic memory lives in `__HOME__/obsidian/Agentic OS` (direct local filesystem access via `obsidian-memory` skill; no external server required).

1. **Progressive Disclosure (Read):** Never load the whole vault. Start at `__HOME__/obsidian/Agentic OS/00_HOME.md` or the layer MOC (`01_PROJECTS`, `02_SPECS`, `03_DECISIONS`, `04_SESSIONS`, `05_KNOWLEDGE`) and follow relevant `[[wikilinks]]`.
2. **When to Read:** Before starting a new feature/refactor (check project context & ADRs in `01_PROJECTS` / `03_DECISIONS`) and when resuming work (check latest handoff in `04_SESSIONS`).
3. **When to Write:**
   - After Feature Interviewer approval → write `02_SPECS/SPEC_YYYY-MM-DD_<Slug>.md`.
   - After an architectural decision → write `03_DECISIONS/ADR_NNN_<Slug>.md`.
   - At session handoff or milestone completion → write `04_SESSIONS/SES_YYYY-MM-DD_<Slug>.md` and update `06_DAILY/YYYY-MM-DD.md`.
4. **Graph Hygiene:** Every note must include YAML frontmatter (`type`, `project`, `status`, `updated_at`, `tags`) and `[[wikilinks]]` back to its MOC and project so Obsidian's Graph View has zero orphan nodes.
5. **Jarvis Mode (`jarvis-mode` skill):** When the user says `"jarvis"`, `"briefing do dia"`, `"processar fila"`, or `"fechar dia"`, follow `__HOME__/.agents/skills/jarvis-mode/SKILL.md` to read/execute the `#jarvis` Intent Queue in `00_HOME.md`, generate daily briefings, and optionally speak summaries with `say -v Luciana`.
<!-- obsidian-memory:end -->

## Output style

The reader has ADHD. Shape every response so it can be acted on:

1. Lead with the answer or next action: command, path, or snippet first.
2. Number multi-step work; one bounded action per step.
3. End with one next action doable in under two minutes.
4. Finish the current issue before raising a new one.
5. Restate progress each turn ("step 3 of 5 done").
6. Give time estimates in concrete units, never "a bit".
7. After a change, show what now works.
8. Errors: state location, cause, and fix. No drama.
9. Cap lists to 5 items.
10. No preamble, no recaps, no closers.

Exceptions: explain fully when asked to explain. Confirm before destructive actions. After three failed fixes, stop and name the doubtful assumption. If the request is ambiguous, ask one short question.

## Feature Interviewer — always on

For a new feature, fix, task, or new scope, interview the user before implementing.
Ask short questions about the goal, acceptance criteria, scope, affected systems,
constraints, edge cases, and non-goals. Do not start coding until requirements are
clear, unless the user explicitly authorizes documented assumptions. Skip the full
interview for trivial changes. Then summarize the confirmed requirements, acceptance
criteria, risks, and plan.
