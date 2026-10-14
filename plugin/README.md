# PatentReply

Respond to USPTO office actions from the file wrapper. PatentReply compiles an
application's public prosecution record, reviews each rejection against the
cited evidence and the MPEP, records a per-issue response plan for the
attorney's approval, and generates the 37 CFR 1.121 claim listing and the
filing-ready response document on the server. Every quoted claim and cited
passage carries a `pkb://` verification address into the stored record, so
nothing is drafted from model memory.

## What this plugin contains

- Skills: `oa-response` (the canonical office-action methodology),
  `matter-triage`, `examiner-interview-prep`, `response-format`, and the thin
  `oa-response-drafting` wrapper.
- Commands: `/oa`, `/respond`, `/interview`, `/status`.
- One remote MCP server, declared in `.mcp.json` as `patent-kb`:
  `https://mcp.patentreply.ai/mcp/v2` over Streamable HTTP.

## What it runs, sends, and fetches

- Runs nothing locally. There are no hooks, no scripts, no local servers, and
  no `npx` / `uvx` launchers. The skills and commands are prose instructions.
- Sends only the arguments of the MCP tool calls Claude makes to
  `mcp.patentreply.ai`: application numbers, `pkb://` addresses, scope and
  mode selectors, and the plan or Remarks text you ask it to record. It never
  reads Claude's memory, chat history, or files on your machine.
- Fetches tool results from the same server. Server-side, PatentReply
  ingests public USPTO records (Open Data Portal) and current MPEP text
  (mpep.io) for the applications you name.
- Authentication is OAuth 2.0 against your PatentReply account; the first
  tool call opens your browser to sign in. No API keys are stored in this
  plugin, and none are asked for.

## Safeguards

Attorney approval is server-enforced: drafting tools refuse until the plan is
approved on the PatentReply approval page, and a host confirmation dialog is
never sign-off. The portable profile serves public-record content only; work
product is tier-gated. Deadline discussion is orientation, not docketing
authority.

## Requirements

A PatentReply account, and network access to `mcp.patentreply.ai`. Word
(.docx) output is generated server-side and returned as a download link.

## License

Proprietary — PatentReply.ai. See `.claude-plugin/plugin.json`.
