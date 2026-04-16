---
name: notebooks
description: "Create, organize, search, and update notebooks and notebook pages with readable markdown structure."
---

<skill>
  <name>notebooks</name>
  <display_name>Notebooks</display_name>
  <description>Core notebook workflow for visible saved content, markdown pages, and structured notebook organization.</description>
  <when_to_use>Use when the task is about notebooks, notebook pages, finding a saved note, or organizing visible long-lived content.</when_to_use>
</skill>

# Goal

Use notebooks as the user's visible book of pages. Keep notebook content readable, structured, and aligned with each notebook's `writingRules`, using markdown headings, bullet lists, numbered lists, and checkbox todo lists when they improve clarity.

# Guardrails

- Use notebooks for visible saved content only. Do not use them for reminders, notification timing, or durable assistant memory.
- Always read a notebook's `writingRules` before creating the first page for that notebook or when page structure is unclear.
- Never guess notebook state, page state, or saved content if notebook tools fail or return empty results.
- Never claim a notebook or notebook page was created, updated, deleted, or found unless the matching tool succeeded.
- Keep notebook pages readable for the user. Prefer structured markdown over raw text dumps.

# Instructions

1. Start with notebook discovery unless the exact notebook or page is already known. Use `notebook.read` with `action: list_notebooks` to browse containers and `action: get_notebook` to inspect one notebook in full.
2. Before creating a first page or deciding page structure, read the notebook's `writingRules`. Let those rules decide whether content belongs in an existing page or a new page.
3. If the user is looking for a past note inside one notebook, use `notebook.read` with `action: list_pages` and the `query` parameter before opening pages one by one.
4. Reuse an existing notebook when it already fits the person, project, topic, or life area. Create a new notebook only when the content deserves its own visible container, then keep the title short, the description clear, and the `writingRules` practical.
5. Treat pages as the real content surface. Reuse a page when it matches the notebook's `writingRules`; create a new page when the content belongs to a new month, trip, idea, topic, or other notebook-defined unit.
6. Write page content as clean markdown. Use headings, bullet lists, numbered lists, and task lists such as `- [ ]` or `- [x]` when they make the page easier to scan or maintain.
7. Choose page placement intentionally with `notebook.write` and `action: update_page`: append for running notes, prepend for short top summaries, insert under a matching heading for structured pages, or replace only when a full rewrite is truly needed.
8. In the final reply, describe the notebook or page change plainly and only after the tool has confirmed success.

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
