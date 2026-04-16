---
name: idea-incubator
description: "Shape rough ideas into clearer notebook pages with questions, risks, next steps, and optional follow-up reminders."
---

<skill>
  <name>idea-incubator</name>
  <display_name>Idea Incubator</display_name>
  <description>Core idea workflow for turning rough thoughts into structured notebook pages with sections for concept, questions, risks, and next steps.</description>
  <when_to_use>Use when the task is about shaping, clarifying, or revisiting an idea.</when_to_use>
</skill>

# Goal

Help the user take a rough idea and turn it into a clearer, structured notebook page that is easy to revisit, refine, and continue later.

# Guardrails

- Use notebooks for visible idea development. Do not confuse idea storage with assistant memory or reminders.
- Reuse an existing ideas notebook when it fits; create a new notebook only when the idea clearly needs its own dedicated container.
- Do not pretend an idea is validated or final when the user is still exploring it.
- Never guess missing details if notebook lookup or save tools fail.
- Never claim an idea page was created or updated unless the matching tool succeeded.

# Instructions

1. Clarify the rough idea only as much as needed to structure it. If the user is messy or vague, keep the workflow moving instead of over-interviewing.
2. Start with notebook discovery. Prefer an existing ideas notebook with `writingRules` like one page per idea.
3. Search for an existing page that already covers the same idea before creating a new one.
4. Create or update the idea page with markdown sections such as concept, why it matters, questions, assumptions, risks, next steps, and experiments.
5. Use bullet lists and numbered lists to break the idea into smaller pieces. Use checkbox task lists only when the user is ready for concrete action items.
6. If the user wants to revisit the idea later, create or update a reminder only after the notebook page is in place.
7. In the final reply, say whether you created a new idea page or refined an existing one.

# Error Handling

- If notebook or page discovery fails, say you could not access the idea notebook right now and ask whether the user wants you to try again. Do not guess existing idea contents.
- If notebook or page creation/update fails, say the idea page did not save yet and keep the response grounded to the tool result. Do not pretend the page changed.
- If reminder creation/update fails, say the follow-up reminder did not save and keep it separate from the idea-structuring result.
- If the user only wants a simple quick capture with no real structuring, route it toward a lighter notebook save instead of forcing a full incubation workflow.

# Examples

User: "I have an idea for a shared family photo book app."
Action: Reuse or create an ideas notebook, then create a page with sections for concept, why it matters, questions, risks, and next steps.
Result: "I turned the app idea into a structured page so you can keep developing it."

User: "Add next-step checkboxes and remind me next Friday to revisit it."
Action: Update the idea page with checkbox tasks, then create or update a reminder for the revisit date.
Result: "I added the next-step checklist and set the follow-up reminder."
