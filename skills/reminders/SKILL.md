---
name: reminders
description: "Create, inspect, and update reminders with grounded timing, alert choice, and clear future follow-ups."
---

<skill>
  <name>reminders</name>
  <display_name>Reminders</display_name>
  <description>Core reminder workflow for grounded timing, quiet versus alarm alerts, and reminder lifecycle changes.</description>
  <when_to_use>Use when the task is about future follow-ups, deadlines, alarms, local notifications, or changing an existing reminder.</when_to_use>
</skill>

# Goal

Use reminders for future actions and notifications only. Ground timing to exact dates when needed, choose the right alert style, and keep reminder updates truthful and local to the app.

# Guardrails

- Use reminders for future follow-ups, deadlines, and alerts. Do not use reminders as visible notebook content or durable assistant memory.
- Resolve ambiguous time before saving a reminder whenever the user gives relative timing like "tomorrow" or "next week".
- Set `alertType` intentionally: use `quiet` for normal nudges and `alarm` for urgent alerts that should ring.
- Never guess schedule details, reminder ids, or tool results if reminder tools fail or return empty data.
- Never claim a reminder was created, updated, deleted, or completed unless the matching tool succeeded.

# Instructions

1. If the user gives relative or ambiguous time such as "tomorrow", "later", "next week", or "in two hours", call `time.current` first so the reminder is grounded to an exact timestamp in the user's timezone.
2. Use `reminder.write` with `action: create` to save a new reminder with a clear title, useful description, timezone, future schedule, and the right `alertType`.
3. If the reminder type is unclear, ask whether the user wants a gentle reminder or an alarm-style alert before writing it.
4. If the user wants to inspect, edit, or delete a reminder and you do not already know its exact id, start with `reminder.read` and `action: list`.
5. Use `reminder.read` and `action: get` when you need the full schedule details and upcoming runs for one reminder.
6. Use `reminder.write` and `action: update` to change timing, wording, category, timezone, status, or `alertType`.
7. Use `reminder.write` with `action: delete` only when the user clearly wants the reminder removed.
8. In the final reply, confirm the exact reminder change only after the tool has succeeded.

# Error Handling

- If `time.current` fails while the request depends on relative time, tell the user you could not resolve the exact time yet and ask them for a precise date or time. Do not guess.
- If `reminder.read` fails, say you could not access reminders right now and ask whether they want you to try again. Do not invent reminder details.
- If `reminder.write` fails, say the reminder change did not complete and keep the response grounded to the tool result. Do not pretend the reminder changed.
- If the request is actually about saving visible notes or plans, redirect to the notebooks skill instead of creating a reminder.

# Examples

User: "Remind me tomorrow at 9 to buy milk."
Action: Call `time.current` if needed to resolve tomorrow, then call `reminder.write` with `action: create`, a future schedule, and `alertType` set to `quiet`.
Result: "I created a quiet reminder for tomorrow at 9:00 to buy milk."

User: "Set an alarm reminder for my flight check-in tonight."
Action: Resolve the exact time if needed, then call `reminder.write` with `action: create` and `alertType` set to `alarm`.
Result: "I created an alarm reminder for your flight check-in tonight."

User: "Change my dentist reminder to a quiet one instead."
Action: Call `reminder.read` with `action: list` or `action: get` if needed, then call `reminder.write` with `action: update` and `alertType` set to `quiet`.
Result: "I changed the dentist reminder to a quiet alert."
