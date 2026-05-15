# Notebook Tools Reference

- Notebook work is page-first: choose the right notebook, then decide whether to reuse a page or create a new one.
- `notebook.read`: use `action` to list notebooks, get one notebook, list pages, or get one page.
- `notebook.write`: use `action` to create or update notebooks, create or update pages, or delete a page.
- `notebook.write`: use `action: delete_page` to remove a page that is no longer needed.
- `writingRules` should drive page strategy:
  - one page per month
  - one page per trip
  - one page per idea
  - one page per topic with stable headings
- Prefer readable markdown over text walls.
- Good page structures include:
  - headings for dated sections
  - bullet lists for quick notes
  - numbered lists for sequences
  - checkbox todo lists like `- [ ] Book hotel`
- Native `denkr-ui` blocks are limited to `callout` and `task_list`.
- Use `denkr-ui` only when native UI improves the notebook page.
- Do not use unsupported UI blocks such as tables, metrics, buttons, cards, charts, images, HTML, CSS, or JavaScript.
