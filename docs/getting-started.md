# Getting Started

This guide covers installation, initialization, authentication, and the first
safe development-store workflow. The role package complements Shopify's
official AI Toolkit; it does not replace Shopify documentation or grant store
access.

## Requirements

- An agent supported by the [`skills` CLI](https://github.com/vercel-labs/skills)
- Node.js compatible with the installed `skills` CLI and Shopify CLI
- Shopify CLI for scaffolding, previewing, validation, deployment, or store work
- Shopify's official `shopify` skill for current platform guidance

## Install the skills

Install the role package globally for Claude Code:

```bash
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a claude-code -y
```

Install globally for Pi:

```bash
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a pi -y
```

Install into the current project instead:

```bash
npx skills add jjeb/shopify-agent-methodology --all
```

Install Shopify's official toolkit separately when it is not already present:

```bash
npx skills add Shopify/Shopify-AI-Toolkit --skill shopify
```

Use `--skill '*'` when selecting a specific agent. The `--all` shorthand means
all skills for all agents, so combining it with `-a pi` or `-a claude-code` does
not restrict the installation to that agent.

The two packages are intended to work side by side. This repository supplies
role boundaries and coordination; the official toolkit supplies current
Shopify API, schema, validation, migration, and CLI guidance.

## Initialize an agent

After installation, ask the agent to confirm that it can see the skills before
asking it to use Shopify:

```text
Initialize the Shopify Agent Methodology for this project. Confirm that the
Shopify Expert, Architect, Developer, Data Integration Engineer, Store Operator, and
Reviewer roles are available. Confirm that the official Shopify skill is also
available. Do not authenticate or change a store yet. Report missing skills or
dependencies clearly.
```

For a project-specific setup, continue with:

```text
Use shopify-expert as the coordinator. Read the repository and identify the
project type, Shopify surface, target environment, required roles, missing
information, and safety constraints. Propose work only; do not mutate or
publish anything.
```

## Authenticate safely

Authentication is context-dependent: account login, store authentication, app
credentials, Theme Access passwords, and storefront public tokens are not
interchangeable.

```bash
shopify version
shopify auth login
shopify store auth --store <store>.myshopify.com \
  --scopes <comma-separated-scopes>
shopify store info --store <store>.myshopify.com
```

Before authentication, confirm the Shopify account, organization, exact target
store, environment, and intended scope. Start with read-only inspection,
development themes, previews, or dry runs. Store mutations require explicit
authorization for the exact operation and `--allow-mutations` where Shopify
CLI requires it.

Never print, commit, paste, or include passwords, access tokens, or unnecessary
customer data in source files, logs, prompts, or reports. Do not claim that
authentication or a store change succeeded without direct output and readback
evidence. See Shopify's [auth login](https://shopify.dev/docs/api/shopify-cli/general-commands/auth-login),
[store auth](https://shopify.dev/docs/api/shopify-cli/store/store-auth), and
[store execute](https://shopify.dev/docs/api/shopify-cli/store/store-execute)
documentation for current commands and requirements.

## First safe workflow

```text
Use shopify-expert for a development-store pilot. First inspect the named
store read-only and confirm the exact environment. Then propose the smallest
reversible theme or app change. Route architecture, implementation, review,
and store operations explicitly. Do not publish, mutate production, or claim
success without readback evidence.
```

Run the read-only scenario first. Continue to a preview only after the agent
has confirmed the exact development store and environment. Use the [pilot
guide](methodology/store-pilot.md), [workflow](workflows/shopify-lifecycle.md),
and [evaluation run log](evaluations/run-log.md) to record the result.
