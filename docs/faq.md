# PatentReply MCP frequently asked questions

[Back to PatentReply MCP](../README.md)

## Who is PatentReply for?

Patent attorneys and agents who want to work with the prosecution record
inside Claude, ChatGPT, Cursor, or another supported MCP client. You direct
the legal analysis and strategy; PatentReply supplies the matter record,
retrieval tools, and workflow controls.

## Is there a free plan?

Yes. Start with one new public matter per month, with no credit card.
See the [pricing page](https://www.patentreply.ai/pricing) for current
allowances and the features included in each plan.

## What is a matter?

A matter is a U.S. patent application and its compiled prosecution record.
You can start with an application, patent, or publication number. Compiling
or refreshing the matter counts in the month it is performed; reading an
existing compiled matter does not consume another compilation. See
[plans and matters](https://www.patentreply.ai/documentation/billing/plans-and-matters).

## Where does the record come from?

PatentReply retrieves the public file wrapper through the USPTO Open Data
Portal and builds a record of claims, Office Actions, cited references,
specification, and prosecution history. Retrieval and parsing can have gaps;
the matter audit and workflow surface those limitations.

## Can I supply documents that are missing from the public record?

Where supported by your plan and workflow, your AI can provide an upload
link for documents such as a missing amendment, a reference, or a response
draft. Unpublished and private material is not retrieved from the public
USPTO record. Review the current plan requirements and
[compilation guide](https://www.patentreply.ai/documentation/matters/compiling-a-matter).

## What does PatentReply receive from my AI?

The arguments sent in tool calls, which can include application numbers,
retrieval requests, proposed plan or Remarks text, and material you choose
to upload. PatentReply does not independently access your conversation
history, client memory, or local files. Your AI client determines what it
sends to tools; its own privacy terms apply to the conversation.

See [Privacy](https://www.patentreply.ai/privacy) and
[Security](https://www.patentreply.ai/security) for the service policies.

## What does a citation verify?

A `pkb://` address identifies material in the stored record so the AI and
practitioner can return to its source. A citation supports checking what a
passage says. The practitioner still determines whether it supports the
argument and whether the record is sufficient for that conclusion.

## What is the attorney approval step?

The registered practitioner approves a specific response-plan revision on
the PatentReply approval page. The gated response-drafting tools use that
approval. A chat confirmation does not approve the plan. If the strategy
changes, the revised plan must be submitted for approval again.

## Can I QC a draft prepared elsewhere?

Yes. The bundled QC workflow accepts a response draft independently of the
response-plan workflow. It combines server-side deterministic findings with
the AI's source-based argument and editorial review. A clear deterministic
check alone is not a complete filing review. See
[the QC methodology](../plugin/skills/oa-response/references/qc.md).

## Does PatentReply file the response or replace docketing?

The practitioner finalizes and files the response. The service returns
drafting artifacts for review, and any deadline discussion is orientation
rather than a docketing authority.

## Do I need to run a local server?

No. The MCP service is hosted. The Claude plugin contains workflow
instructions, commands, and a declaration of that remote connection.
See [what the plugin runs, sends, and fetches](../plugin/README.md).

## Is the service open source?

The hosted service is proprietary. Repository files outside `plugin/` have
the MIT license with the scope stated in [LICENSE](../LICENSE). The generated
plugin has the proprietary license stated in its
[manifest](../plugin/.claude-plugin/plugin.json).

## How do I get help?

Email [info@patentreply.ai](mailto:info@patentreply.ai). For public setup or
documentation bugs, [open an issue](https://github.com/patentreply/patentreply-mcp/issues)
with the client name and error message. Use private support for confidential
matter information.
