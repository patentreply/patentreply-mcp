---
name: matter-triage
description: Intake and triage when a new office action or USPTO paper arrives, or when the user asks "what's the status", "what came in", "what's due", or names an application number without a specific task. Produces a posture snapshot, deadline picture, and recommended next action. Use this as the entry point when the user's goal is unclear.
---

# Matter Triage

Fast orientation on a matter or docket so the attorney can decide effort level before anyone drafts anything.

Methodology authority: `prosecution_playbook(application_number=..., phase="orient")` — its sequence/rules/known-issues are matter-tailored and server-derived; consult it before improvising. Follow each tool result's `next` block.

Tool availability note: in Claude Code the patent-kb tools may be deferred. Load a tool with ToolSearch using its exact name (`select:` form) or simply attempt the call — NEVER conclude a tool is unavailable from a keyword-search miss. The server tailors the tool list to the account's tier; `matter_compile`, `matter_refresh`, and the oa_* tools are available on every tier (usage quotas, not tool absence, are the plan limits).

## Single matter

1. Before `matter_compile` or a first `matter_open` that may compile: short preamble (check whether PatentReply already has the application; if this is the first compile it may take a few minutes) then call immediately. Do not ask for confirmation. Do not call `matter_list` solely to pick that wording. `first_compile` means this workspace's initial build, including attach. Report completion facts only when present on `complete`; never invent them from `in_progress`. `matter_list` still decides compile vs refresh vs open for triage, but it is not a preamble preflight.
2. `matter_list` to check state: not listed → `matter_compile` (start-or-status: `in_progress` is success — compilation is continuing; do not ask the user to retry or describe the server as unavailable; later checks attach to the same job); listed with the ⟳ needs-refresh marker → `matter_refresh`; otherwise `matter_open` directly (refresh only if the user expects new papers).
3. `matter_audit` — report trust issues up front, including any claims flagged as requiring text adjudication (those block drafting later; say so now).
4. If an unanswered OA exists, `oa_review(scope="overview")` and summarize: grounds, claims affected, art cited, and the response window.
5. Classify difficulty and recommend a path:
   - **Light**: objections/minor 112(b) only → propose examiner's-amendment call or short response.
   - **Standard**: single-ground art rejection with a visible gap → traverse, maybe minor amendment.
   - **Heavy**: multi-ground with §101 or a tight §103 combination → recommend interview before drafting; estimate whether RCE is likely.
6. End with one recommended next action and the command to run it (e.g., `/respond` or `/interview`).

## Retrieval modes — answering questions about a matter

The compiled Matter is the first retrieval surface. It already did the
reconciliation (current claim text, live grounds, event history), and its
facts carry verified_source labels that a fresh document read does not.
These modes set the default starting point; they never forbid a read —
escalate to the full source whenever an escalation trigger fires or the
user asks.

| Mode | Use for | Start with | Typical reads |
|------|---------|-----------|---------------|
| **Quick** | Status, deadlines, claim text, "what grounds", "what's due" | `matter_open` / `claims_get` / grounds view | 1–3 tool calls, no `matter_read` |
| **Standard** (default) | Analysis questions: "how strong is the 103", "does Li teach X" | Compiled surfaces, then `evidence_read` / targeted `matter_read` of the specific passage | 2–4 targeted reads, not full documents |
| **Full-record** | Drafting, verification, discrepancies, or the user asking for the source | `matter_read mode=full` on the named documents | Whatever the task needs — no cap |

**Mandatory escalation to the source (never answer from the compiled
surface alone):**

- Any claimed ABSENCE — "no grounds", "not disclosed", "the OA doesn't
  address X" — is parser inference; confirm via `matter_read` first.
- A fact you are about to assert has no verified_source label.
- The audit reports a coverage gap on a document relevant to the
  question — read the source directly; the compiled surface is known-
  incomplete there.
- The user challenges an answer, or compiled Matter and a document you
  read disagree. On disagreement, report the discrepancy (and
  `matter_audit`) — never silently prefer your own reading, and never
  silently prefer the compiled value either.
- Claims flagged for text adjudication: the disputed text, not the
  compiled projection, is the object of discussion.
- Anything feeding a document that will be filed (the drafting skill's
  reading ledger governs there, not these modes).

**Non-escalation discipline:** do not re-derive from raw documents what
the compiled Matter already states with a verified_source label — a
fifteen-document re-read produces slower, less consistent, and less
verifiable answers than the surface built for the question. If you find
yourself opening a third full document to answer a status or posture
question, stop and say what you're looking for and why the compiled
Matter didn't answer it.

**Audit findings — two kinds, two behaviors:**

- **Coverage gaps** (a document or section is in the wrapper but was not
  parsed/projected — e.g., "Remarks not parsed for the 2026-04-13
  response"): the compiled Matter is incomplete there, but the source is
  available. For any question touching that document, go straight to
  `matter_read` on the source — no mode restriction, no permission
  needed, no caveat beyond a plain note that the answer came from the
  source document rather than the compiled surface. A coverage gap is a
  routing instruction, not a hazard.
- **Integrity flags** (disputed claim text pending adjudication,
  contradictory status, document/application mismatch, an unresolvable
  source): these gate reliance on the affected surface. Surface them
  before answering anything that depends on that surface.

**Proportionality:** report the audit picture once, at triage, sized to
what it is — "compiled, with two unparsed sections I can read directly
if needed" is a complete and honest summary of a coverage-gap-only
audit. After that, re-raise a finding only when a specific question
touches the flagged surface. Never hedge or refuse an answer because of
an audit warning unrelated to the question, and never present a
coverage gap as an error in the matter itself.

## Deadlines

- The response window computes from the OA **mailing date in the wrapper record** (`oa_review` / `matter_open`), never from user memory. State the assumption explicitly (e.g., "3-month shortened statutory period, extendable to 6").
- Never quote extension fee amounts from memory. If the user needs fees, pull the current rule text via `authority_read` (MPEP 710 and the current USPTO fee schedule) or tell them to verify against the current fee schedule — fee amounts change and a stale number is a docketing error.
- This plugin is not a docketing system. Deadlines here are orientation, not calendar authority; say so when a date is close.

## Docket sweep

When asked "what changed" across matters: `matter_list`, then `matter_changes` per matter since the given date. Report only matters with substantive activity: new OAs, notices of allowance, missed-deadline risk. Sort by deadline proximity. One line per quiet matter at the end ("no change").

- On dockets larger than ~25 compiled matters, sweep the 25 most recently active first and ask before continuing — a full sweep is one call per matter.

## Discipline

- If the audit shows the compile is incomplete or claim text is disputed, say so before giving any deadline or posture conclusion.
- A "no change" report is only as good as the refresh: if a matter wasn't refreshed, say "no change as of last compile (date)", not "no change".
