# Set Up `FOOTBALL_DATA_API_KEY`

Use this reference when a football-data API request fails because authorization is missing, invalid, or the user has not saved their token in denkr yet.

## What to tell the user

- This API needs a football-data token.
- Do not paste the token into chat.
- Save it inside denkr instead.

## User steps

1. Open the football-data registration page: `https://www.football-data.org/client/register`.
2. Create a free account for normal personal use. For free account we will get 100 requests per day and this is good for only personal use.
3. After registration, football-data provides the API token for that account. If the user loses it later, football-data also provides a token resend flow at `https://www.football-data.org/client/forgotToken`.
4. In denkr, open `Settings -> API Keys`.
5. Tap the add flow and set all three fields:
   - Name: `FOOTBALL_DATA_API_KEY`
   - Value: the football-data token
   - Allowed hosts: `api.football-data.org`
6. Save it.
7. Tell the assistant that the key has been saved so the request can be tried again.

## Allowed host

Use this exact allowed host for the saved key:

- `api.football-data.org`

## Free-tier guidance

At the time of writing, the football-data registration page advertises this free tier:

- 12 competitions
- basic data such as fixtures, results, and league tables
- 10 API calls per minute

If the user asks for a competition or data shape that is not available on their plan, explain that the token may be valid but their football-data tier may not include that data.
