# Maintaining the public repository and discovery listings

[Back to PatentReply MCP](../README.md)

This repository publishes setup instructions, registry metadata, and the
generated Claude plugin for the hosted PatentReply service.

## Repository metadata

The GitHub About description and topics are repository settings, separate
from the README. Recommended description:

> MCP server for U.S. patent prosecution: USPTO file wrappers, Office Action
> analysis, claim amendments, and verified citations for Claude, ChatGPT, and Cursor.

Keep the website set to `https://www.patentreply.ai`. Relevant topics are:

```text
patent patent-prosecution patents uspto office-action mpep legal legal-tech
mcp mcp-server model-context-protocol claude claude-code chatgpt cursor agent-skills
```

Pin `patentreply-mcp` on the organization profile. Keep
[`patentreply/.github/profile/README.md`](https://github.com/patentreply/.github/blob/main/profile/README.md)
aligned with the connection path in this repository.

## Claude marketplace

The root `.claude-plugin/marketplace.json` lists `./plugin` as the source.
The marketplace and plugin are both named `patentreply`, giving the install
identifier `patentreply@patentreply`.

Before merging a release, run:

```bash
claude plugin validate .
claude plugin validate ./plugin
```

Test installing the plugin from a local checkout with an isolated Claude
configuration, then verify a signed-in connection separately. Successful
manifest validation does not establish OAuth or live service behavior.
See [Anthropic's marketplace guide](https://code.claude.com/docs/en/plugin-marketplaces).

## Generated files and licenses

The `plugin/` tree is replaced by the upstream PatentReply build. Make
methodology and plugin-manifest changes in that source build, then publish
the generated tree here. Keep setup documentation outside that tree.

The root license scopes MIT to files outside `plugin/`; the plugin manifest
declares the plugin proprietary. Preserve that scope when changing license
presentation. A standard license file for the plugin should be supplied by
the authoritative build rather than invented in this documentation repo.

Claude Code 2.1.310 validates the exported plugin manifest, while its
directory checks report a missing listing icon and privacy-policy URL.
Before a directory submission, add a square listing icon and
`privacyPolicyUrl` in the upstream plugin build, and include the marketplace
install instructions in its generated README. Re-export those changes here.

## Registry and directory publication

- Validate `server.json` against its declared schema. Its server description
  is limited to 100 characters; the longer GitHub About description is a
  separate field.
- Keep the release version and canonical endpoint aligned with the hosted
  release. Publish registry changes using the official registry's publisher
  workflow; committing `server.json` alone does not publish a listing.
- `glama.json` identifies the GitHub maintainer for the ownership claim flow.
  Complete that claim and check the resulting listing's connection path.
- Add links or listing badges after verifying that the corresponding public
  listing is live. Directory inclusion and endorsement are different things.

See the [MCP Registry publisher guide](https://github.com/modelcontextprotocol/registry/blob/main/docs/modelcontextprotocol-io/quickstart.mdx)
and [Glama ownership metadata](https://glama.ai/blog/2025-07-08-what-is-glamajson).

## Content and measurement

Keep pricing facts aligned with the product pricing page, and date client
setup checks when platform menus change. Use a verified public record for
any future screenshot or worked case; keep this repo's prompt walkthrough
distinct from captured case results.

Track GitHub visitors and clones, referrals to the product, successful
connections, and first completed compilations. Use those measures to
evaluate discovery and onboarding changes. Use the website for broader
product and workflow pages, with a reciprocal link to the public repository.
