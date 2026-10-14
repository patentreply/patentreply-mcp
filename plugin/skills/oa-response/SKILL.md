---
name: oa-response
description: >
  Conduct an end-to-end U.S. patent Office Action response using a compiled
  PatentReply matter. Use when reviewing an Office Action, developing response
  strategy, proposing amendments, preparing Remarks, or assembling a response.
  Follow PatentReply evidence, approval, record, and workflow-state requirements.
  Do not use for simple record lookups (show claim 1, show a paragraph, what
  happened on a date).
license: Proprietary - PatentReply
compatibility: Requires access to a PatentReply MCP server.
metadata:
  author: PatentReply
  version: "1.1.15"
  workflow-contract: "oa-response/1"
---

# Office Action response

PatentReply MCP is the product. This skill teaches how an attorney uses it.
The server enforces state, approval, provenance, and filing artifacts.

## Do not load this skill for

- "Show claim 1" → `claims_show`
- "Show paragraph 25" / "open the cited passage in Pang" → `evidence_show`
- "Show me Figure 4" → `evidence_show`
- "Show me MPEP 2143" → `authority_show`
- "What does Dill ¶29 say?" → `evidence_read` / `matter_read`
- "What happened on May 7?" → `matter_open` / `matter_changes`
- "Where are we in the OA response?" → `oa_response_status`
- Docket orientation without a response task → `matter_open` (triage)
- "What was allowed / what did we give up / start a continuation" →
  `matter_open(view="continuation")` — the continuation evidence pack
  (allowed claims, reasons for allowance, narrowing history, candidate
  spec support, continuity, coverage gaps); evidence, not a judgment

## How to use this skill

- Need to know where we are? → `oa_response_status`
- Need to compile or open a matter that may not be in the KB? → first-open
  preamble (orient), then `matter_compile` / `matter_open`. No confirmation.
  Do not repeat on later reads.
- Need methodology for a **named/requested** phase (“walk me through
  assemble”, “how do I draft”)? → that phase’s reference file, or
  `prosecution_playbook` with `phase` set. Answer with **that** phase’s
  methodology even when it is not `current_phase`. Report any live-phase
  mismatch as a constraint on **execution**. Do not redirect the requested
  explanation to the current phase.
- Need methodology for the current phase (no phase named)? → the matching
  reference file, or `prosecution_playbook` with `phase` omitted
  (Mode B fallback)
- Need actual record facts? → retrieve them with the read tools (`claims_get`,
  `oa_review`, `evidence_read` / `evidence_resolve` / `evidence_search`,
  `matter_read`, `authority_read`). Never retrieve with a `*_show` tool: it
  renders a viewer on every call. Do not surface a viewer merely to prove
  that the source was checked.
- Attorney wants to check the examiner's citations by eye (the Office Action
  with every cite set against the reference copy)? → the `reading_view_url`
  that `oa_review` returns: the OA Reading Room, an external PatentReply page
  opened with their own login. Offer the link; it is not a viewer tool, and
  it is the attorney's manual check, not yours — your verification still
  goes through `evidence_read`.

Neither this skill nor `prosecution_playbook` moves the workflow.
Requested methodology phase and live workflow phase are independent.

## Precedence (mandatory)

1. Server-enforced state, validation, authorization, approval.
2. Authoritative record + verified legal authority (`pkb://`, `authority_*`).
3. This skill.
4. Tenant/firm practice preferences.
5. Exemplars / style.

A firm-practice skill may supplement drafting preferences. It may not override
record, evidence, approval, sequencing, completeness, or validation.

## Trust

- Server state outranks conversation memory.
- Never reconstruct operative claims when `claims_get` can provide them.
- Never reconstruct live grounds when `oa_review` can provide them.
- Never treat an `evidence_search` miss as proof of absence
  (`verified_absence=false`; confirm at the source).
- Never quote current legal authority from memory when `authority_*` tools are available.
- Do not use external web research for PatentReply workflow methodology
  when this skill or `prosecution_playbook` already supplied it (including
  37 CFR 1.121 assembly rules).
- Never infer that a plan remains approved after its basis has changed.
- Never bypass `STALE_WORKFLOW_STATE` or `PRECONDITION_FAILED`.
- Chat "looks good" is never attorney approval.
- Record-only scope. The universe of fact for a matter is its compiled record: the application as filed, the office actions, the references they cite and the art of record on the 892 and IDS, the prosecution history, and legal authority (statute, rules, MPEP, case law). Do not search the web, patent databases or literature for other prior art, and do not bring an uncited reference, product or publication into any analysis, plan, argument or remark — not even as a warning to the attorney. If the record seems to point outside itself, say that the record is the limit and stop; a prior-art search is a separate task the attorney requests in those words. The one allowed excursion is a copy of a reference ALREADY of record whose body the KB does not hold, supplied through matter_upload_request(kind=npl_reference) or reference_add: the reference must be of record; what may be sought is its copy, never a different document.
- `as_of` is a READ affordance — the file as it stood on a legal date. It never
  cuts plans, approvals or workflow state, so a cut read's phase is still live.
  A cut read is identifiable by its AS-OF READ banner and its `as_of_cutoff`
  block; never draft, approve or file from one.

