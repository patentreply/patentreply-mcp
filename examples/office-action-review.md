# Walkthrough: review a USPTO Office Action with PatentReply

[Back to PatentReply MCP](../README.md) · [Connect your AI](../docs/connect.md)

This is an interactive walkthrough using your own public application.
Replace `[your application number]` with a real application number. The
steps explain what to ask and what to review in the retrieved results.

## 1. Open the matter and get oriented

> Use PatentReply to open U.S. application [your application number]. Tell me
> the current prosecution posture, which claims are pending, and whether an
> unanswered Office Action exists. Flag missing source material or disputed
> claim text before we rely on it. Start with orientation.

The first compilation may take a few minutes. Expect an orientation grounded
in the compiled record, including relevant audit findings. An allowed,
issued, abandoned, or already-answered matter may have no response to draft;
choose an application with a pending action to continue the response steps.

## 2. Understand the examiner's position

> Review the pending Office Action. For each rejection or objection, identify
> the affected claims, the examiner's reasoning, and the references or
> passages relied on. Separate the examiner's position from your assessment.

Expect a per-issue explanation with source references. Ask your AI to
retrieve the underlying passage when a citation is incomplete, claim text
is disputed, or the analysis depends on something the parser did not cover.

## 3. Inspect the evidence for one issue

Choose a claim and rejection that the review actually identifies. Then ask:

> For this rejection, compare the claim language with the cited passages in
> the references. Read the passages before evaluating the mapping, give me
> the source addresses, and identify which parts need closer attorney review.

For a visual check, follow up with a request to show a particular claim,
paragraph, or figure. Source addresses refer to the stored matter and may
require your PatentReply sign-in. A search miss alone does not establish
that a reference lacks a feature.

## 4. Develop response options

> Propose response options for the issue we just reviewed. For each option,
> explain the supporting evidence, tradeoffs, and any specification support
> needed for an amendment. Retrieve the relevant legal authority. Let me
> choose the strategy before submitting a plan for approval.

Expect options tied to the operative claims and record, with unresolved
questions surfaced. If the base claim text is disputed, resolve that dispute
before building an amendment on it.

## 5. Approve the plan, then prepare the response

When you have selected the strategies:

> Record the selected strategy for each issue in the response plan. Summarize
> the plan revision and submit it for my approval on PatentReply.

Review and approve the specific revision on the PatentReply approval page
as the registered practitioner. After approval:

> Prepare the response and claim listing from the approved plan. Use the
> server's document generator, and identify the plan revision and any
> remaining information I need to review in the draft.

The hosted service returns the Word response and claim listing for attorney
review. If you change strategy, revise and reapprove the plan before drafting
from the new strategy. Access to these features depends on your plan.

## 6. QC your draft

If you have a response draft to check, including one prepared outside
PatentReply:

> Give me a PatentReply upload link for my response draft. After I upload it,
> run QC against the current prosecution record and complete the source-based
> argument and editorial review. Show blockers, unsupported assertions, and
> the changes that require my attention.

Expect a report that distinguishes deterministic findings from the argument
and editorial review. Assess the current record and resolve outstanding
findings before finalizing a filing.

## Continue the conversation

Ask for an examiner interview agenda, inspect another rejection, revisit
the chosen amendment, or refresh the matter after a new paper appears.
The [workflow guide](../docs/workflows.md) links directly to the packaged
methodology for each task.
