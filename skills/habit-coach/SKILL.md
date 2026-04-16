---
name: habit-coach
description: "Turn a goal into a repeatable routine using notebook pages for the plan and reminders for follow-through."
---

<skill>
  <name>habit-coach</name>
  <display_name>Habit Coach</display_name>
  <description>Core habit workflow for habit setup, check-ins, progress notes, and reminder-supported routines.</description>
  <when_to_use>Use when the task is about building, tracking, or adjusting a personal habit or routine.</when_to_use>
</skill>

# Goal

Help the user turn a goal into a repeatable habit using notebooks for the visible plan and progress pages, plus reminders for the cadence when the user wants future nudges.

# Guardrails

- Use notebooks for the visible habit plan, rules, progress notes, and check-ins. Use reminders only for future nudges.
- Ask one short clarification if the target habit or cadence is still unclear.
- Do not guess a reminder cadence, check-in rhythm, or notebook structure when the user has not implied one clearly enough.
- Never claim a notebook page or reminder changed unless the matching tool succeeded.
- Keep habit pages readable with markdown headings, bullet lists, and checkbox task lists when they help ongoing tracking.

# Instructions

1. Clarify the habit target, the desired cadence, and whether the user wants reminders. If any of those are missing and matter to the setup, ask one short question.
2. Start with notebook discovery. Reuse an existing habits notebook when it already fits, or create a dedicated notebook with `writingRules` such as one overview page plus one check-in page per month.
3. Create or update the main habit page with markdown sections such as goal, why, cadence, rules, obstacles, wins, and next review.
4. Use markdown task lists like `- [ ]` or `- [x]` for repeatable actions, weekly checkpoints, or streak support when they improve clarity.
5. When the user logs progress later, search the notebook first, then update the matching page or create the next check-in page according to the notebook's `writingRules`.
6. If the user wants nudges, create or update reminders with the correct `alertType`. Use `quiet` by default unless the user clearly wants an alarm-style habit reminder.
7. In the final reply, say what notebook or page you used, and mention any reminder change only after the tool has confirmed it.

# Error Handling

- If notebook lookup or page lookup fails, say you could not access the habit notebook right now and ask whether the user wants you to try again. Do not guess notebook contents.
- If notebook or page creation/update fails, say the habit plan did not save yet and keep the response grounded to the tool result. Do not pretend the page changed.
- If reminder creation or update fails, say the reminder did not save and keep the habit plan separate from the failed reminder action.
- If the request is actually reflective journaling without a clear habit or routine, route it back toward notebooks rather than forcing habit coaching.

# Examples

User: "Help me build a reading habit every evening."
Action: Reuse or create a habits notebook, create a structured markdown page for the reading habit, and ask whether the user wants a reminder cadence.
Result: "I set up a reading habit page with the plan and check-in structure."

User: "Add a nightly quiet reminder for my stretching habit."
Action: Find the existing habit notebook or page if needed, then call `reminder.write` with `action: create` or `action: update` and `alertType` set to `quiet`.
Result: "I added a quiet nightly reminder for your stretching habit."
