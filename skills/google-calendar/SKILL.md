---
name: google-calendar
description: "Use Google Calendar through denkr's Google OAuth skill auth to list upcoming events from the user's primary calendar."
---

<skill>
  <name>google-calendar</name>
  <display_name>Google Calendar</display_name>
  <description>Read upcoming Google Calendar events through denkr-managed Google OAuth without exposing token values to the agent.</description>
  <when_to_use>Use when the user asks about their Google Calendar, upcoming meetings, agenda, schedule, or next events.</when_to_use>
</skill>

# Google Calendar

Use this skill to read the user's upcoming Google Calendar events.

Important: denkr OAuth skills are limited for now. This skill uses the active tested Google Calendar read-only path, and support for more apps and OAuth providers is planned later.

## OAuth Setup

- Provider: `google`
- Token reference: `google.primary`
- Required scope: `https://www.googleapis.com/auth/calendar.readonly`
- Allowed domains: `www.googleapis.com`
- Google logo: use the app's Google service-auth provider metadata.

The user must connect Google in denkr before this skill can call Calendar. If the call says the OAuth token is missing, tell the user to connect Google for this skill first. Never ask the user to paste raw access tokens, refresh tokens, or OAuth codes in chat.

## Workflow

1. For normal agenda questions, read from the primary calendar only.
2. Use `time.current` first when the user's request depends on today, tomorrow, this week, or another relative date.
3. Use `api.call` with the Google OAuth token reference.
4. Default to upcoming events from now, ordered by start time.
5. Keep the answer concise: event title, date/time, and location or meeting link when available.
6. If the user asks for more detail, include description snippets only when Calendar returns them.

## Tool Call

Use this pattern:

```json
{
  "url": "https://www.googleapis.com/calendar/v3/calendars/primary/events",
  "method": "GET",
  "query": {
    "timeMin": "ISO_NOW",
    "maxResults": 10,
    "singleEvents": true,
    "orderBy": "startTime"
  },
  "auth": {
    "type": "oauth",
    "provider": "google",
    "tokenRef": "google.primary",
    "allowedDomains": ["www.googleapis.com"],
    "scopes": ["https://www.googleapis.com/auth/calendar.readonly"]
  }
}
```

Replace `ISO_NOW` with the current ISO timestamp.

## Boundaries

- Read-only for now.
- Do not create, update, or delete calendar events.
- Do not request Gmail, Drive, Contacts, or broad Google scopes.
- Do not use any endpoint outside `www.googleapis.com`.

## Sources

- Google Calendar Events list: `https://developers.google.com/workspace/calendar/api/v3/reference/events/list`
