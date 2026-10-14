# Evidence discipline

## Wrapper evidence

Use `evidence_resolve`, `evidence_read`, `evidence_search`, `matter_read`.

- Canonicalize loose citations before arguing them.
- Prefer exact source text for load-bearing arguments; keep `pkb://` anchors
  in internal drafts (strip them from filing documents).
- Distinguish examiner characterization from what the source actually says.
- Distinguish search inference from verified absence.

Evidence retrieval does not imply user-facing rendering. Verify with the read
tools (`evidence_read`, `claims_get`, `authority_read`), which never render.
`evidence_show`, `claims_show`, and `authority_show` render a viewer on every
call — use them only when the user asked to see that source.

## Legal authority

Use `authority_resolve`, `authority_search`, `authority_read`, `authority_cited_by`
(`authority_show` only when the user asks to see the authority).

Do not recite current MPEP or case-law wording from memory when these tools
are available. Grounds record what the examiner *cited* historically; current
law is looked up live.
