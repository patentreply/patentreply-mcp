# Stale-state recovery

On `STALE_WORKFLOW_STATE` or `PRECONDITION_FAILED`:

1. Read `error.recovery.sequence` — ready-to-use tool calls with live handles.
2. Run **only** what it names, in order.
3. Do not re-audit, re-plan, and re-approve from scratch unless the frontier
   names those tools.
4. After recovery, call `oa_response_status` to refresh the live position.

Handles identify; they never authorize. A handle from another workspace is
indistinguishable from a missing handle.
