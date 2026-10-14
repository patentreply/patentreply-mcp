---
name: oa-response-drafting
description: End-to-end workflow for drafting a response to a USPTO office action using the patent-kb Live Wrapper tools. Use this skill whenever the user wants to respond to an office action, traverse a rejection (§101, §102, §103, §112), prepare claim amendments, or asks anything like "respond to the OA in 18/142,708", "draft traversals", "handle the 103 rejection", or names an application number together with a rejection or examiner action. Also use when the user pastes or uploads an office action and asks what to do about it.
---

# Office Action Response Drafting

This file is a Claude-plugin wrapper. **Load the `oa-response` skill** and
follow it. Prosecution methodology is not duplicated here.

- `oa_response_status(application_number=...)` is the live workflow-position
  authority. `prosecution_playbook` is phase methodology — passing `phase`
  only previews guidance.
- Four plan states stay distinct: editable (`set_entry`) → confirmed
  (`oa_response_plan action=confirm`) → submitted (`oa_response_plan_confirm`)
  → approved (PatentReply approval page). Chat "looks good" never approves.
- After confirm or approval, an attorney revisit forks a child draft
  (`set_entry` / `update_plan` / `withdraw_proposal`). Retire stale
  proposals with `supersedes` or `withdraw_proposal`, reconfirm, and obtain
  a new approval. Re-read `oa_response_status` after the write.
- Filing artifacts come from the server (`oa_response_document`). Never
  host-roll Word — not with the `docx` skill, not by any other route.
  Caption and 1.121 conventions live in the `response-format` skill.

On `STALE_WORKFLOW_STATE` or `PRECONDITION_FAILED`, run the returned
`recovery.sequence` verbatim.
