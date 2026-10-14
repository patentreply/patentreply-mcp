# Review

Mandatory: comprehensive OA and claim review, plus primary-source verification
of every load-bearing proposition.

Not mandatory: ingesting the entire specification or every cited reference body.

## Sequence

1. `oa_review(scope="overview")` — every live objection and rejection as a
   stable issue. Objections first, then rejections. Every action-level scope
   also returns `reading_view_url`: the OA Reading Room, an external
   PatentReply page where the attorney checks each examiner cite against the
   reference copy with their own login. Offer it when the attorney wants to
   see the cites for themselves or a citation check flags one. It is the
   attorney's manual check, not yours — your verification still goes through
   `evidence_read`.
2. Drill down only where it changes the analysis: `issues` → `issue` →
   `claim_audit` → `citation_audit` → `completeness`. Avoid blind maximal calling.
3. Retrieve the operative claim text at the OA date with `claims_get`.
   Inspect all claims needed for a comprehensive review. If the compile
   says a claim "needs a review before you file" (the OCR of the filed
   paper is damaged there and the record could not settle it), carry that
   note into the final draft and keep going: drafting proceeds from the
   stored text and names the claim under REVIEW BEFORE FILING. Open the
   adjudication packet only when the strategy turns on the exact words.
4. Verify examiner characterizations against the cited source using
   `evidence_read` / `evidence_resolve` (`pkb://`). Use the verified text in
   the analysis.

   These are evidence-gathering steps, not presentation requirements. The
   read tools never render; `claims_show`, `evidence_show`, and
   `authority_show` render a viewer on every call, so do not call them during
   routine review unless the attorney asked to see the source.

   In particular, do not display the full pending claim set merely because
   claim language needed verifying.

5. Read the **office action** in full (`matter_read what=paper mode=full`) so
   claim-interpretation sections and hidden objections are not missed.
6. Read a specification or reference in full **only when**:
   - a load-bearing proposition depends on uncited context; or
   - the compiled matter is untrustworthy for that document; or
   - the attorney asks for the source.

An `evidence_search` miss is not proof of absence
(`verified_absence=false`; `source_verification_required=true`). Confirm
at the source with `matter_read` before any negative inference.

See bundled `evidence-rules.md` for citation discipline.
