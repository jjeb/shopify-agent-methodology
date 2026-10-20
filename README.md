# Shopify Expert Skills

Role-based skills for building, operating, reviewing, and growing Shopify stores with the official Shopify AI Toolkit.

This project adds role coordination around Shopify's toolkit; it does not replace Shopify's `shopify` skill, developer documentation, schema validation, or Shopify CLI.

The source package uses the portable `skills/` layout. The `npx skills` installer copies or links these skills into the target agent's supported directory.

## What this package provides

This package adds a practical team model around Shopify's platform capabilities. It helps an agent decide who should work on a request, what information is missing, what must be validated, and when a live-store action is safe to perform.

It complements Shopify's official toolkit:

- Shopify's toolkit supplies current API, schema, validation, migration, and CLI guidance.
- These skills supply role boundaries, sequencing, handoffs, safety checks, and evidence requirements.
- The skills do not copy Shopify API reference material, invent API fields, or replace Shopify CLI.

## MVP skills

- `shopify-expert`: coordinates a Shopify request across roles, selects the smallest useful workflow, and enforces handoffs, approvals, and evidence boundaries.
- `shopify-architect`: owns discovery and solution design—choosing between apps, themes, Hydrogen, APIs, extensions, Functions, integrations, and store workflows before implementation begins.
- `shopify-developer`: implements Shopify application and storefront changes, including app code, Liquid, Hydrogen, APIs, webhooks, extensions, Functions, Polaris, configuration, and CLI-managed projects.
- `shopify-data-engineer`: designs operational data systems—metafields/metaobjects, imports, bulk operations, webhooks, synchronization, external databases, migrations, and reconciliation. It does not own ShopifyQL analytics.
- `shopify-store-operator`: performs approved, authenticated store work such as read-only inspection, products/content workflows, theme previews, publishing, maintenance, and store-scoped CLI operations.
- `shopify-reviewer`: independently evaluates code, schemas, configuration, permissions, security, performance, tests, Shopify requirements, release readiness, and evidence for live changes.

## Requirements

