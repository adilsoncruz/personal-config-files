---
name: yagni-kiss-sine
description: Enforces YAGNI (You Aren't Gonna Need It), KISS (Keep It Simple, Stupid), SINE (Simplicity Is Not Easy / Simple Is Nearly Everything), and Pragmatic Object Calisthenics during feature planning, coding, refactoring, and code reviews. Activates whenever designing architecture, implementing features, reviewing PRs, or evaluating abstractions.
---

# YAGNI + KISS + SINE + Pragmatic Object Calisthenics

Apply these principles on every plan, implementation, refactor, and code review. Silence over-engineering by default; pause and warn the user whenever a request introduces speculative complexity.

---

## 1. YAGNI (*You Aren't Gonna Need It*)
Build only what is required for the current, proven use case.

- **Rule of Three (`N >= 3`):** Do not extract a shared helper, base class, or generic wrapper until there are at least 3 concrete duplicates.
- **No Single-Implementation Interfaces:** Do not create an interface, protocol, or abstract factory if only one class implements it today (unless required at a hard external boundary for testing).
- **No Speculative Parameters or Flags:** Never add optional parameters, feature flags, config keys, or database columns "for future flexibility".
- **No Premature Optimization / Scaling:** Do not add caching layers, queues, worker pools, or sharding without a measured bottleneck or explicit acceptance criterion.

## 2. KISS (*Keep It Simple, Stupid*)
Choose the most direct, boring, and readable implementation that solves the problem.

- **Flat over Nested:** Prefer early returns (`guard` clauses) and linear control flow over deep nesting or clever functional chains.
- **Standard over Custom:** Use built-in language primitives and existing project dependencies instead of inventing custom mini-frameworks or DSLs.
- **Explicit over Magical:** Avoid metaprogramming, dynamic reflection, hidden decorators, or implicit global state when a direct function call works.
- **Local Locality of Behavior:** Keep related logic together in one file/function until file size or distinct responsibilities genuinely force a split.

## 3. SINE (*Simplicity Is Not Easy / Simple Is Nearly Everything*)
Earn simplicity by subtracting layers and resisting accidental complexity.

- **Subtraction First:** Before adding new code, ask if the problem can be solved by deleting, simplifying, or reusing an existing path.
- **Zero-Indirection Default:** Every extra file, wrapper, DTO mapper, or pass-through function has a cognitive tax. Justify every hop.
- **30-Second Readability Test:** Any engineer should understand what a function does within 30 seconds without jumping across 4 files.

## 4. Pragmatic Object Calisthenics (The 5 Rules That Serve KISS/SINE)
Apply the subset of Object Calisthenics that improves readability without triggering class explosion:

1. **No `else` Keyword:** Always use *Early Returns* / *Guard Clauses* at the top of the function to handle edge cases and exit early.
2. **Shallow Indentation (1–2 Levels Max):** Extract a local helper function or flatten loops/conditionals when indentation exceeds 2 levels.
3. **Don't Abbreviate:** Use clear, domain-accurate identifiers (`invoiceTotal`, not `invTot`), except for trivial loop indices or standard conventions (`id`, `url`, `err`).
4. **Law of Demeter (One Dot Per Line):** Avoid train wrecks (`order.getCustomer().getAddress().getZip()`), except for standard fluent APIs/collections (`.filter().map()`).
5. **Value Objects Only When Logic Exists:** Wrap primitives (`Money`, `CPF`, `Email`) **only** when they carry validation, invariants, or formatting logic—never wrap plain primitives or collections "just because" (YAGNI wins over dogmatism).

---

## Mandatory Workflow

### Mode A: Feature Planning & Coding
1. **Default to Minimum Viable Code:** Write the smallest, most direct solution that satisfies the confirmed acceptance criteria.
2. **Block & Warn on Over-Engineering:** If a requirement or prompt asks for speculative abstractions (e.g., *"create a plugin system"*, *"make it generic for future providers"*, *"add a factory"* when only 1 case exists), **stop before coding** and reply:
   - **Alerta YAGNI/KISS/SINE:** Point out the extra complexity in 1 sentence.
   - **Alternativa Simples:** Propose the direct implementation and state the time/lines saved.
   - Ask if the user wants the simple version or truly needs the abstraction now.

### Mode B: Code Review & Refactoring Checklist
When reviewing code or a diff, flag violations categorized as:
1. `[YAGNI]` Dead code, unused parameters, single-use abstractions, or "just-in-case" branches.
2. `[KISS]` Overly clever expressions, deep nesting (> 2 levels), or unnecessary design patterns.
3. `[SINE]` Pass-through wrappers, redundant DTO conversions, or files that can be inlined/deleted.
4. `[CALISTHENICS]` Unnecessary `else` blocks, deep indentation, cryptic abbreviations, Law of Demeter train wrecks, or unvalidated primitive obsession.
