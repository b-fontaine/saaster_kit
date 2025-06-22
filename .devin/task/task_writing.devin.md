## Overview
Generate a new functional task file following project standards.

## What’s Needed From User
- clear title
- Feature description

## Procedure
1. Create `.status/tasks/[ticket_title].md`.
2. Populate header:
    - `# Task : [title]`
    - `Status: To Do`
    - `Priority: Medium`
    - `Dependencies: None`
3. Add ## Requirements section with bullet points testables.
4. Add ## Steps section following TDD (domain → data → UI) as per domain_layer.mdc, data_layer.mdc, ui_layer.mdc.
5. Add ## Acceptance criteria measurable.
6. Add ## Technical notes (module path, patterns).
7. Save and commit file; reference in PR description.

## Specifications
- Task file exists under `.status/tasks`.
- Structure matches template in task_writing.mdc.

## Advice and Pointers
- Use imperative mood in titles.
- Keep each section concise and test-oriented.

## Forbidden Actions
- Do not merge without `Status:` set to `To Do`.

## Other Tips + Tactics
- Validate file with CI script before commit.
