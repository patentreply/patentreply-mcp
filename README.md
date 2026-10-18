# PatentReply MCP

> The USPTO prosecution record for your AI. Connect once and work any U.S. patent application in Claude, ChatGPT, Cursor, or any other MCP client.

| | |
| --- | --- |
| **Hosted MCP server** (Streamable HTTP) | `https://mcp.patentreply.ai/mcp/v2` |
| **Authentication** | OAuth 2.1 with dynamic client registration; no API keys |
| **Product** | [patentreply.ai](https://www.patentreply.ai) |
| **Connect guide** | [patentreply.ai/connect](https://www.patentreply.ai/connect) |
| **Documentation** | [patentreply.ai/documentation](https://www.patentreply.ai/documentation) |

This repository is the public **connector card** for the hosted PatentReply
service: install snippets, registry metadata, and the Claude plugin. The
service itself is hosted by Patent Agentic LLC and is not open source.

[![M8ven Score](https://m8ven.ai/badge/mcp/patentreply-patentreply-mcp-1i5ym9?v=bec58b3430abbe68829cecd16c186bf6)](https://m8ven.ai/mcp/patentreply-patentreply-mcp-1i5ym9?s=readme)

## What it does

Give it a U.S. application, patent, or publication number. PatentReply
compiles the application's public file wrapper into a working record: every
claim version on the legal date it took effect, each office action with its
rejections and objections, the cited references, and the specification. Ask
it to review the pending office action and it sets each rejection against the
exact passage the examiner relied on, with a verification address into the
stored record for every quote, so nothing is drafted from model memory.
Current law comes from the MPEP and case text live, never recited.

The response is built in stages the attorney controls. A per-issue response
plan is frozen as an immutable revision; drafting stays locked until a
registered practitioner approves that revision on the PatentReply approval
page. A confirmation inside the chat is never sign-off. After approval,
PatentReply generates the 37 CFR 1.121 claim listing and the filing-ready
response document (Word) on the server and returns a download link.

## Quick start

### Claude (web, desktop, mobile)

Settings → Connectors → **Add custom connector** → paste
`https://mcp.patentreply.ai/mcp/v2` → approve the PatentReply sign-in.
Once the PatentReply listing is live in the Connectors Directory, you can
add it from there instead.

### Claude Code

```bash
claude mcp add --transport http patentreply https://mcp.patentreply.ai/mcp/v2
```

Then run `/mcp` and approve the sign-in. The [Claude plugin](#claude-plugin)
below adds the office-action methodology and slash commands on top.

### Cursor

Settings → MCP → **Add new MCP server**, or add to `.cursor/mcp.json`
(copy of [`mcp/cursor.mcp.json`](mcp/cursor.mcp.json)):

```json
{
  "mcpServers": {
    "patentreply": { "url": "https://mcp.patentreply.ai/mcp/v2" }
  }
}
```

### ChatGPT

Settings → Connectors → Advanced → enable **Developer mode** → **Create** →
paste `https://mcp.patentreply.ai/mcp/v2-2026-10` → enable it in the chat
tools menu → approve the sign-in. ChatGPT keeps the tool catalog it first
read for a URL, so the ChatGPT connector uses a dated alias of the same
server.

### Any MCP client

Streamable HTTP at `https://mcp.patentreply.ai/mcp/v2`, OAuth 2.1 with
dynamic client registration (RFC 7591) and PKCE. Discovery metadata is at
`https://mcp.patentreply.ai/.well-known/oauth-protected-resource/mcp/v2`.

## First prompts

- "Compile application 18/123,456 and tell me where we are in the office action response."
- "Review the pending office action and summarize every rejection with the cited evidence."
- "Show me MPEP 2143.01 and the passage of the primary reference the examiner relies on for claim 1."

## Claude plugin

[`plugin/`](plugin/) is the PatentReply plugin for Claude Code and the Claude
plugin directory: the `oa-response` office-action methodology and companion
skills, the `/oa`, `/respond`, `/interview` and `/status` commands, and the
connector declaration. It runs nothing locally; the skills and commands are
prose instructions, and the only network traffic is the MCP tool calls to
`mcp.patentreply.ai`. See [`plugin/README.md`](plugin/README.md) for exactly
what it runs, sends and fetches.

The `plugin/` tree is generated from the PatentReply build and replaced on
each release. Do not edit it here; open an issue instead.

## Registry metadata

- Official MCP Registry: [`server.json`](server.json) (`ai.patentreply/patentreply`).
- Glama: [`glama.json`](glama.json) names the maintainers who can claim this repository.

## Pricing, privacy, trust

- [Pricing](https://www.patentreply.ai/pricing)
- [Privacy](https://www.patentreply.ai/privacy) · [Security](https://www.patentreply.ai/security) · [Terms](https://www.patentreply.ai/terms)
- PatentReply receives only the arguments of the tools your AI calls. It
  never reads conversation history, memory, or files on your machine, and
  your matters are not used to train models.
- PatentReply is software, not a law firm. The registered practitioner
  remains responsible for every filing.

## Support

info@patentreply.ai

## License

The files in this repository outside `plugin/` are released under the MIT
License (see [`LICENSE`](LICENSE)). The `plugin/` tree carries its own
license as stated in its manifest. The hosted PatentReply service is
governed by its [Terms](https://www.patentreply.ai/terms).
