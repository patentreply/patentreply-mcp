# Claim amendments

The model proposes substantive full claim text. The server deterministically
generates and validates the 37 CFR 1.121 listing and markup.

- Use `oa_amendment_listing` from the **approved** plan's proposals.
- Never hand-format status identifiers, underlining, or strikethrough.
- Base text must be the operative claim version. Disputed or OCR-suspect text
  no longer blocks the listing: the claim is drafted as the stored text reads
  and named under REVIEW BEFORE FILING (in the listing result and as a
  drafting note in the document). Resolve via the adjudication packet only
  when the exact words matter to the strategy; otherwise the attorney's final
  review carries it.
- After-final amendments the examiner refused never enter the operative set.
- If the listing is stale (base claim superseded), regenerate from a fresh
  approved plan — do not edit markup.
- Replacing an earlier proposal: `set_entry` with `supersedes: [old_id]`.
  Dropping one: `action=withdraw_proposal`. Never leave two active texts
  for the same claim version, and never draft from a retired proposal.
  See [revision.md](revision.md).

See bundled `claim-amendment-rules.md`.
