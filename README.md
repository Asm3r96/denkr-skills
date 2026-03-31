# denkr-skills

Curated public skill registry for Denkr.

This repo is the single approved remote source for Denkr skills. The app should only use the published manifest and package URLs from this repo. Agents do not browse the repo directly.

## Goals

- keep one allowlisted public source for skills
- publish a simple manifest for discovery
- package each skill as a downloadable archive
- keep source skill files in the repo so new skills are easy to add and review

## Structure

- `index.json`
  - the published skills manifest used for discovery
- `skills/`
  - source folders for each skill
- `packages/`
  - published zip archives that the app can download
- `scripts/build-release.ps1`
  - rebuilds package archives and regenerates `index.json`

## Skill Contract

Each skill folder must contain:

- `SKILL.md`
- `skill.json`

Optional subfolders:

- `references/`
- `templates/`
- `scripts/`
- `assets/`

Denkr should load only the root `SKILL.md` when activating a skill. Supporting files are for later on-demand reads only.

## Publishing Flow

1. Add or update a skill under `skills/<name>/`.
2. Update the skill version in `skill.json`.
3. Run:

```powershell
./scripts/build-release.ps1
```

4. Commit the updated source skill, package archive, and `index.json`.
5. Push to `main`.

## Current Skills

- `journey-logbook`
  - guides the assistant to create or reuse a journey and save ongoing logs inside it using Denkr's built-in journey tools