- An agent supported by the [`skills` CLI](https://github.com/vercel-labs/skills).
- Node.js compatible with the installed `skills` CLI and Shopify CLI.
- Shopify CLI when the task requires scaffolding, previewing, validation, deployment, or authenticated store operations.
- The official Shopify AI Toolkit for current Shopify-specific documentation and validation.

See Shopify's [AI Toolkit documentation](https://shopify.dev/docs/apps/build/ai-toolkit) and [Shopify CLI requirements](https://shopify.dev/docs/api/shopify-cli).

## Setup prompt: install and authenticate

Copy this prompt into an agent before asking it to perform authenticated Shopify work:

```text
Prepare this environment for Shopify development and authenticated store work.

1. Check that Node.js, a package manager, and Shopify CLI are available. If
   Shopify CLI is missing or outdated, install or upgrade it with the user's
   package manager, then verify with:

      shopify version

2. Install this role package and Shopify's official toolkit if they are not
   already available. Do not install duplicate copies unnecessarily.

      npx skills add jjeb/shopify-consulting-roles --all
      npx skills add Shopify/Shopify-AI-Toolkit --skill shopify

3. Ask me to confirm the Shopify account, organization, exact target store,
   environment, and intended scope before using store credentials.

4. Sign in to the intended Shopify or Partner account with:

      shopify auth login

5. For store-scoped CLI work, authenticate only the named store and request
   only the required Admin API scopes:

      shopify store auth --store <store>.myshopify.com \
        --scopes <comma-separated-scopes>

6. Verify the target with a read-only command before any write:

      shopify store info --store <store>.myshopify.com

7. Start with read-only queries, development themes, previews, or dry runs.
   Do not run mutations unless I explicitly authorize the exact operation.
   Shopify store execute mutations require --allow-mutations.

8. Never print, commit, paste, or include passwords, access tokens, or secrets
   in source files, logs, prompts, or reports. Do not claim authentication or
   a store change succeeded without direct command output and readback evidence.

9. If the account changes, stop and ask me to run shopify auth logout before
   authenticating again. Explain any missing dependency, permission, scope,
   or store context instead of guessing.
```

Authentication is context-dependent: account login, store authentication, app credentials, Theme Access passwords, and storefront public tokens are not interchangeable. See [Shopify auth login](https://shopify.dev/docs/api/shopify-cli/general-commands/auth-login), [store auth](https://shopify.dev/docs/api/shopify-cli/store/store-auth), and [store execute](https://shopify.dev/docs/api/shopify-cli/store/store-execute).

## Installation

### Local project installation

From this repository:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all
```

Install one skill only:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --skill shopify-expert
```

Install all MVP skills specifically for Claude Code:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -a claude-code
```

Install all MVP skills specifically for Pi:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -a pi
```

### Global installation

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -g
```

Install globally for Claude Code:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -g -a claude-code
```

Install globally for Pi:

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -g -a pi
```

After this repository is public:

```bash
npx skills add <github-owner>/shopify-expert-skills --all -g
```

For this public repository, the commands will be:

```bash
npx skills add jjeb/shopify-consulting-roles --all -g -a claude-code
npx skills add jjeb/shopify-consulting-roles --all -g -a pi
```

Install the future public package into the current project instead:

```bash
npx skills add <github-owner>/shopify-expert-skills --all
```

Install Shopify's official toolkit separately when the agent does not already have it:

```bash
npx skills add Shopify/Shopify-AI-Toolkit --skill shopify
```

The official toolkit and this package can be installed side by side. Role skills should defer to the official `shopify` skill for current Shopify-specific API details.

## How to work with the skills

For broad work, ask the agent to use `shopify-expert`:

```text
Use the Shopify Expert role system. Review this store and propose the safest way to add a subscription product flow. Do not change the live store yet.
```

The coordinator will normally use:

```text
shopify-expert
  → shopify-architect
  → shopify-developer and/or shopify-data-engineer
  → shopify-reviewer
  → shopify-store-operator
```

Focused examples:

```text
Use shopify-architect to decide whether this needs a theme change, an app,
a Checkout extension, or a Hydrogen storefront. List required APIs and permissions.
```

```text
Use shopify-developer to implement this Admin GraphQL integration. Read the
current toolkit guidance, use the project's API version, validate it, and do not deploy.
```

```text
Use shopify-data-engineer to design a webhook and bulk synchronization pipeline
for products and inventory. Define source of truth, idempotency, retries,
reconciliation, and rollback. Do not execute writes.
```

```text
Use shopify-store-operator to inspect the named development store, preview the
theme change, and report before-and-after evidence. Do not publish.
```

```text
Use shopify-reviewer to review this diff for Shopify schema correctness,
permissions, security, performance, tests, and release readiness. Return
pass, needs-review, or fail with actionable findings.
```

## Common workflows

### Build a new app

1. Architect defines the app surface, data ownership, scopes, webhooks, and rollout.
2. Developer scaffolds and implements with Shopify CLI and the official toolkit.
3. Data engineer designs custom data and synchronization when needed.
4. Reviewer checks code, configuration, security, schemas, tests, and release readiness.
5. Store operator performs approved named-store actions.

### Change a theme or storefront

Use the architect when the boundary between Liquid, a theme app extension, Storefront API, and Hydrogen is unclear. Use the developer for implementation, reviewer for Theme Check/performance/accessibility and diff review, and store operator for preview or publishing.

### Migrate or synchronize data

Use the data engineer for source of truth, bulk strategy, webhook behavior, retries, reconciliation, and rollback. Use the reviewer before broad writes. Use the store operator only for approved named-store execution.

### Analyze store performance

ShopifyQL reporting is not part of the current data-engineer role. Track it for the future `shopify-analytics` skill in [BACKLOG.md](BACKLOG.md). Keep analysis separate from record-level mutations.

## Safety boundaries

- A proposal is not an implementation.
- A local change is not a deployment.
- A deployment is not proof of a live-store state.
- A successful command is not proof that the intended resource changed.
- Live mutations require a named store, explicit scope, authorization, and readback evidence.
- Credentials, access tokens, and unnecessary customer data must not appear in source, logs, prompts, or handoffs.
- Unverified requirements should be marked `needs-review`, not silently passed.

## Validation

```bash
bash scripts/validate-skills.sh
```

The validator checks that all six MVP skills exist, have required frontmatter and sections, and that the future-role backlog remains present.

## Repository layout

```text
skills/                         Installable skill sources
  shopify-expert/SKILL.md       Coordinator
  shopify-architect/SKILL.md    Solution design
  shopify-developer/SKILL.md    Implementation
  shopify-data-engineer/        Operational data systems
  shopify-store-operator/       Named-store operations
  shopify-reviewer/             Quality and release review
scripts/validate-skills.sh      Structural validation
BACKLOG.md                      Deferred roles and capability backlog
docs/                            Design and implementation records
```

Future roles and expansion tasks are tracked in [BACKLOG.md](BACKLOG.md), which also contains a copy-ready prompt for future agents.
