#!/usr/bin/env bash
# Add the hosted PatentReply MCP server to Claude Code, then run /mcp to sign in.
set -euo pipefail
claude mcp add --transport http patentreply https://mcp.patentreply.ai/mcp/v2
