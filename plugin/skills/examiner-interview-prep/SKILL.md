---
name: examiner-interview-prep
description: Prepare for a USPTO examiner interview - agenda, proposed amendments, talking points, fallback positions, and the interview agenda paper. Use whenever the user mentions an examiner interview, wants to "call the examiner", asks what to propose in an interview, or wants an interview agenda or summary for a specific application.
---

# Examiner Interview Prep

Produce a one-page agenda the attorney can file plus an internal prep memo with fallbacks. Interviews succeed on specificity: a concrete proposed amendment and a crisp reason it distinguishes the art.

For per-ground methodology (frames per statute, matter-specific known issues), call `prosecution_playbook(application_number=..., phase="strategize")` — the grounds it serves come from the actual office action.

## Workflow

1. `matter_open(view="response_context")` + `oa_review(scope="issues")` for current posture and the live grounds. `matter_changes` to catch anything filed since last look.
2. Identify the interview objective — pick ONE primary: (a) reach agreement on a proposed amendment, (b) clarify the examiner's claim construction, (c) resolve a §101 framework dispute, or (d) test which reference the examiner considers essential in a §103 combination. Confirm the objective with the user.
3. Build the proposed amendment (if objective (a)): start from the operative text via `claims_get` — if the claim's text is flagged as disputed/OCR-suspect, resolve it first (see the oa-response-drafting skill, step 2); never propose an amendment against unverified base text. Find the narrowest limitation that clears the cited art, with spec support located via `evidence_search(scope="specification")` and pinned to pkb:// URIs. Prepare one fallback amendment narrower than the primary.
4. Draft talking points per ground: lead with the claim language, then the gap in the reference (verified via `oa_review(scope="citation_audit")` and `evidence_read`), then the proposed resolution. Two to three points max per ground — interviews are 30 minutes.
5. Check examiner context in the record: prior interview summaries in the wrapper (`matter_documents` → `matter_read`), and how this examiner responded to prior arguments in the same case (`matter_open(view="history")`).
6. If a durable record is wanted, store the interview strategy as options on the relevant issues in `oa_response_plan` (status under_review) so the post-interview response starts from what was actually proposed.
7. Produce two documents, **both as markdown, neither as a .docx**. No server
   tool renders an interview agenda, and a filing paper only ever comes from a
   server renderer (`oa_response_document`) — so do not build one by hand here.
   Give the user the markdown and say it is a working draft, not a filing paper.
   - **Interview Agenda** (working draft, for the attorney to finalize and file
     themselves): caption, participants, proposed discussion topics, proposed
     claim amendments clearly marked "proposed — for discussion only". Follow the
     `response-format` skill's caption rules so the content is right; the
     attorney supplies the filing format.
   - **Prep memo** (internal): fallback positions, concession limits (what NOT to agree to on the call), estoppel risks of each proposed statement, and the walk-away plan (what goes in the written response if no agreement).

## Discipline

- Never propose an amendment in the agenda that the user hasn't approved — the agenda enters the record.
- Flag any talking point that concedes claim scope; the record of the interview summary can create estoppel just like a filed remark.
- Current law in talking points comes from `authority_read` / `authority_resolve`, never model memory.
