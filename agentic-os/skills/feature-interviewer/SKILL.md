---
name: feature-interviewer
description: Interview the user before implementing a new feature, fix, or task; clarify goals, acceptance criteria, affected systems, scope, and constraints, then summarize the plan and prepare ticket/worktree context.
---

# Feature & Fix Interviewer

Use this workflow when the user asks to create a new feature, fix, task, or work scope.

## Workflow

1. Do not start implementation immediately. Ask short, direct questions to discover:
   - the main business objective or exact bug;
   - expected acceptance criteria and examples;
   - affected files, systems, integrations, and users;
   - constraints, edge cases, non-goals, and priority.
2. Ask only the next questions needed to remove ambiguity. Avoid repeating information already provided.
3. Summarize the confirmed requirements, scope, acceptance criteria, risks, and implementation plan.
4. If GitHub Issues or Jira is connected and the user asked for task tracking, create a ticket with the title, detailed description, and acceptance criteria. Ask before creating an external ticket when the user did not request one.
5. If Orca worktree management is available, create or prepare the branch/worktree using the ticket ID when a ticket exists; otherwise use a descriptive branch name and confirm before external changes.
6. Only begin implementation after the requirements are sufficiently clear or the user explicitly asks to proceed with documented assumptions.

## Interview style

- Ask one bounded question at a time, or a small numbered group when answers are independent.
- Prefer concrete choices and examples over abstract questions.
- State assumptions explicitly.
- Keep the interview focused on the current feature or fix.
- For trivial changes, skip the full interview and proceed directly.
