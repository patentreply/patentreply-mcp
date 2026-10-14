# Examiner red team of a response draft

QC asks whether the response is accurate, consistent, procedurally sound
and supported by the record. The red team asks a different question: given
the rejection actually before the attorney and the record actually
available to the examiner, where is this draft vulnerable? The two reports
are never merged. A red-team finding is never a QC finding, and neither one
predicts an outcome. Authority: `docs/specs/examiner-red-team-v0.1.md` (v0.2).

## When to run it

Opt-in, after QC. Run it only when the attorney asks for an examiner,
red-team or stress-test review, or accepts it as an offered next step, and
only on a draft with a completed `oa_response_qc action=run`. "QC this
response" never launches it. Like QC, it never moves `oa_response_status`.

There is no red-team tool. This is a methodology over the QC report.
Nothing is persisted: the report is rendered in the conversation only.

## Fresh context (required where the host allows it)

Run the examiner persona in a fresh context: in Claude, a separate sub-task
that receives the record, the draft and the QC report, and nothing else. No
reasoning from the plan, the drafting conversation, or the QC verdict pass
carries forward. Do not reuse the QC SUPPORTED / CONTRADICTED labels: form
your own view from the same evidence. A different model is optional. Where
the host cannot isolate context, run it anyway and say so in the header:
"examiner context NOT isolated from drafting context".

## Inputs

From the QC report (`response_mode=structured`):

- `findings`, each with `red_team_effect`;
- `assertions`, with `examiner_reliance`, `neighbor_candidates` and
  `source_verification`;
- `coverage` and `basis`.

Fetch the rest with the read tools as needed. `oa_review scope=issue` gives
the examiner's reasoning and mapping. `claims_get` gives the claim version
at the action's date. `matter_read what=paper mode=full` reads the action,
`evidence_read` reads every passage you will cite, and `authority_read`
reads any authority a counter relies on. Never retrieve with a `*_show`
tool. Prosecution history is this application's only.

## What QC blocks (the server decides)

| `red_team_effect` | behaviour |
|---|---|
| `block_report` | no red team; the report names the blocking finding id and stops |
| `block_issue` | every issue touching those claims is `skipped_qc_blocker`, finding id given |
| `none` | analysed normally; the finding may still be cited as basis |

Never widen or narrow these. A QC critical with `red_team_effect: none`
skips nothing.

## Method: a fixed question list per live issue

Answer each question only from the inputs. Discard any answer you cannot
anchor.

**§102 / §103**
1. Can the relied-on passage reasonably be read more broadly than the draft allows?
2. Does the draft attack reference R for a limitation the action maps to reference S or to the combination? (Start from QC `argument.combination_gap`.)
3. Does another cited passage of the same reference cure the alleged gap? (Start from `neighbor_candidates`.)
4. Does the draft import a limitation from the specification that the claim does not recite?
5. Does it attack the references individually rather than the combination?
6. Does the action already state an alternative motivation to combine?
7. Did the amendment distinguish the mapped passage, or only re-word the mapped limitation?
8. Does a prior argument, a disclaimer, or a concession elsewhere in the draft weaken this argument?

**§112**
1. Is the asserted antecedent basis actually clear on the claim text?
2. Does the passage the draft cites support the proposition?
3. If not, does the specification hold other readily locatable support that answers the counter (`evidence_search`, `neighbor_candidates`)? Then say so ("the cited ¶42 is weak support; ¶57 appears stronger") and rate the vulnerability on the draft's citation. Never build a counter by ignoring ¶57.
4. Did the amendment introduce a new ambiguity?
5. Can a written-description or enablement concern reasonably be maintained on the record?

**§101**
1. Can the amended limitation be characterised as part of the abstract idea as the action framed it?
2. Is the asserted technological improvement recited in the claim, or only in the specification?
3. Does the argument rely on the specification rather than claim language?
4. Can the additional elements be characterised as generic implementation, in the action's own words?

**After final**
1. Does the amendment require further search or consideration?
2. Is the requested procedural treatment actually available? (Start from QC `legal.*` findings; add the examiner's likely framing, not a new rule.)
3. Has the response created a new issue?

The §112 question 3 principle holds for every statute: be skeptical, not
willfully blind. Where the record readily answers a counter, the finding
says so in `record_answer` rather than suppressing the counter.

## Record only

The examiner persona uses the current action, references of record relied
on, the operative claims, this application's history, the specification,
and authority via `authority_*`. It never searches for prior art, never
cites a reference not of record, and never invents a disclosure or a
factual finding. "Could a different rejection be made?" is a different
task.

## Each finding

```
rt-<n>  <VULNERABILITY> · <record_supported | plausible_inference> · confidence <high|medium|low>
  Issue, claims, statute
  Applicant's position        quoted from the draft
  Examiner counter            the strongest anchored counter, in analytic voice
  How an examiner could respond (simulated)
  Record answer               readily locatable evidence that answers it, if any
  How to harden               what to add or change; never a rewrite
  Evidence                    OA mapping rows, pkb:// passages, claim versions, authority ids
```

- **Vulnerability.** `high` means a well-supported counter on a load-bearing
  part of the position that should be addressed before filing. `medium` is
  plausible and material, worth pre-empting. `low` is already substantially
  addressed.
- **Confidence.** How fair a reading of the record the counter is. It is
  never a probability of allowance or rejection.
- **Anchors.** Every finding cites at least one anchor. `record_supported`
  needs a record anchor: an action row, a passage, a claim version or a
  disclaimer. A counter with no anchor is speculative and stays out of the
  report.
- **Simulated voice.** Examiner-voice prose appears only under "How an
  examiner could respond (simulated)", so it cannot be mistaken for wrapper
  text.
- **Frames.** A frame is a taxonomy label only, never outcome data.

## Every live issue gets exactly one disposition

| status | when |
|---|---|
| `counter_identified` | one or more findings |
| `no_anchored_counter_identified` | reviewed; nothing anchored survived |
| `not_argued_in_draft` | QC `argument.issue_unaddressed`; no position to stress-test |
| `skipped_qc_blocker` | `block_issue`; give the finding id |
| `insufficient_evidence` | a relied-on reference is unresolved, or a required full read is not served |

Fixed wording for `no_anchored_counter_identified`: "No material anchored
examiner counter identified under the red-team scope (current Office
Action, references of record, this application's history). This is not a
prediction of allowance." Silence is never "the examiner has no answer".

## Before rendering: staleness re-check

Call `oa_response_qc action=get` on the report you started from. If it
carries `staleness`, withhold the red team: say the matter moved during
review and offer to re-run QC, then the red team. A rendered report
reflects one matter state, the one in its `basis`.

## Rendering

```
Examiner Red Team — <application>
Context: examiner context [isolated | NOT isolated from drafting context]
Basis: QC report <id> (matter state through <date>) — re-checked before rendering
Blocked: none | report blocked by <qc id> (<code>)
```

Then issue by issue, findings ordered by vulnerability, then the
**attorney action list**: QC critical and substantive items first, then
red-team `high`, then `medium`, each with its `qc-` or `rt-` id, so "fix
items 2, 4, 7" is unambiguous across both reports. `low` findings stay
under their issue, out of the action list.

## Never

- Predict an outcome: no "likely allowed", "likely maintained", "likely
  persuasive", and no percentages outside the simulated examiner voice.
- Run on a draft without a completed QC run, or launch from "QC this".
- Carry drafting, plan or QC-verdict reasoning into the examiner persona.
- Cite art not of record, or quote current law from memory (`authority_*`).
- Rewrite the draft. Offer "harden items n, m" only if the attorney asks.
- Present a report after the record moved.
