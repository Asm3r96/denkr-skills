# GitHub REST Reference

- Base URL: `https://api.github.com`
- Normal REST header: `Accept: application/vnd.github+json`
- Recommended version header: `X-GitHub-Api-Version: 2022-11-28`
- Auth path for this skill: bearer token from saved key `GITHUB_API_KEY`
- Common query params:
  - `per_page`
  - `page`
  - `state`
  - `sort`
  - `direction`

Prefer repo-scoped endpoints and explicit owner/repo pairs when possible.