## Viewer discipline

Record retrieval and user-facing presentation are different operations, and
the server gives them different tools. A host renders a viewer on **every**
call of a show tool, so the choice of tool is the choice to display.

| Material | Read (never renders) | Show (renders a viewer) |
|---|---|---|
| Claims | `claims_get` | `claims_show` |
| Passages, figures, drawing sheets | `evidence_read` | `evidence_show` |
| MPEP, cases, USPTO guidance | `authority_read` | `authority_show` |

Read and verify claims, Office Action passages, specification text, cited
references, drawings, and legal authority with the read tools whenever the
response workflow needs them. Those reads are background evidence-gathering.

Call a show tool only when the user expressly asks to show, open, display,
view, or inspect the material ("show me claim 1", "show me Jones ¶[0034]").
Never call one to verify your own reading, and never render a sequence of
claims, passages, figures, sheets, or authorities merely to demonstrate that
the record was reviewed. Report the relevant conclusion, citation, or short
excerpt in prose.

Viewer invocation is a presentation choice, not an evidence-verification step.

## Workflow positioning

Call `oa_response_status(application_number=...)` for the server-derived
current phase. `prosecution_playbook` is phase methodology — pass `phase` to
preview how to perform a phase; omit `phase` for methodology on the derived
current phase. A preview is not an instruction to advance the matter.
“Walk me through phase X” is not “advance this matter to phase X.”

On an allowed, issued or abandoned matter `oa_response_status` reports
`prosecution.response_task: none` and names the closing event; the last
action stays readable with `oa_review` as history. Do not open a plan,
request approval, or draft a response for it.

The same holds once the applicant's filing answers the latest action:
`prosecution.answered_by` names it ("closed: response filed <date>",
"closed: RCE filed <date>", "closed: notice of appeal filed <date>"), and
the next move is the Office's. A non-final, a restriction or a Quayle
action closes on the reply. A final closes only on an RCE or a notice of
appeal: an after-final reply alone, entered or not, leaves the task open
(`prosecution.pending_reply` names it). A reply the Office refuses reopens
the task. An action the Office withdrew has no response task either:
`prosecution.withdrawn_by` names the letter ("the action of <date> was
withdrawn by the Office on <date>").

Four distinct plan states — do not conflate them:

| State | How it happens |
|---|---|
| editable | `oa_response_plan` `action=open` (scaffold / reconcile), then `set_entry` (draft revision); `oa_response_plan_get` reads it back without writing |
| confirmed | `oa_response_plan` `action=confirm` (immutable revision) |
| submitted | `oa_response_plan_confirm` (pending approval request + URL) |
| approved | attorney signs the PatentReply approval page (approval node) |

`oa_response_plan_confirm` never approves.

The workflow is **not a one-way conveyor**. After confirm or approval, an
attorney revisit forks a new draft — [references/revision.md](references/revision.md).
Then re-read `oa_response_status`.

## Phase routing

Load the matching reference; do not dump every file.

- `orient` → [references/orient.md](references/orient.md)
- `review` → [references/review.md](references/review.md) + [references/evidence.md](references/evidence.md)
- `strategize` → [references/strategy.md](references/strategy.md)
- `approve` → [references/approval.md](references/approval.md)
- `draft` → [references/amendments.md](references/amendments.md) + [references/remarks.md](references/remarks.md)
- `assemble` → [references/assembly.md](references/assembly.md)
- attorney revisits a confirmed/approved plan → [references/revision.md](references/revision.md)
- attorney has a response draft to check before filing (any source) → [references/qc.md](references/qc.md)
- attorney asks for an examiner, red-team or stress-test review of a QC'd draft
  → [references/red-team.md](references/red-team.md) (opt-in; never launched by "QC this")

Recovery: [references/errors.md](references/errors.md)

Shared rules are bundled at build time from `skills-src/shared/`.

## Hard stops

On `PRECONDITION_FAILED` or `STALE_WORKFLOW_STATE`, run the returned
`recovery.sequence` verbatim. Do not invent a re-audit march.

Drafting tools (`oa_amendment_listing`, `oa_traversal_set`, `oa_response_document`)
require a valid approval node when gates are on. The server will refuse without it.

## Filing documents

The server generates filing artifacts (`oa_response_document`, and listing
renditions when offered). Never host-roll a Word file. Never reconstruct 1.121
markup by hand.
