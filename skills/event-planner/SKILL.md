---
name: event-planner
description: "Plan and organize events with notebook pages and reminders. Use when the user wants to prepare a birthday, dinner, visit, gathering, or other event."
---

<skill>
  <name>event-planner</name>
  <display_name>Event Planner</display_name>
  <description>Notebook-backed event planning workflow for overview pages, guest lists, tasks, budgets, notes, and event reminders.</description>
  <when_to_use>Use when the task is about planning, organizing, or updating an event such as a birthday, dinner, visit, gathering, or celebration.</when_to_use>
</skill>

# Goal

Help the user keep an event organized in a visible notebook structure with readable markdown pages and reminders for important preparation dates.

# Guardrails

- Use notebooks for the visible event plan, tasks, guest details, notes, and budget items. Use reminders only for future deadlines or event timing.
- Reuse an existing events notebook when it already fits; create a new notebook only when the user clearly wants a dedicated event container.
- Always read `writingRules` before creating the first event page in a notebook.
- Never guess dates, guest lists, budgets, or event details when the user has not provided them.
- Never claim an event page or reminder changed unless the matching tool succeeded.

# Instructions

1. Clarify the event name, date or timeframe, and the main planning need if the request is still too vague to organize.
2. Start with notebook discovery. Prefer an existing events notebook with `writingRules` like one page per event, or create a new one if needed.
3. Search for an existing event page before creating a new page.
4. Create or update the event page with readable markdown sections such as overview, date and place, guests, tasks, budget, supplies, notes, and follow-ups.
5. Use bullet lists for guests or ideas, numbered lists for ordered prep steps, and checkbox task lists like `- [ ] Confirm table booking` for event prep.
6. If the user wants reminders, create or update them only for clear future deadlines such as invitations, shopping, booking confirmations, or the event day itself.
7. Reuse the same event page as details evolve instead of scattering the event across multiple pages unless the notebook's `writingRules` say otherwise.
8. In the final reply, say what notebook or page you updated and confirm reminders only after the tool has succeeded.

# Error Handling

- If notebook or page lookup fails, say you could not access the event notebook right now and ask whether the user wants you to try again. Do not guess saved event details.
- If notebook or page creation/update fails, say the event plan did not save yet and keep the reply grounded to the tool result. Do not pretend the page changed.
- If reminder work fails, say the reminder did not save and keep it separate from the notebook result.
- If the request is only a simple reminder with no event-planning content, route it back toward the reminders workflow instead of forcing a full event plan.

# Examples

User: "Plan Sara's birthday dinner next month."
Action: Reuse or create an events notebook, then create a page with sections for overview, guests, tasks, budget, and notes.
Result: "I set up the birthday dinner page and organized the main planning sections."

User: "Add a shopping checklist and remind me two days before."
Action: Update the existing event page with markdown checkbox tasks, then create or update the reminder for two days before the event.
Result: "I added the shopping checklist and set the reminder for two days before."
