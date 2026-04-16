---
name: decision-helper
description: "Structure choices in notebook pages with options, criteria, tradeoffs, recommendations, and later review reminders."
---

<skill>
  <name>decision-helper</name>
  <display_name>Decision Helper</display_name>
  <description>Core decision workflow for capturing options, criteria, pros and cons, unknowns, and recommendations in notebook pages.</description>
  <when_to_use>Use when the task is about comparing options, evaluating tradeoffs, or recording a decision process.</when_to_use>
</skill>

# Goal

Help the user think through a decision clearly by saving the decision into a structured notebook page with readable sections, tradeoffs, and next steps.

# Guardrails

- Use notebooks for visible decision notes and reminders only for future review points.
- Keep the decision grounded to what the user has actually said. Do not invent criteria, outcomes, or certainty.
- Reuse an existing decisions notebook or relevant topic notebook when it fits.
- Never claim a decision page or reminder changed unless the matching tool succeeded.
- If the user only wants a quick opinion with no saved structure, keep the answer lighter instead of forcing a full decision workflow.

# Instructions

1. Clarify the decision question and the main options if they are still too vague to structure.
2. Start with notebook discovery. Prefer a decisions notebook with `writingRules` like one page per decision, or reuse a topic notebook if the user already keeps the subject there.
3. Search for an existing page for the same decision before creating a new one.
4. Create or update the decision page with markdown sections such as decision, options, criteria, pros, cons, unknowns, recommendation, and next step.
5. Use bullet lists for tradeoffs, numbered lists for ranked options, and checkbox task lists only when the decision has concrete follow-up actions.
6. If the user wants to revisit the decision later, create or update a reminder after the page is saved.
7. In the final reply, describe the structure you saved and mention any reminder only after the tool succeeded.

# Error Handling

- If notebook or page discovery fails, say you could not access the decision notes right now and ask whether the user wants you to try again. Do not guess saved decision content.
- If notebook or page creation/update fails, say the decision page did not save yet and keep the reply grounded to the tool result. Do not pretend the page changed.
- If reminder work fails, say the reminder did not save and keep it separate from the decision page result.
- If the request is really a future reminder with no decision work, route it toward reminders instead of forcing a decision workflow.

# Examples

User: "Help me decide between Vienna and Prague for the weekend."
Action: Reuse or create a decisions notebook, then create a page with options, criteria, pros, cons, and a recommendation section.
Result: "I set up a decision page so the Vienna versus Prague choice is easier to compare."

User: "Add a reminder for Sunday so I revisit this choice."
Action: Update or reuse the decision page if needed, then create or update the reminder for Sunday.
Result: "I added the reminder so you can revisit the choice on Sunday."
