---
name: football-data-api
description: "Use the football-data.org v4 API through denkr's api.call wrapper when the user wants football fixtures, match results, standings, scorers, team schedules, or competition information."
---

<skill>
  <name>football-data-api</name>
  <display_name>Football-Data API</display_name>
  <description>football-data.org v4 guidance for denkr's universal api.call tool using a securely saved `FOOTBALL_DATA_API_KEY` in the `X-Auth-Token` header.</description>
  <when_to_use>Use when the user wants football information such as league tables, fixtures, results, match details, team schedules, or scorers and the task should go through the football-data.org API rather than web search.</when_to_use>
</skill>

# Goal

Help the assistant call the football-data.org v4 API through `api.call` with the right endpoint, query parameters, and saved API-key reference.

# Guardrails

- Never ask the user to paste the football-data token into chat.
- Never put the raw API key value in tool args. Use the saved key name `FOOTBALL_DATA_API_KEY`.
- The saved `FOOTBALL_DATA_API_KEY` must be bound to the exact allowed host `api.football-data.org`.
- Prefer read-only `GET` requests. Do not invent write flows.
- football-data authentication uses the custom header `X-Auth-Token`, not bearer auth.
- If the API returns `401`, `403`, or another auth/access error, assume the key may be missing, invalid, or tied to a plan that does not include the requested data and read `references/set-api-key.md`.
- Remember that competition access can depend on the user's subscription tier. The free tier is limited.

# Instructions

1. Translate the user's football request into the correct football-data v4 endpoint first.
2. Use the base URL `https://api.football-data.org/v4`.
3. For authenticated requests, call `api.call` with:
   - `auth.apiKeyName = "FOOTBALL_DATA_API_KEY"`
   - `auth.placement = "header"`
   - `auth.headerName = "X-Auth-Token"`
4. Add `Accept: application/json` for normal reads.
5. Prefer competition codes when known, for example `PL`, `CL`, `PD`, `BL1`, `SA`, `FL1`, `DED`, or `WC`.
6. Use filters to keep responses small and relevant. Common filters from the quickstart and v4 docs include:
   - `season`
   - `matchday`
   - `status`
   - `dateFrom`
   - `dateTo`
   - `limit`
   - `offset`
7. Use `/competitions/{code}/matches` for league fixture lists, `/competitions/{code}/standings` for tables, `/competitions/{code}/scorers` for top scorers, and `/teams/{id}/matches` for club schedules.
8. If the user needs help creating or saving the token, or the request fails with auth/access issues, read `references/set-api-key.md` and guide them there.

# Common endpoint patterns

| Use case | Endpoint shape |
| --- | --- |
| Accessible competitions | `/competitions` |
| Competition details | `/competitions/{code}` |
| Competition matches | `/competitions/{code}/matches` |
| Competition standings | `/competitions/{code}/standings` |
| Competition scorers | `/competitions/{code}/scorers` |
| Competition teams | `/competitions/{code}/teams` |
| Team details | `/teams/{id}` |
| Team matches | `/teams/{id}/matches` |
| Match details | `/matches/{id}` |
| Today's subscribed matches | `/matches` |
| Areas | `/areas` or `/areas/{id}` |

# Example tool calls

Premier League standings:

```json
{
  "url": "https://api.football-data.org/v4/competitions/PL/standings",
  "headers": {
    "Accept": "application/json"
  },
  "auth": {
    "apiKeyName": "FOOTBALL_DATA_API_KEY",
    "placement": "header",
    "headerName": "X-Auth-Token"
  }
}
```

Champions League matches for one matchday:

```json
{
  "url": "https://api.football-data.org/v4/competitions/CL/matches",
  "query": {
    "matchday": 3
  },
  "headers": {
    "Accept": "application/json"
  },
  "auth": {
    "apiKeyName": "FOOTBALL_DATA_API_KEY",
    "placement": "header",
    "headerName": "X-Auth-Token"
  }
}
```

Upcoming matches for one team:

```json
{
  "url": "https://api.football-data.org/v4/teams/86/matches",
  "query": {
    "status": "SCHEDULED",
    "limit": 5
  },
  "headers": {
    "Accept": "application/json"
  },
  "auth": {
    "apiKeyName": "FOOTBALL_DATA_API_KEY",
    "placement": "header",
    "headerName": "X-Auth-Token"
  }
}
```

Top scorers for Serie A:

```json
{
  "url": "https://api.football-data.org/v4/competitions/SA/scorers",
  "headers": {
    "Accept": "application/json"
  },
  "auth": {
    "apiKeyName": "FOOTBALL_DATA_API_KEY",
    "placement": "header",
    "headerName": "X-Auth-Token"
  }
}
```

Accessible competitions for the current token:

```json
{
  "url": "https://api.football-data.org/v4/competitions",
  "headers": {
    "Accept": "application/json"
  },
  "auth": {
    "apiKeyName": "FOOTBALL_DATA_API_KEY",
    "placement": "header",
    "headerName": "X-Auth-Token"
  }
}
```

# Error Handling

- If football-data responds with `401`, say the token may be missing or invalid, then read `references/set-api-key.md`.
- If football-data responds with `403`, say the key may be valid but the user's plan may not include that competition or data depth, then read `references/set-api-key.md`.
- If football-data responds with `404`, say the competition code, team id, match id, or endpoint path may be wrong.
- If football-data responds with `429`, tell the user they may have hit the rate limit. The current free tier advertises 10 API calls per minute.
- If `/competitions` or another list endpoint returns fewer items than expected, explain that football-data filters available competitions by the authenticated client subscription.
- Never pretend the API succeeded when `api.call` failed.
