---
name: gemini-video-generator
description: Generate reference-driven videos with the Google GenAI Gemini API CLI, using Obsidian vault assets such as character sheets and continuity frames; use segmented generation for long videos.
---

# Gemini Video Generator

Use this skill when the user asks to create or continue a video with Google GenAI/Gemini, especially when reference files live in an Obsidian vault.

## Required workflow

1. Clarify the creative brief before generating:
   - subject, action, setting, camera, style, lighting, aspect ratio, duration, frame rate, audio, and safety constraints;
   - which Obsidian references are authoritative and what must remain unchanged;
   - whether the request is one clip or a long sequence.
2. Locate and inspect requested references from the Obsidian vault through the available `vaultbridge` MCP tools. Prefer the exact character sheet, pose sheet, environment reference, palette, and prior continuity frame named by the user.
3. Confirm the active Gemini API CLI syntax with `gemini-api-cli --help` or the installed project documentation before running generation. Do not invent flags, model names, or input formats. Use the Google GenAI video-capable model configured by the user or the current CLI default.
4. Build a concise generation prompt that separates:
   - immutable identity/style constraints from;
   - the action and shot-specific direction;
   - negative constraints and continuity requirements.
5. Generate the clip and save outputs in a dedicated, timestamped directory. Preserve the exact prompt, model, CLI command, input references, seed/options when available, and returned metadata in a manifest.

## Long-video continuity

For requests longer than the selected model's reliable single-generation duration:

1. Break the story into ordered shots or segments with explicit start/end states.
2. Generate segment 1.
3. Extract the final frame from the rendered segment with `ffmpeg`, preserving the source resolution and color range. Use a lossless or high-quality PNG when the frame becomes a visual reference.
4. Feed that final frame, plus the original authoritative character/environment references, into the next segment. State that the frame is the continuity anchor and that identity, costume, geometry, lighting direction, and camera language must persist unless the user requests a change.
5. Repeat until complete. Never use only the previous frame as the sole reference when the original character sheet is available; this prevents visual drift.
6. Concatenate segments only after checking frame dimensions, frame rate, audio policy, and transition continuity. Avoid re-encoding when stream-compatible; otherwise use an explicit final render.

## Continuity manifest

Maintain a machine-readable manifest beside the outputs containing, at minimum:

```json
{
  "project": "...",
  "references": ["vault/path/to/reference.png"],
  "segments": [
    {
      "index": 1,
      "prompt": "...",
      "command": "...",
      "output": "segment-001.mp4",
      "lastFrame": "segment-001-last-frame.png"
    }
  ]
}
```

## Safety and user control

- Ask for confirmation immediately before a paid API call when cost or quota is not already authorized.
- Do not overwrite source references or existing renders; create a new output directory.
- If the CLI, model, API key, reference path, or frame-extraction tool is unavailable, report the exact blocker and provide the next command or setting needed.
- For a trivial one-shot preview, skip the full segmentation/manifest ceremony but still preserve the prompt and output path.

## Supporting references

- Read [references/cli-and-video.md](references/cli-and-video.md) when the CLI syntax or model-specific video limits need verification.
- Use [scripts/extract-last-frame.sh](scripts/extract-last-frame.sh) for deterministic continuity-frame extraction.
