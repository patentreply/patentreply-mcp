# Strategy

The model develops strategy. `oa_response_plan` **persists** it. The tool is
not the attorney reasoning engine.

`oa_response_plan action=open` creates the plan (one unplanned entry per live
issue) or reconciles the existing draft, and mints the plan handle. It is a
write. To re-read the plan, its proposals, or its revision history without
writing, call `oa_response_plan_get` (`get`, `list_revisions`, `get_revision`).

For each live issue, record a disposition (`traverse`, `amend`,
`traverse_and_amend`, `address_objection`, `moot_by_amendment`,
`concede_cancel`, `concede_rewrite`, `request_interview`,
`preserve_for_appeal`, `other`). Silence is not a strategy.

For each proposed amendment record purpose, spec support (`pkb://`), base
claim version, scope cost, and estoppel implications. Ask whether a
less-narrow amendment exists.

When every live issue has a selected disposition, freeze the revision with
`oa_response_plan action=confirm`. That makes the revision **immutable**.
It does **not** approve the plan.

Confirm is not the end of strategy work. If the attorney later revisits a
disposition or amendment, the server forks a child draft — see
[revision.md](revision.md). After that write, `oa_response_status` is the
live position.

See [approval.md](approval.md).
