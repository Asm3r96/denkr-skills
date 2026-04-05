# Set Up `GITHUB_API_KEY`

Use this reference when the GitHub API request fails because authorization is missing, invalid, or incomplete.

## What to tell the user

- This API can require a GitHub token for the requested operation.
- Do not paste the GitHub token into chat.
- Save it inside denkr instead.

## User steps

1. Get a GitHub token from GitHub's developer settings.
2. Choose token permissions that match the intended GitHub use case.
3. In denkr, open `Settings -> API Keys`.
4. Tap the add flow and set:
   - Name: `GITHUB_API_KEY`
   - Value: the copied GitHub token
   - Allowed hosts: `api.github.com`
5. Save it.
6. Tell the assistant that the key has been saved so the request can be tried again.

## Important note about allowed hosts

- Use the hostname only, not a full URL.
- Correct: `api.github.com`
- Do not enter: `https://api.github.com/user`
- Do not enter: `github.com`

If GitHub API calls are still blocked after saving, check that the allowed host is exactly `api.github.com`.

## Permission guidance

For read-focused GitHub API use:

- repository metadata reads
- issues reads
- pull request reads
- file reads
- user profile reads

the user should create a token with the minimum read scopes needed for those actions.

If the task later expands into mutations such as creating issues or updating pull requests, the assistant should tell the user that broader GitHub token permissions may be required.
