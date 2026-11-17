# CLI and video notes

The CLI and Google GenAI video models can change. Before generation, inspect the installed command and documentation:

```bash
gemini-api-cli --help
gemini-api-cli video --help
```

Use the exact model and input flags reported by the installed CLI. If the command is a project-local script, inspect its package scripts and README before running it.

For a long video, treat the model's documented maximum duration as a ceiling, not a promise of continuity. Prefer shorter shots with explicit end states and a final-frame image reference for the next shot.
