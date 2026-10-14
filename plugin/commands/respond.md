---
description: Draft the office action response for a matter
argument-hint: [application number, or omit to use the matter open in this conversation]
---

Application: $ARGUMENTS (if empty, use the matter already open in this conversation; if none, ask).

Use the oa-response skill (the oa-response-drafting skill is a wrapper for it). Call `oa_response_status` for the server-derived workflow position. Use `prosecution_playbook` for phase methodology. Confirm the matter is compiled and audited, resolve any disputed claim text with me first, review the OA, persist a response plan (`set_entry` drafts; `oa_response_plan action=confirm` freezes a revision — that is not my approval), then `oa_response_plan_confirm` so I can sign off on the PatentReply approval page. If I later change strategy, fork a new draft (`set_entry` / `update_plan` / `withdraw_proposal`), retire stale proposals with `supersedes` or `withdraw_proposal`, reconfirm, and wait for a new approval — do not draft from the old one. Draft traversals and the 1.121 listing only after approval. Assemble with `oa_response_document` — never host-roll a Word file.
