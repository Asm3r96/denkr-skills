# Journey Tool Reference

This file is a compact support reference for the `journey-logbook` skill.

## Main Tools

- `journey.list`
  - use first when you want to reuse an existing journey
- `journey.get`
  - use after listing when you need exact metadata for one journey
- `journey.create`
  - use when there is no good existing journey
- `journey.update`
  - use if the container exists but needs a clearer title or description
- `journey.log.create`
  - use to save the actual entry inside the journey
- `journey.log.list`
  - use to inspect recent or historical logs

## Example Patterns

### Create new journey, then save a first log

1. Try `journey.list`
2. If no good match, call `journey.create`
3. Call `journey.log.create` with the new `journeyId`

### Reuse existing journey

1. Call `journey.list`
2. Optionally call `journey.get`
3. Call `journey.log.create`

### Review previous logs

1. Identify the journey
2. Call `journey.log.list` with `recent`
3. Narrow by date only when needed
