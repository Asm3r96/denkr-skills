# Reminder Tools Reference

- `time.current`: resolve relative or ambiguous reminder timing before writing.
- `reminder.read`: use `action` to list reminders or get one reminder by id.
- `reminder.write`: use `action` to create a reminder or update one by id.
- `reminder.write`: use `action: delete` to remove a reminder and cancel future deliveries.
- `alertType` should be:
  - `quiet` for normal nudges
  - `alarm` for urgent reminders that should ring
