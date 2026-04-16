# denkr-skills

Public skills repository for Denkr.

This repo contains the optional skills that can be available for Denkr.

Current public skills:

- `decision-helper`
- `event-planner`
- `habit-coach`
- `idea-incubator`
- `notebooks`
- `reminders`
- `github-api`
- `trip-planner`

More skills will be added over time.

Before pushing new or updated skills, run:

```powershell
.\scripts\build-release.ps1
.\scripts\validate-release.ps1
```

The validator checks:

- `index.json` parses cleanly and has no UTF-8 BOM
- each skill folder contains valid `skill.json` and `SKILL.md`
- each manifest entry matches a real skill folder
- each packaged zip exists and matches the manifest `sha256` and `size_bytes`
- each zip contains `SKILL.md` and `skill.json`
