---
name: github-api
description: "Use the GitHub REST API through denkr's api.call wrapper when the user wants repository, issue, pull request, file, or account information from GitHub."
---

<skill>
  <name>github-api</name>
  <display_name>GitHub API</display_name>
  <description>GitHub REST API guidance for denkr's universal api.call tool using a securely saved `GITHUB_API_KEY` when authentication is needed.</description>
  <when_to_use>Use when the user wants to read GitHub repository data, issues, pull requests, branches, commits, file contents, or account information and the task should go through the GitHub API rather than web search.</when_to_use>
</skill>

# Goal

Help the assistant call the GitHub REST API through `api.call` with the right endpoint, headers, query parameters, and saved API-key reference.

# Guardrails

- Never ask the user to paste a GitHub token into chat.
- Never put the raw API key value in the tool args. Use the saved key name `GITHUB_API_KEY`.
- The saved `GITHUB_API_KEY` must be bound to the exact allowed host `api.github.com`.
- Prefer read-only GitHub API flows unless the user explicitly asks for a mutation and confirms it.
- If the API returns `401`, `403`, or an auth error, assume the key may be missing, invalid, or missing permissions and read `references/set-api-key.md`.
- Use GitHub's documented `Accept: application/vnd.github+json` header for normal REST calls.
- Add `X-GitHub-Api-Version: 2022-11-28` unless the endpoint clearly requires something else.

# Instructions

1. Translate the user's GitHub request into the correct REST endpoint first.
2. Decide whether the endpoint is public or should use the saved token anyway.
3. For authenticated requests, call `api.call` with:
   - `auth.apiKeyName = "GITHUB_API_KEY"`
   - `auth.placement = "bearer"`
4. Add standard GitHub headers:
   - `Accept: application/vnd.github+json`
   - `X-GitHub-Api-Version: 2022-11-28`
5. For list endpoints, use query params such as `per_page`, `page`, `state`, or `sort` when the user asks for filtering or smaller result sets.
6. For repository files, use the contents API when the user wants one file or directory path.
7. For pull requests and issues, use the repo-scoped endpoints and pass owner plus repo explicitly in the URL.
8. If the user needs help creating the token or the request fails with auth/permission errors, read `references/set-api-key.md` and guide them there.

# Common endpoint patterns

| Use case | Endpoint shape |
| --- | --- |
| Repo details | `/repos/{owner}/{repo}` |
| Repo issues | `/repos/{owner}/{repo}/issues` |
| One issue | `/repos/{owner}/{repo}/issues/{issue_number}` |
| Pull requests | `/repos/{owner}/{repo}/pulls` |
| One pull request | `/repos/{owner}/{repo}/pulls/{pull_number}` |
| Branches | `/repos/{owner}/{repo}/branches` |
| Commits | `/repos/{owner}/{repo}/commits` |
| File or directory contents | `/repos/{owner}/{repo}/contents/{path}` |
| Current user | `/user` |
| User profile | `/users/{username}` |

# Example tool calls

Repository details:

```json
{
  "url": "https://api.github.com/repos/openai/openai-openapi",
  "headers": {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
  },
  "auth": {
    "apiKeyName": "GITHUB_API_KEY",
    "placement": "bearer"
  }
}
```

Open issues for one repo:

```json
{
  "url": "https://api.github.com/repos/openai/openai-openapi/issues",
  "query": {
    "state": "open",
    "per_page": 20
  },
  "headers": {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
  },
  "auth": {
    "apiKeyName": "GITHUB_API_KEY",
    "placement": "bearer"
  }
}
```

Read one file from a repo:

```json
{
  "url": "https://api.github.com/repos/openai/openai-openapi/contents/README.md",
  "headers": {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
  },
  "auth": {
    "apiKeyName": "GITHUB_API_KEY",
    "placement": "bearer"
  }
}
```

Current authenticated user:

```json
{
  "url": "https://api.github.com/user",
  "headers": {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
  },
  "auth": {
    "apiKeyName": "GITHUB_API_KEY",
    "placement": "bearer"
  }
}
```

# Error Handling

- If GitHub responds with `401` or `403`, tell the user the request may need a valid GitHub token or broader token permissions, then read `references/set-api-key.md`.
- If GitHub responds with `404`, say the repo, issue, pull request, user, or file path may not exist or may not be visible to the current token.
- If the API returns rate-limit headers showing low remaining quota, tell the user the GitHub API rate limit may be the blocker.
- Never pretend the API succeeded when `api.call` failed.
