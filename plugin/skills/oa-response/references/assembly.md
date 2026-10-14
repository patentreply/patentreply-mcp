# Assembly

When the user asks how assembly works (“walk me through assembling…”,
“how do I assemble”), explain this phase even if `oa_response_status` is
not `assemble`. Live phase is a gate on **calling** `oa_response_document`,
not on explaining the methodology.

**How assembly works**

1. Confirmed plan revision (immutable) + attorney approval node.
2. Verified §1.121 listing (`oa_amendment_listing`) and finalized Remarks
   traversal set (`oa_traversal_set`).
3. Caption/signature metadata from the attorney (name + registration
   number); docket number / deposit account / extension only if applicable.
4. Call `oa_response_document` — it combines those approved artifacts into
   the filing-ready DOCX (claims listing, Remarks, signature block).
   Server-side generation only.
5. Never silently substitute another response-plan revision.
6. Treat server artifact provenance as authoritative.

**Execution constraint:** if live phase is earlier than `assemble`, say so
after the methodology. Do not replace the assemble walkthrough with “the
immediate next step is to open the plan.”

The server rejects assembly from stale or incomplete workflow state.
Do not host-roll Word. If the tool is unavailable, stop and say so; produce
markdown only with a `NOT A FILING DOCUMENT` banner.
Do not fetch 37 CFR 1.121 from the public web when this file or
`prosecution_playbook(phase=assemble)` already supplied the rule.
