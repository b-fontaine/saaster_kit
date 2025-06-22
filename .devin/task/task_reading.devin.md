## Overview
Update `TASKS.md` tracker and prepare session resumption.

## What’s Needed From User
- Ticket ID to update
- New status (In Progress, Done)

## Procedure
1. Open `.status/status.md`; locate or add ticket entry.
2. Update Status column accordingly.
3. Add timestamp or session ID if AI-driven.
4. Commit changes with message `chore(ai): update status for [ticket]`.
5. If resuming AI, note session ID and run `devin resume <sessionId>`.

## Specifications
- `TASKS.md` reflects current state of all tickets.
- Commit message follows convention.

## Advice and Pointers
- Always record session ID for AI-runs.
- Maintain chronological order in tracker.

## Forbidden Actions
- Never delete past entries.

## Other Tips + Tactics
- Use Git blame to audit changes if context is lost.
