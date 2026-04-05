# GitHub Read Reference

Base URL:

- `https://api.github.com`

Recommended shared headers:

- `Accept: application/vnd.github+json`
- `X-GitHub-Api-Version: 2022-11-28`

Common read endpoints:

- Repository:
  - `GET /repos/{owner}/{repo}`
- Issues:
  - `GET /repos/{owner}/{repo}/issues`
  - `GET /repos/{owner}/{repo}/issues/{issue_number}`
- Pull requests:
  - `GET /repos/{owner}/{repo}/pulls`
  - `GET /repos/{owner}/{repo}/pulls/{pull_number}`
- Branches:
  - `GET /repos/{owner}/{repo}/branches`
- Commits:
  - `GET /repos/{owner}/{repo}/commits`
- File contents:
  - `GET /repos/{owner}/{repo}/contents/{path}`

When you need a file body, remember that the contents endpoint can return metadata or encoded content depending on headers and file type. Keep the request explicit and inspect the returned shape before summarizing it.
