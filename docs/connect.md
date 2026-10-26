# Connect PatentReply to Claude, ChatGPT, or Cursor

[Back to PatentReply MCP](../README.md)

PatentReply is a hosted Model Context Protocol server. Add it to your AI
client, complete the browser sign-in, then give your AI an application number.
The [guided connection page](https://www.patentreply.ai/connect) provides the
product's current client-specific instructions.

| Setting | Value |
| --- | --- |
| Server URL | `https://mcp.patentreply.ai/mcp/v2` |
| Transport | Streamable HTTP |
| Authentication | OAuth, with dynamic client registration and PKCE |
| API key | No API key is required |
| Discovery metadata | `https://mcp.patentreply.ai/.well-known/oauth-protected-resource/mcp/v2` |

## Claude

In Claude's connector settings, add a custom connector with the server URL.
Approve the PatentReply sign-in and enable the connector in the conversation.
For web, desktop, and mobile availability, follow the
[Claude connection guide](https://www.patentreply.ai/documentation/connect/claude).

## ChatGPT

The current OpenAI setup flow is:

1. Open **Plugins**, select the **plus** button, then **Add custom MCP server**.
2. Name it **PatentReply** and enter the server URL below.
3. Choose **OAuth** and create the plugin.
4. Complete the PatentReply sign-in, install the resulting plugin, and select
   it in the conversation.

The existing PatentReply ChatGPT configuration uses this compatibility alias
of the hosted server:

```text
https://mcp.patentreply.ai/mcp/v2-2026-10
```

The canonical endpoint remains `/mcp/v2`. The dated alias supports existing
ChatGPT configurations and is not a separate service or pricing plan.

For an existing connection with an outdated tool catalog, first use the
client's refresh option in the plugin or app details. Keep the connection's
configured URL unless the current PatentReply guide directs a change.

Menu names and access can differ by workspace. See
[OpenAI's custom MCP server instructions](https://developers.openai.com/api/docs/guides/custom-mcp-server)
and the [PatentReply ChatGPT guide](https://www.patentreply.ai/documentation/connect/chatgpt).
Setup wording checked October 24, 2026.

## Claude Code plugin

The plugin packages the remote connection with the Office Action workflow
skills and commands. Run:

```bash
claude plugin marketplace add patentreply/patentreply-mcp
claude plugin install patentreply@patentreply
```

In a Claude Code session, run `/mcp` and sign in to PatentReply. Use ordinary
language, or these installed commands:

| Command | Purpose |
| --- | --- |
| `/patentreply:status` | Orient to a matter and its current posture |
| `/patentreply:oa` | Review the Office Action |
| `/patentreply:respond` | Work through the response workflow |
| `/patentreply:interview` | Prepare an examiner interview |

Give the command an application number, or use a matter already open in the
conversation. Claude Code prefixes the plugin's command names with
`patentreply:`. The generated plugin README and command files also use their
short names when referring to commands inside the package.

See [plugin contents](../plugin/README.md) and
[Anthropic's marketplace instructions](https://code.claude.com/docs/en/plugin-marketplaces).

## Claude Code MCP-only

To configure the hosted connection directly:

```bash
claude mcp add --transport http patentreply https://mcp.patentreply.ai/mcp/v2
```

Run `/mcp` to complete sign-in. The command adds the connection for the
current project; use Claude Code's user scope if you want it across projects.
The [shell snippet](../mcp/claude-code.sh) contains the same command.
The server supplies workflow guidance through its tools; packaged Claude
plugin commands are added by the plugin installation above.

## Existing connections

Check your client's MCP configuration before adding another copy of the
endpoint. The plugin's server is named `patent-kb`; the direct CLI example
names it `patentreply`. If you switch installation methods, keep one active
connection to the endpoint using the client's configuration controls.

## Cursor

Add this to your project's `.cursor/mcp.json`, or merge it into an existing
`mcpServers` object while preserving your other server entries:

```json
{
  "mcpServers": {
    "patentreply": {
      "url": "https://mcp.patentreply.ai/mcp/v2"
    }
  }
}
```

Approve the browser sign-in on first use. A copy is provided at
[`mcp/cursor.mcp.json`](../mcp/cursor.mcp.json). See the
[Cursor guide](https://www.patentreply.ai/documentation/connect/cursor).

## Other MCP clients

Use a client that supports Streamable HTTP and the server's OAuth flow.
Configure the canonical server URL from the settings table and complete the
client's browser sign-in. Check the
[other-clients guide](https://www.patentreply.ai/documentation/connect/other-mcp-clients)
for compatibility details.

## First use and troubleshooting

Ask your AI to open your application in PatentReply and give you a short
orientation. The [walkthrough](../examples/office-action-review.md) explains
the next questions to ask.

| What you see | Next step |
| --- | --- |
| Sign-in or permission request | Complete the browser flow with your PatentReply account. |
| Compilation in progress | Allow a few minutes for retrieval and processing; let the AI follow the server's status instructions. |
| Older or missing tool definitions | Refresh the existing connection in your client, then check the current client guide. |
| Missing source material or disputed claims | Review the reported gap or dispute with your AI before relying on the affected material. |
| Drafting is awaiting approval | Open the approval link and approve the specific plan revision as the registered practitioner. |

For help, email [info@patentreply.ai](mailto:info@patentreply.ai) with your client
name, setup method, and the error message. Public issues are suitable for
connection and documentation bugs; use private support for confidential
matter information.
