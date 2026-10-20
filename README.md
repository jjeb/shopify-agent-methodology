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

- `shopify-expert`: coordinates multi-role work.
- `shopify-architect`: chooses the right Shopify surfaces and delivery shape.
- `shopify-developer`: implements apps, themes, storefronts, extensions, Functions, and integrations.
- `shopify-data-engineer`: designs operational data models, bulk work, imports, webhooks, and synchronization. ShopifyQL analytics is deferred to a future `shopify-analytics` skill.
- `shopify-store-operator`: performs safe store-context workflows and maintenance.
- `shopify-reviewer`: checks correctness, security, requirements, and release evidence.

## Requirements

- An agent supported by the [`skills` CLI](https://github.com/vercel-labs/skills).
- Node.js compatible with the installed `skills` CLI and Shopify CLI.
- Shopify CLI when the task requires scaffolding, previewing, validation, deployment, or authenticated store operations.
- The official Shopify AI Toolkit for current Shopify-specific documentation and validation.

See Shopify's [AI Toolkit documentation](https://shopify.dev/docs/apps/build/ai-toolkit) and [Shopify CLI requirements](https://shopify.dev/docs/api/shopify-cli).

## Setup TODO: install and authenticate

Complete this checklist before asking an agent to perform authenticated Shopify work:

- [ ] Install a supported Node.js version and package manager.
- [ ] Install or update Shopify CLI:

  ```bash
  npm install -g @shopify/cli@latest
  shopify version
  ```

- [ ] Install this role package locally or globally using the commands below.
- [ ] Install Shopify's official toolkit if it is not already available:

  ```bash
  npx skills add Shopify/Shopify-AI-Toolkit --skill shopify
  ```

- [ ] Sign in to the Shopify account or Partner account used for development:

  ```bash
  shopify auth login
  ```

- [ ] Confirm the correct account, organization, permissions, and target store before any store work.
- [ ] For store-scoped CLI operations, authenticate the specific store and request only the scopes needed:

  ```bash
  shopify store auth \
    --store <store>.myshopify.com \
    --scopes <comma-separated-scopes>
  ```

- [ ] Verify the store context with a read-only command before writing:

  ```bash
  shopify store info --store <store>.myshopify.com
  ```

- [ ] Start with read-only queries or previews. `shopify store execute` requires `--allow-mutations` before it can run mutations.
- [ ] Never place passwords, access tokens, or secrets in this README, source code, prompts, logs, or committed files.
- [ ] If switching accounts, use `shopify auth logout` and authenticate again.

Authentication is context-dependent: account login, store authentication, app credentials, Theme Access passwords, and storefront public tokens are not interchangeable. Use the authentication method required by the specific Shopify surface and follow the current official documentation. See [Shopify auth login](https://shopify.dev/docs/api/shopify-cli/general-commands/auth-login), [store auth](https://shopify.dev/docs/api/shopify-cli/store/store-auth), and [store execute](https://shopify.dev/docs/api/shopify-cli/store/store-execute).

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

### Global installation

```bash
npx skills add /Users/juanjesparza/src/github.com/shopify-consulting-roles --all -g
```

After this repository is public:

```bash
npx skills add <github-owner>/shopify-expert-skills --all -g
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

ShopifyQL reporting is not part of the current data-engineer role. Track it for the future `shopify-analytics` skill in [TODO.md](TODO.md). Keep analysis separate from record-level mutations.

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

The validator checks that all six MVP skills exist, have required frontmatter and sections, and that the future-role TODO remains present.

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
TODO.md                         Deferred roles and capability backlog
docs/                            Design and implementation records
```

Future roles and expansion tasks are tracked in [TODO.md](TODO.md).
