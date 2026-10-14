# Approval

Do not conflate these states:

```
PLAN EDITABLE
      ↓  oa_response_plan action=confirm
PLAN CONFIRMED / IMMUTABLE REVISION
      ↓  oa_response_plan_confirm
SUBMITTED FOR APPROVAL (pending request + URL)
      ↓  attorney acts on the PatentReply approval page
ATTORNEY APPROVED (approval node)
      ↑
      └── attorney revisits strategy (set_entry / update_plan /
          withdraw_proposal): server forks a child DRAFT. Prior
          confirm, pending request, and approval are not operative
          for the new revision. Reconfirm, then new approval.
```

A conversational "looks good" must not bypass the approval page.

`oa_response_plan_confirm` creates or re-serves the pending request. It never
mints the approval. After the attorney acts, retry confirm: approved returns
`approval_id`; declined means revise and confirm a new revision.

Server state decides whether downstream drafting is permitted. If gates are
on, `oa_amendment_listing` / `oa_response_document` return
`PRECONDITION_FAILED` without a valid approval node — follow the recovery
sequence.

See [revision.md](revision.md) for the revisit loop. After any write, call
`oa_response_status`.
