# Plan revision (not a one-way conveyor)

Prosecution is iterative. A confirmed or approved plan is not a dead end.
When the attorney revisits strategy, the server forks a **new draft
revision**. The skill does not invent that fork — `oa_response_plan` does.

```
confirmed or approved revision
        ↓  attorney revisits strategy
set_entry / update_plan / withdraw_proposal
        ↓  server forks a child DRAFT (created_child=true)
revise dispositions / amendment text
        ↓  retire stale proposals with server primitives
confirm the NEW revision (action=confirm)
        ↓
new attorney approval (oa_response_plan_confirm → approval page)
        ↓
draft from the newly approved revision
```

After every write, call `oa_response_status`. Do not infer the new phase,
plan-revision state, or approval status from conversation memory.

## What the server already does

- A confirmed revision is **immutable**. `set_entry`, `update_plan`, or
  `withdraw_proposal` against it creates a child draft (`created_child=true`).
- The prior confirmation is void. A pending approval request is void. A
  prior approval node is **not** the basis for drafting the new revision.
- Amendment proposals are durable history. They are never deleted.

## Retire stale proposals (required primitives)

Exactly one active amendment text per occupied claim version. When the
attorney's new theory replaces or drops an earlier proposal, use the
server — do not paper over a leftover active proposal in chat.

- **Replace:** `oa_response_plan` `set_entry` with `supersedes: [old_id]`
  (atomic retire of the old proposal on the same write).
- **Drop without replacement:** `oa_response_plan` `action=withdraw_proposal`
  (`amendment_proposal_id`, optional `withdraw_reason`).

If the server refuses, stop and follow the error. Do not edit markup by
hand, do not pretend the old proposal is gone, and do not draft from a
`superseded` or `withdrawn` proposal.

`oa_response_plan_get` `list_revisions` / `get_revision` are history. They never change live
position.

## Re-approval

The new draft must be confirmed (`action=confirm`) and then submitted
(`oa_response_plan_confirm`). Chat "looks good" on the new theory is
still not attorney approval. Drafting tools stay gated until
`oa_response_status` shows a valid approval for **this** revision.

## What this skill must not do

- Mutate a confirmed revision in place (the server will not).
- Skip re-approval because "we already approved the old plan."
- Treat a host confirm dialog as sign-off.
- Infer that live phase is still `draft` / `assemble` after a fork.
- Invent a supersede/withdraw path that is not an `oa_response_plan`
  action or field the server already implements.
