---
name: notebooks
description: "Create, organize, search, and update notebooks and notebook pages with readable markdown and supported fenced-JSON Denkr UI blocks. Use when writing notebook UI; never use HTML-style denkr-ui tags."
---

<skill>
  <name>notebooks</name>
  <display_name>Notebooks</display_name>
  <description>Core notebook workflow for visible saved content, markdown pages, and structured notebook organization.</description>
  <when_to_use>Use when the task is about notebooks, notebook pages, finding a saved note, or organizing visible long-lived content.</when_to_use>
</skill>

# Goal

Use notebooks as the user's visible book of pages. Keep notebook content readable, structured, and aligned with each notebook's `writingRules`, using markdown first. When a page benefits from native UI, use only fenced `denkr-ui` JSON blocks from this skill.

# Guardrails

- Use notebooks for visible saved content only. Do not use them for reminders, notification timing, or durable assistant memory.
- Always read a notebook's `writingRules` before creating the first page for that notebook or when page structure is unclear.
- Never guess notebook state, page state, or saved content if notebook tools fail or return empty results.
- Never claim a notebook or notebook page was created, updated, deleted, or found unless the matching tool succeeded.
- Keep notebook pages readable for the user. Prefer structured markdown over raw text dumps.
- Do not invent UI blocks. Current Denkr UI support is only `callout`, `task_list`, `data_table`, `metric_grid`, and `progress`.
- Never write HTML-style UI tags such as `<denkr-ui ... />`. Denkr UI blocks must be fenced JSON only.

# Instructions

1. Start with notebook discovery unless the exact notebook or page is already known. Use `notebook.read` with `action: list_notebooks` to browse containers and `action: get_notebook` to inspect one notebook in full.
2. Before creating a first page or deciding page structure, read the notebook's `writingRules`. Let those rules decide whether content belongs in an existing page or a new page.
3. If the user is looking for a past note inside one notebook, use `notebook.read` with `action: list_pages` and the `query` parameter before opening pages one by one.
4. Reuse an existing notebook when it already fits the person, project, topic, or life area. Create a new notebook only when the content deserves its own visible container, then keep the title short, the description clear, and the `writingRules` practical.
5. Treat pages as the real content surface. Reuse a page when it matches the notebook's `writingRules`; create a new page when the content belongs to a new month, trip, idea, topic, or other notebook-defined unit.
6. Write page content as clean markdown. Use headings, bullet lists, numbered lists, and markdown task lists such as `- [ ]` or `- [x]` when they make the page easier to scan or maintain.
7. Use `denkr-ui` blocks only as fenced JSON blocks. Keep block and item IDs stable when editing existing UI blocks.
8. Choose page placement intentionally with `notebook.write` and `action: update_page`: append for running notes, prepend for short top summaries, insert under a matching heading for structured pages, or replace only when a full rewrite is truly needed.
9. In the final reply, describe the notebook or page change plainly and only after the tool has confirmed success.

# Denkr UI Blocks

Use normal markdown by default. Use `denkr-ui` only when native UI improves the page.

Critical format rule: Denkr UI is **not HTML**. The app does not render `<denkr-ui ... />` tags. Always write one fenced JSON block:

````markdown
```denkr-ui
{"version":1,"blocks":[]}
```
````

Never write:

```html
<denkr-ui type="progress" value="85" />
<denkr-ui type="card" title="Project" />
<denkr-ui type="stat" label="Done" value="3" />
```

If you want a card/stat-like result, use `metric_grid`. If you want a note, use `callout`. If you want a bar, use `progress`.

Supported blocks:
- `callout`
- `task_list`
- `data_table`
- `metric_grid`
- `progress`

Do not use:
- buttons or actions
- cards
- stats
- charts
- images
- HTML, CSS, or JavaScript
- `<denkr-ui ... />` tags
- `actions`

Preferred format:

