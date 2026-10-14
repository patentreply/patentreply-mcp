# Pre-filing QC of a response draft (Review surface)

Use when the attorney has a final or near-final Office Action response and
wants it checked against the prosecution record before filing. The draft may
come from anywhere: `oa_response_document` output the attorney edited, a
draft written with the KB open, or a document that never touched
PatentReply. A confirmed plan is not required.

QC is independent of the drafting workflow. Running it never moves
`oa_response_status`; it is an orthogonal work product on the matter.

## Sequence

1. Mint the upload: `matter_upload_request kind=response_draft`. The draft
   is parked on the link and attached only when you read the request back
   (`request_id`). It is work product: never applied to the claim record.
2. Run: `oa_response_qc action=run draft_id=<from the upload> response_mode=structured`.
3. The server report is **deterministic only**. It states
   `deterministic_status` (`blockers_found | review_required |
   deterministic_clear`). It never says "ready". Two layers are yours:
   argument verdicts and editorial review (`host_layers_pending`).

## Verdicts on assertions (fresh reasoning pass)

Start a fresh reasoning pass for verdicts: do not reuse any plan or draft
reasoning from earlier in the conversation. For each `assertions[]` entry,
read `examiner_reliance` and `neighbor_candidates` at the source
(`evidence_read`) before labelling. Cite the anchor each verdict was decided
on.

```
positive assertion
  SUPPORTED            an anchored passage states what the draft says
  NEEDS_QUALIFICATION  the passage is narrower or conditional
  CONTRADICTED         an anchored passage states the opposite
  UNVERIFIED           nothing located, or reference unresolved

negative / exhaustive assertion  ("does not disclose", "teaches only", "neither…nor")
  SUPPORTED            ONLY when source_verification.complete == true
                       AND the full read found nothing contradicting
  NEEDS_QUALIFICATION  a located passage narrows the absolute
  CONTRADICTED         a located passage discloses what the draft says is absent
  UNVERIFIED           source_verification.complete == false (the default)
```

A search miss is never proof of absence. A negative assertion with
`source_verification.complete == false` is rendered "UNVERIFIED — full read
of <reference> required" with the `matter_read mode=full` calls the server
supplies. Complete the read, then `oa_response_qc action=get` refreshes the
verification without a new report.

## Host review of heuristic flags

Findings with `host_review: true` (rendered under FOR HOST REVIEW) are
places where the server could only detect a *possible* problem: antecedent
basis, an unnarrated amendment, a reference-name slip, a placeholder, a
combination gap, a posture question. They are not counted in
`deterministic_status`. Before the attorney sees them, decide each one:

- **Confirm** — state why it is a real problem, with the claim text or
  passage that shows it. It joins the report at the severity the server
  gave it.
- **Clear** — state why it is not a problem (e.g. "determining signal
  delays" introduces the term; "the determined signal delays" restates
  it). List cleared items under "Cleared on review" so the attorney can
  audit the decision in one line each.

Never clear a deterministic finding (`host_review: false`): a caption,
listing, dependency, status, coverage, or closed-program finding is a
record fact. If you believe one is wrong, say so next to it and keep it;
the fix belongs in the server rule, not in the report.

## Rendering the attorney report

Server findings first, in server order: CRITICAL, then SUBSTANTIVE, then
EDITORIAL. For each item: concern, why flagged, recommendation, source.
Merge verdicts into those tiers: CONTRADICTED is critical;
NEEDS_QUALIFICATION is substantive. Editorial review (typos, defined-term
consistency, duplicated or unfinished arguments, unsupported absolutes) goes
**last** and is capped at ten items.

READY TO FILE may appear only when all of: `deterministic_status ==
deterministic_clear`; every negative assertion has
`source_verification.complete == true`; no verdict is CONTRADICTED or
NEEDS_QUALIFICATION; editorial review has run. Otherwise NOT READY TO FILE
or REVIEW REQUIRED with the counts.

The report states the matter state it was measured against
(`basis.measured_at`). If `action=get` reports staleness, say the record
moved and offer to re-run; never present a stale report as current.

## After the report

QC never launches the examiner red team. When the report is rendered you may
offer it once as a next step ("stress-test this as the examiner?"); run it
only if the attorney asks or accepts — [red-team.md](red-team.md).

## Never

- Rewrite the draft. Offer "fix items n, m" only if the attorney asks.
- Raise the server's status. You may lower it, never raise it.
- Label a negative assertion SUPPORTED from reliance passages and neighbors
  alone.
- Quote current law from memory; use `authority_*`.
