# GitHub Common Requests

Use these GitHub REST API shapes with `api.call`.

Common headers:

```json
{
  "Accept": "application/vnd.github+json",
  "X-GitHub-Api-Version": "2022-11-28"
}
```

## Repository metadata

`GET /repos/{owner}/{repo}`

Example:

```json
{
  "url": "https://api.github.com/repos/{owner}/{repo}",
  "headers": {
    "Accept": "application/vnd.github+json",
    "X-GitHub-Api-Version": "2022-11-28"
  }
}
```

## Repository contents

`GET /repos/{owner}/{repo}/contents/{path}`

Notes:

- GitHub may return file content base64-encoded in the `content` field.
- Directory reads return an array of entries.

## Issues

`GET /repos/{owner}/{repo}/issues`

Useful query fields:

- `state`
- `per_page`
- `page`
- `labels`
- `assignee`

## Pull requests

`GET /repos/{owner}/{repo}/pulls`

Useful query fields:

- `state`
- `head`
- `base`
- `sort`
- `direction`

## Commits

`GET /repos/{owner}/{repo}/commits`

Useful query fields:

- `sha`
- `path`
- `author`
- `per_page`

## Branches

`GET /repos/{owner}/{repo}/branches`

## Releases

`GET /repos/{owner}/{repo}/releases`

## Current authenticated user

`GET /user`

Use `GITHUB_API_KEY` with bearer placement for this request.
