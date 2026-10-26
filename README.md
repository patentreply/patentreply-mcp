# PatentReply MCP — USPTO Patent Prosecution for Claude and ChatGPT

**Connect your AI to the patent file wrapper.** Open a U.S. patent matter in
Claude, ChatGPT, or Cursor and work with an assistant that has the prosecution
record organized and indexed: claims, Office Actions, cited references, and
the specification.

Review a rejection, check the examiner's citations, prepare for an interview,
or develop a response plan. PatentReply supplies the record and workflow;
you direct the strategy and approve the plan before response drafting.

**[Connect PatentReply](https://www.patentreply.ai/connect)** ·
[Follow the walkthrough](examples/office-action-review.md) ·
[Documentation](https://www.patentreply.ai/documentation)

**Start free:** one new public matter per month, no credit card.
See [pricing and plan features](https://www.patentreply.ai/pricing).

## How it works

1. **Connect once.** Add the hosted Model Context Protocol (MCP) server to
   your AI client and approve the PatentReply sign-in.
2. **Open a matter.** Give your AI an application number. PatentReply retrieves
   the public USPTO file wrapper and builds the working record. The first
   compilation can take a few minutes.
3. **Work through the case.** Ask questions, inspect the source passages, and
   develop a response. An attorney approves the response plan on PatentReply
   before the gated drafting tools generate the response and claim listing.

After connecting, replace the bracketed text with your application number:

> Open U.S. application [your application number] in PatentReply. Summarize
> the current claims and prosecution posture, and flag any missing or disputed
> record material before we discuss strategy.

## What you can do

| Task | Try asking your AI |
| --- | --- |
| Understand the prosecution history | "What changed in this application, and which claims are currently pending?" |
| Analyze an Office Action | "Review each rejection and show the claims and evidence the examiner relies on." |
| Verify a cited passage | "Show the cited paragraph of the primary reference and compare it with claim 1." |
| Check patent prosecution authority | "Retrieve MPEP 2143.01 and explain how it relates to this rejection." |
| Prepare an examiner interview | "Help me prepare an interview agenda and fallback positions for this matter." |
| Plan amendments and a response | "Develop response options for each rejection, with specification support for proposed amendments." |
| Review a draft before filing | "Give me an upload link for my response draft, then run QC against the record." |

[Explore the workflows and tools](docs/workflows.md) and
[walk through an Office Action review](examples/office-action-review.md).
Feature access and usage allowances depend on your plan.

## Connect your AI

| Connection | Details |
| --- | --- |
| Hosted MCP server | `https://mcp.patentreply.ai/mcp/v2` |
| Transport | Streamable HTTP |
| Authentication | OAuth sign-in; no API key |

| Client | Get started |
| --- | --- |
| Claude web, desktop, or mobile | Add a custom connector using the server URL, then approve the sign-in. [Claude guide](https://www.patentreply.ai/documentation/connect/claude). |
| ChatGPT | Add PatentReply as a custom MCP plugin with OAuth. [ChatGPT setup and compatibility URL](docs/connect.md#chatgpt). |
| Claude Code | Install the plugin below, or use the [MCP-only connection](docs/connect.md#claude-code-mcp-only). |
| Cursor | Add [`mcp/cursor.mcp.json`](mcp/cursor.mcp.json) to your MCP configuration. [Cursor guide](docs/connect.md#cursor). |
| Other clients | Use a client that supports Streamable HTTP and PatentReply's OAuth flow. [Connection details](docs/connect.md#other-mcp-clients). |

The [connection guide](docs/connect.md) covers authentication, first use,
and troubleshooting.

### Claude Code plugin

Install the packaged skills, commands, and MCP connection together:

```bash
claude plugin marketplace add patentreply/patentreply-mcp
claude plugin install patentreply@patentreply
```

Start a Claude Code session, run `/mcp`, and complete the PatentReply sign-in.
Then try `/patentreply:status` with an application number, or use ordinary
language. Other commands are `/patentreply:oa`, `/patentreply:respond`, and
`/patentreply:interview`.

The plugin already declares the hosted MCP server as `patent-kb`. Choose
this installation or the MCP-only connection; see
[existing connections](docs/connect.md#existing-connections) if you already
added the endpoint manually.

## Evidence and attorney control

PatentReply makes the compiled claims, Office Actions, cited references,
specification, and prosecution history available to your AI. Record citations
use `pkb://` verification addresses into the stored matter. Legal-authority
tools retrieve MPEP and other supported authority text for the analysis.

The workflow checks the record before drafting and surfaces missing source
material, unresolved citations, and disputed claim text. A source address
lets you inspect the evidence; the attorney still evaluates the conclusion.

Response planning and drafting are separate stages. A plan revision is
submitted for a registered practitioner's approval on the PatentReply
approval page. After approval, the hosted service generates the response
Word document and the 37 CFR 1.121 claim listing for attorney review.
A confirmation in chat does not sign the plan, and PatentReply does not
file papers with the USPTO.

## Public repository and service

This is the official public repository for PatentReply setup instructions,
registry metadata, and the Claude plugin. The hosted service is operated by
Patent Agentic LLC.

| Resource | Location |
| --- | --- |
| Connection instructions | [docs/connect.md](docs/connect.md) |
| Workflows, skills, and tool overview | [docs/workflows.md](docs/workflows.md) |
| Office Action review walkthrough | [examples/office-action-review.md](examples/office-action-review.md) |
| Pricing, records, and privacy questions | [docs/faq.md](docs/faq.md) |
| Claude plugin contents | [plugin/](plugin/) |
| MCP Registry metadata | [server.json](server.json), server name `ai.patentreply/patentreply` |
| Glama ownership metadata | [glama.json](glama.json) |
| Maintenance and discovery checklist | [docs/maintainers.md](docs/maintainers.md) |

The `plugin/` tree is generated from the PatentReply build and replaced on
release. Report changes through an issue so they can be made in the source
build. See [maintenance guidance](docs/maintainers.md).

## Privacy and support

PatentReply receives the arguments your AI sends in its tool calls, including
any text or documents you choose to supply through the workflow. It does not
independently read your conversation history, client memory, or local files.
PatentReply does not use your matters to train models. Your AI provider's
handling of the conversation is governed separately.

[Privacy](https://www.patentreply.ai/privacy) ·
[Security](https://www.patentreply.ai/security) ·
[Terms](https://www.patentreply.ai/terms) ·
[Pricing](https://www.patentreply.ai/pricing)

For connection problems or documentation feedback,
[open an issue](https://github.com/patentreply/patentreply-mcp/issues) or email
[info@patentreply.ai](mailto:info@patentreply.ai). Include the client and
the error message; send confidential matter information through the
appropriate private support channel.

PatentReply is software, not a law firm. The registered practitioner remains
responsible for every filing. See the [FAQ](docs/faq.md) for scope and limits.

## License

The files outside `plugin/` are released under the MIT License; see
[`LICENSE`](LICENSE) for its scope. The generated `plugin/` tree is
proprietary as stated in its [manifest](plugin/.claude-plugin/plugin.json).
The hosted service is governed by its [Terms](https://www.patentreply.ai/terms).

[![M8ven Score](https://m8ven.ai/badge/mcp/patentreply-patentreply-mcp-1i5ym9?v=bec58b3430abbe68829cecd16c186bf6)](https://m8ven.ai/mcp/patentreply-patentreply-mcp-1i5ym9?s=readme)
