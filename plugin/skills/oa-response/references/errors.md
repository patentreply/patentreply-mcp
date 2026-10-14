# Errors / recovery

Never blindly retry. Use the server-provided invalidation frontier.

## Matter missing

`matter_compile` → `matter_open`

`matter_compile` is start-or-status. `in_progress` (reason_code
`compile_running`) is a **successful** MCP call — PatentReply is still
working, not a failure and not an outage.

When `matter_compile` returns `in_progress`:

- Do **not** ask the user whether to retry.
- Do **not** describe the server as unavailable or non-responsive.
- Explain the current **named phase** (not “step 5 of 7” — those counts
  are not a contractual progress bar).
- After at most **one** follow-up check this turn, **return control**.
  Do not auto-poll in a loop.

Say something like:

> PatentReply is still compiling the matter. It’s currently processing
> cited references and the same server-side job is continuing. You don’t
> need to restart anything; ask me to check again in a bit and I’ll pick
> up the same compile.

A connector/transport timeout is **not** proof the server is down. Call
`matter_compile` again for the same application **when the user asks to
check**; it attaches to the existing operation. Do not invent
background-completion notifications.

`failed` is recorded terminal failure only. Never say “still working”
when the worker has recorded `failed`.

## Wrapper changed

`matter_refresh` → `oa_response_status` → regenerate only
invalidated descendants.

## Claim basis changed

`claims_get` → update affected strategy → reconfirm (`oa_response_plan
action=confirm`) → resubmit approval.

## Disputed claim text

Not a stop. Drafting proceeds and names the claim under REVIEW BEFORE
FILING. When the exact words matter: `claims_get(view="adjudication_packet")`
→ inspect → `claims_resolve_text` under server rules.

## Missing NPL

Obtain source → `reference_add` → rerun affected review. Do not traverse a
ground whose relied-upon body is missing.

## Approval invalidated

Return to approve. Never infer that an earlier approval remains valid.

## Attorney revisits strategy

Do not mutate a confirmed revision in place — the server forks a child
draft. Retire stale proposals with `supersedes` or `withdraw_proposal`.
Reconfirm and obtain a **new** attorney approval. See [revision.md](revision.md).

See bundled `stale-state-recovery.md`.
