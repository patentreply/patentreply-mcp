# Orient

1. `matter_compile` if the matter is not compiled. Before that call, a short
   preamble, then execute immediately. Neighborhood wording: “I’ll first
   check whether PatentReply already has this application. If this is the
   first compile, it may take a few minutes while PatentReply gathers and
   indexes the wrapper, current claims, Office Actions, and available cited
   references. I’m checking it now.” Do not ask for confirmation. Do not
   call `matter_list` solely to pick wording. Do not repeat this preamble on
   later claim or status reads.
   `first_compile` means this workspace had to initially build the matter —
   including when this host only attached to an in-flight job. If
   `matter_open` reports not compiled while a compile is running, call
   `matter_compile` to attach; do not imply a second compile.
   On `in_progress`, do not invent completion facts. After `complete`, give
   a short factual completion only from fields that are present
   (`first_compile`, `file_history_through`, `office_actions`,
   `references_held`, `references_missing`).
   The first compile is a durable job and can take several minutes (large
   wrappers, OCR). If the tool returns `in_progress`, that is success:
   compilation is continuing. Explain the named phase (not n-of-m step
   counts). After at most one follow-up check this turn, return control —
   do not auto-poll in a loop. Do not ask the user whether to retry and do
   not describe the server as unavailable. Subsequent `matter_compile`
   calls attach to the same job when the user asks to check. A connector
   timeout is not a compile failure. `matter_refresh` if the wrapper may
   have moved.
2. `matter_open(view="response_context")` — caption, posture, current OA,
   claim reliability, prior arguments.
3. `matter_audit` — address red/blocking findings before relying on derived data.
4. `oa_response_status(application_number=...)` — server tells you where the
   workflow actually is. `prosecution_playbook` is how to perform that phase.

Do not require a full-wrapper read at orient. Bibliographic facts come from
`matter_open`'s Caption line, never from paper footers.
