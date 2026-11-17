---
name: daily-summary
description: Create concise daily meeting summaries from task activity and Slack messages associated with the current user, initiative, or project.
---

# Daily Summary

Use this skill when the user asks for a daily, stand-up, progress report, or meeting-ready status summary.

## Default output location

Save reports in the global folder:

`__HOME__/Orca/Dailies/`

Create the folder if it does not exist. Use one Markdown file per day:

`YYYY-MM-DD.md`

Do not save reports inside an individual repository unless the user explicitly requests it.

## Scope of activity

Prioritize activity associated with the current user:

- messages authored by the user;
- tasks assigned to or mentioning the user;
- changes, reviews, and worktree activity attributed to the user;
- messages and threads explicitly tagged with the initiative or task.

When the user provides a Slack search, export, links, or connected Slack data, preserve source links for every material claim. Do not infer ownership from a message merely because the user reacted to it.

## Summary format

Write a scannable report with these sections:

1. `Done` — completed work since the previous report.
2. `In progress` — active work and current state.
3. `Blocked` — blockers, dependencies, and owner if known.
4. `Decisions` — decisions or changes agreed in conversations.
5. `Next` — concrete next actions for the user.
6. `Sources` — Slack links, task links, and repository links.

Group items by initiative or project. Put items with no reliable project association under `Unassigned`. Use `No updates found` when a section has no evidence; never fabricate progress.

## Slack handling

Search by the user's Slack identity, initiative names, project terms, channel, and date range. Prefer explicit tags such as `#initiative-name`, dedicated channels, and thread context. Slack's modern “Save for later” items are not a reliable direct API source, so ask for saved-message links or use searchable tags when saved items are unavailable.

## Automation

If asked to schedule the report, create or update an Orca daily automation that runs after the user's chosen start-of-day time. The automation should gather the configured period, write the dated Markdown file, and only post to Slack after the user has connected an approved Slack integration and selected a destination channel.

## Privacy and confirmation

Treat Slack content as private. Do not post summaries externally, include private-message content, or broaden the search scope without explicit authorization. Before the first Slack read or post, confirm the workspace/account and destination when they are ambiguous.
