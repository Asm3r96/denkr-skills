---
name: trip-planner
description: "Organize travel plans in notebook pages and add reminders for deadlines like booking, packing, and departure."
---

<skill>
  <name>trip-planner</name>
  <display_name>Trip Planner</display_name>
  <description>Core trip workflow for travel notebooks, trip pages, planning details, packing lists, and reminder-supported deadlines.</description>
  <when_to_use>Use when the task is about planning a trip, capturing travel details, or preparing for travel.</when_to_use>
</skill>

# Goal

Help the user organize travel planning in a clear notebook structure with markdown pages for trip details, and reminders for deadlines like booking, packing, and departure when needed.

# Guardrails

- Use notebooks for travel information, plans, bookings, notes, and lists. Use reminders only for future deadlines or alerts.
- Reuse an existing trips notebook when it already fits. Create a new notebook only when the user clearly wants a dedicated container.
- Always read `writingRules` before creating the first page in a travel notebook.
- Never guess travel dates, bookings, or deadlines when the user has not provided them.
- Never claim a trip page or reminder changed unless the matching tool succeeded.

# Instructions

1. Clarify the trip name, destination, dates, and whether the user wants reminders if the request does not make those clear enough.
2. Start with notebook discovery. Prefer an existing trips notebook, or create one with `writingRules` such as one page per trip.
3. Search for an existing page for the trip by name or destination before creating a new one.
4. Build or update the trip page with readable markdown sections such as overview, dates, bookings, places, packing, budget, and notes.
5. Use markdown bullet lists and checkbox task lists for packing, booking steps, or open tasks.
6. Create or update reminders only for clear future deadlines such as booking check-ins, packing dates, departure, or return.
7. When the user revisits the trip later, reuse the same page and keep the structure stable instead of scattering trip details across multiple pages.

# Error Handling

- If notebook or page discovery fails, say you could not access the trip notebook right now and ask whether the user wants you to try again. Do not guess saved travel details.
- If notebook or page creation/update fails, say the trip plan did not save yet and keep the reply grounded to the tool result. Do not pretend the page changed.
- If reminder work fails, say the reminder did not save and keep the trip planning result separate from the failed reminder action.
- If the request is only a reminder with no planning component, route it toward the reminders skill instead of forcing trip planning.

# Examples

User: "Plan my Vienna weekend in June."
Action: Reuse or create a trips notebook, then create a trip page with sections for overview, dates, places, and packing notes.
Result: "I set up a Vienna trip page and organized the main planning sections."

User: "Add a packing checklist and remind me the night before."
Action: Update the existing trip page with markdown task items, then create or update a reminder for the packing deadline.
Result: "I added the packing checklist and set the reminder for the night before."
