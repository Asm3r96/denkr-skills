---
name: journey-logbook
description: Create or reuse a journey, then save timeline-style logs into it using Denkr's built-in journey tools.
---

# Journey Logbook

Use this skill when the user wants to create a new journey, save an ongoing timeline inside a journey, or add a new log/update to an existing journey.

## Objective

Help the user keep a clean visible record inside Denkr journeys by:

- finding an existing matching journey before creating a new one
- creating a new journey only when needed
- adding clear logs to the correct journey
- keeping each saved item easy to inspect later

## Workflow

1. Decide whether the request fits a journey workflow.
- Use this skill for visible saved history, ongoing projects, people context, family timelines, journals, travel logs, and similar user-facing records.
- Do not use this skill for durable assistant memory unless the user is clearly asking to save content into a journey.

2. Look for an existing journey first.
- Use `journey.list` with a short natural-language query or category filter.
- If there is a strong obvious match, reuse it.
- If multiple matches look plausible, ask the user one short clarification.

3. Create a journey only if needed.
- Use `journey.create` when no existing journey is a good fit.
- Keep the title short and human.
- Write a compact description that explains what belongs in the journey.
- Add a category only when it is genuinely useful.

4. Save the new log.
- Use `journey.log.create`.
- Put the real user content into `content`.
- Add a short title only if it helps later scanning.
- Use `occurredAt` only when the user gave a meaningful time or date.
- Add keywords only when they help future retrieval.

5. Confirm clearly.
- Say whether you reused an existing journey or created a new one.
- Mention the journey title.
- Briefly describe what was saved.

6. When the user wants to review prior logs:
- Use `journey.log.list`.
- Use `recent` mode by default.
- Use a date filter or `all` only when the user asks for broader history.

## Decision Rules

- Reuse before create.
- Ask a short clarification instead of guessing when the destination is ambiguous.
- Keep journey descriptions and log titles calm and compact.
- Do not save duplicate logs unless the user explicitly wants two entries.
- If the user says "save this" without a destination and confidence is low, ask one short routing question instead of forcing a journey.

## Tool Notes

- `journey.list`
  - find possible journey destinations
- `journey.get`
  - inspect one exact journey after listing
- `journey.create`
  - create a new journey when reuse is not appropriate
- `journey.update`
  - fix a title or description if the existing journey needs cleanup
- `journey.log.create`
  - add the actual saved timeline item
- `journey.log.list`
  - review the journey timeline later

## Supporting Files

If you need a compact tool summary or example patterns, read:

- `references/journey-tools.md`