````markdown
```denkr-ui
{
  "version": 1,
  "blocks": [
    {
      "type": "callout",
      "id": "note_deadline",
      "title": "Optional title",
      "body": "Short callout body.",
      "variant": "info"
    },
    {
      "type": "task_list",
      "id": "launch_tasks",
      "title": "Optional title",
      "items": [
        {"id": "task_1", "text": "First task", "done": false},
        {"id": "task_2", "text": "Completed task", "done": true}
      ]
    },
    {
      "type": "data_table",
      "id": "weekly_schedule",
      "title": "Optional title",
      "columns": [
        {"id": "day", "label": "Day"},
        {"id": "plan", "label": "Plan"}
      ],
      "rows": [
        {"day": "Monday", "plan": "Draft"},
        {"day": "Tuesday", "plan": "Review"}
      ]
    },
    {
      "type": "metric_grid",
      "id": "project_metrics",
      "title": "Optional title",
      "metrics": [
        {"id": "open", "label": "Open tasks", "value": "3", "tone": "warning"},
        {"id": "done", "label": "Done", "value": "8", "caption": "this week", "tone": "success"}
      ]
    },
    {
      "type": "progress",
      "id": "project_progress",
      "title": "Optional title",
      "label": "Overall progress",
      "value": 60,
      "max": 100,
      "caption": "6 of 10 steps done",
      "tone": "success"
    }
  ]
}
```
````

Rules:
- Use only ASCII-safe IDs such as `launch_tasks`, `task_1`, or `note_deadline`.
- Preserve existing block IDs and task item IDs when editing a page. Denkr uses those IDs to preserve checked state.
- For callout `variant`, use only `info`, `success`, `warning`, or `danger`.
- For task items, use `done: true` or `done: false`.
- For data tables, define `columns` first and make each row an object keyed by column id.
- For metric grid values, prefer strings for display values like `"3"` or `"100%"`.
- For metric grid and progress `tone`, use only `neutral`, `info`, `success`, `warning`, or `danger`.
- For progress, use numeric `value`; `max` defaults to `100` when omitted.
- Use `body`, not `content`.
- Use `done`, not `completed`.
- Before saving, check the page content contains no `<denkr-ui` text and no unsupported block types such as `card`, `stat`, `chart`, `button`, `image`, or `actions`.
- Do not put more than a few UI blocks on one page. Keep prose readable.

# Error Handling

- If `notebook.read` fails, tell the user you could not access the notebook right now and ask whether they want you to try again. Do not guess or make up notebook contents.
- If `notebook.write` fails, say the save or update did not complete and keep the response grounded to the failed tool result. Do not pretend the notebook changed.
- If notebook search returns nothing, say you could not find a matching page in the notebook and ask whether the user wants a new page or a broader search.
- If the request is actually about future follow-ups or alerts, redirect to the reminders skill instead of forcing notebook storage.

# Examples

User: "Create a notebook for Karo and keep one page per month."
Action: Call `notebook.write` with `action: create_notebook`, a short title, clear description, and `writingRules` that say one page per month with dated markdown sections.
Result: "I created the Karo notebook and set it to use one page per month."

User: "Find where we talked about API cost in my Denkr notebook."
Action: Call `notebook.read` with `action: list_notebooks` if needed, then `action: list_pages` with the notebook id and `query` set to `API cost`, then open the matching page with `action: get_page` if needed.
Result: "I found the API cost note in your Denkr notebook and opened the matching page."

User: "Add a packing checklist to the Vienna trip page."
Action: Read the notebook and page if needed, then call `notebook.write` with `action: update_page` and an insert under the right heading with markdown todo items like `- [ ] Passport`.
Result: "I added a packing checklist to the Vienna trip page."

User: "Make this notebook page easier to scan with UI."
Action: Use markdown for the main page and add supported `denkr-ui` blocks only where they improve readability. Use `data_table` for column data, `metric_grid` for small status summaries, and `progress` for one progress bar. Do not invent unsupported UI elements.
Result: "I updated the page with supported Denkr UI blocks."
