# Shopify Agent Methodology

Role-based agent methodology for building, operating, reviewing, and growing Shopify stores with the official Shopify AI Toolkit.

Repository: [github.com/jjeb/shopify-agent-methodology](https://github.com/jjeb/shopify-agent-methodology)

Deferred roadmap work is tracked in the repository's [GitHub Issues](https://github.com/jjeb/shopify-agent-methodology/issues).

This project adds role coordination and development workflows around Shopify's toolkit; it does not replace Shopify's `shopify` skill, developer documentation, schema validation, or Shopify CLI.

The source package uses the portable `skills/` layout. The `npx skills` installer copies or links these skills into the target agent's supported directory.

## What this package provides

This package adds a practical team model around Shopify's platform capabilities. It helps an agent decide who should work on a request, what information is missing, what must be validated, and when a live-store action is safe to perform.

## Mission and vision

The mission is to make Shopify development, operations, and growth more
approachable without hiding platform complexity or encouraging unsafe live-store
changes. The long-term vision is a dependable, installable team of bounded
Shopify roles that can move work from a merchant goal through design,
implementation, validation, safe operation, review, and measurement while
remaining aligned with Shopify's official tools and documentation.

The role system should remain coordinated rather than becoming one oversized
skill: each role owns a clear boundary, produces useful handoffs, and preserves
evidence, authorization, and unresolved questions. Deferred capabilities and
future roles belong in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues).

It complements Shopify's official toolkit:

- Shopify's toolkit supplies current API, schema, validation, migration, and CLI guidance.
- These skills supply role boundaries, sequencing, handoffs, safety checks, and evidence requirements.
- The skills do not copy Shopify API reference material, invent API fields, or replace Shopify CLI.

## MVP skills

- `shopify-expert`: coordinates a Shopify request across roles, selects the smallest useful workflow, and enforces handoffs, approvals, and evidence boundaries.
- `shopify-architect`: owns discovery and solution design—choosing between apps, themes, Hydrogen, APIs, extensions, Functions, integrations, and store workflows before implementation begins.
- `shopify-developer`: implements Shopify application and storefront changes, including app code, Liquid, Hydrogen, APIs, webhooks, extensions, Functions, Polaris, configuration, and CLI-managed projects.
- `shopify-data-integration-engineer`: designs operational data systems—metafields/metaobjects, imports, bulk operations, webhooks, synchronization, external databases, migrations, and reconciliation. It does not own ShopifyQL analytics.
- `shopify-store-operator`: performs approved, authenticated store work such as read-only inspection, products/content workflows, theme previews, publishing, maintenance, and store-scoped CLI operations.
- `shopify-reviewer`: independently evaluates code, schemas, configuration, permissions, security, performance, tests, Shopify requirements, release readiness, and evidence for live changes.

The operational-data role is canonically named `shopify-data-integration-engineer`.
Existing prompts using `shopify-data-engineer` map to this role; see the
[role migration guide](docs/migrations/2026-10-22-data-integration-engineer-role-rename.md).
There is no legacy installable alias, so `--all` installs one operational-data
role rather than two competing roles.

## Capability maturity and platform coverage

The canonical [role matrix](docs/methodology/role-matrix.md) assigns every
installable role the role tag `core` and uses capability tags to distinguish
current ownership from evidence gaps in its capability maturity model:

- `core`: required baseline for the role;
- `supported`: documented and routable through an existing role;
- `experimental`: usable for bounded trials with limited evidence;
- `research-needed`: requires more evidence before promotion; and
- `future-specialist`: a non-installable candidate, never an automatic role.

The matrix records researched coverage for Admin GraphQL and app backends,
Storefront API/Liquid/Hydrogen, Admin/Checkout/Customer Account/POS/theme
extensions, Shopify Functions, webhooks/events, Shopify CLI/theme/app
workflows, ShopifyQL, and subscriptions/Markets/B2B/payments. The detailed
evidence brief is [roadmap issue #20](https://github.com/jjeb/shopify-agent-methodology/issues/20).
It does not add installable roles. Keep ShopifyQL and aggregate analytics
separate from operational data engineering; the latter owns synchronization,
reconciliation, and record-level data flows.

Maturity is a routing and evidence model, not a claim that a capability is
stable or available on every Shopify plan. Verify current platform behavior in
the official toolkit and documentation before implementation or live-store work.
Repository release/version rules are documented in
[`docs/versioning.md`](docs/versioning.md).

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
   already available. Follow [Getting Started](docs/getting-started.md) for
   the canonical installation commands, and do not install duplicate copies
   unnecessarily.

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

The detailed installation semantics live in [Getting Started](docs/getting-started.md).
Use these concise commands as the canonical reference:

### Local project installation

```bash
npx skills add . --all
```

Install the public package into the current project:

```bash
npx skills add jjeb/shopify-agent-methodology --all
```

### Global installation

Install all skills for all agents:

```bash
npx skills add jjeb/shopify-agent-methodology --all -g
```

Install all skills for Claude Code only:

```bash
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a claude-code -y
```

Install all skills for Pi only:

```bash
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a pi -y
```

`--all` installs all skills for all agents; use `--skill '*'` with `-a` when
restricting a global installation to one agent.

Install Shopify's official toolkit separately when it is not already available:

```bash
npx skills add Shopify/Shopify-AI-Toolkit --skill shopify
```

The official toolkit and this package can be installed side by side. Role skills should defer to the official `shopify` skill for current Shopify-specific API details.

## Delivery-first guardrails

The role system is designed to help deliver a store or product outcome, not
to create an ever-growing methodology project. `shopify-expert` applies the
shared [delivery-first guardrails](docs/methodology/delivery-guardrails.md):

- define the primary outcome and first visible deliverable;
- select only the minimum roles needed for the current step;
- allow at most one setup or methodology task before direct product or store
  progress (the methodology budget);
- prove a vertical slice before expanding broad foundations;
- stop recursive validation and request a human checkpoint after repeated
  methodology-only work; and
- scale review to risk, with strict authorization and readback for store
  mutations.

Use the evaluation scenarios in
[`docs/evaluations/store-pilot-scenarios.md`](docs/evaluations/store-pilot-scenarios.md)
to pressure-test routing, delivery sequencing, safety, and evidence claims.

Copy-ready prompt:

```text
Use the Shopify role system with delivery-first guardrails. Start by stating
the primary outcome, first visible deliverable, environment, one setup task at
most, stop condition, and success evidence. Select only the minimum roles.
Prioritize one working vertical slice before optional methodology or generic
tooling. Stop recursive validation and ask for a human checkpoint after two
methodology-only tasks. Match review depth to risk, and require explicit
authorization plus readback for named-store mutations. Do not claim completion
without direct evidence.
```

### Keeping installation instructions current

The repository name and public installation examples are canonical. Do not add
personal absolute paths or placeholder repository names to this file. Run the
documentation check before committing README changes:

```bash
bash scripts/validate-repository-docs.sh
```

GitHub Actions runs this check so renamed repositories and stale installation
commands are caught during pull requests.

## How to work with the skills

For broad work, ask the agent to use `shopify-expert`:

```text
Use the Shopify Expert role system. Review this store and propose the safest way to add a subscription product flow. Do not change the live store yet.
```

The coordinator selects only the roles required by the current outcome. A
typical sequence is conditional rather than automatic:

```text
shopify-expert
  → architect when the surface or permissions are unclear
  → developer or `shopify-data-integration-engineer` when implementation or data work is required
  → reviewer when the risk or readiness claim requires independent review
  → store-operator when a named-store inspection or approved operation is required
```

Skip roles whose boundary does not apply. Preserve the delivery brief and
methodology-only task count in every [handoff record](docs/methodology/handoff-record.md).

For a first development-store pilot, use a bounded request such as:

```text
Use shopify-expert for a development-store pilot. First inspect the named
store read-only, identify the current environment, and propose the smallest
reversible theme or app change. Route architecture, implementation, review,
and store operations explicitly. Do not publish, mutate production, or claim
success without readback evidence.
```

The expected result is a lifecycle state, selected roles, a structured handoff,
validation evidence, unresolved questions, and the exact authorization still
required. See [the development-store pilot guide](docs/methodology/store-pilot.md).

See the [Mermaid Shopify lifecycle workflow](docs/workflows/shopify-lifecycle.md)
for the role sequence and [copy-ready examples](docs/examples/) for a
development-store preview and the analytics/operational-data boundary.

The complete pilot scenario set is in
[docs/evaluations/store-pilot-scenarios.md](docs/evaluations/store-pilot-scenarios.md).
Run the read-only scenario first. Only continue to a preview after the agent
has confirmed the exact development store and environment.

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
Use shopify-data-integration-engineer to design a webhook and bulk synchronization pipeline
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

Use the data integration engineer for source of truth, bulk strategy, webhook behavior, retries, reconciliation, and rollback. Use the reviewer before broad writes. Use the store operator only for approved named-store execution.

### Analyze store performance

ShopifyQL reporting is not part of the current `shopify-data-integration-engineer` role. Track it in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues) for the future `shopify-analytics` skill. Keep analysis separate from record-level mutations.

## Safety boundaries

- A proposal is not an implementation.
- A local change is not a deployment.
- A deployment is not proof of a live-store state.
- A successful command is not proof that the intended resource changed.
- Live mutations require a named store, explicit scope, authorization, and readback evidence.
- Credentials, access tokens, and unnecessary customer data must not appear in source, logs, prompts, or handoffs.
- Unverified requirements should be marked `needs-review`, not silently passed.

## Validation

Run the repository checks first:

```bash
bash scripts/validate-skills.sh
```

This checks that all six MVP skills exist, have the repository's required
sections, use matching directory and frontmatter names, and that the repository
roadmap pointer remains present. If `skills-ref` is installed, it also runs the official
Agent Skills validator automatically.

For explicit validation against the Agent Skills specification, install the
official reference validator in a virtual environment and run:

```bash
python -m venv .venv
.venv/bin/python -m pip install \
  "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
bash scripts/validate-skills-standard.sh
```

The official validator checks each `skills/<name>/` directory's `SKILL.md`
frontmatter, naming rules, supported fields, and required structure. It does
not prove that a role makes good decisions at runtime. Behavioral pressure
tests for routing, handoffs, safety gates, and evidence claims remain tracked
in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues).

GitHub Actions runs the skill, methodology, and evaluation checks for pushes
and pull requests to `main`.

It also checks the development-store evaluation scenarios:

```bash
bash scripts/validate-evaluation-scenarios.sh
```

## Repository layout

```text
skills/                         Installable skill sources
  shopify-expert/SKILL.md       Coordinator
  shopify-architect/SKILL.md    Solution design
  shopify-developer/SKILL.md    Implementation
  shopify-data-integration-engineer/        Operational data systems
  shopify-store-operator/       Named-store operations
  shopify-reviewer/             Quality and release review
scripts/validate-skills.sh      Structural validation
scripts/validate-skills-standard.sh  Official Agent Skills validation
scripts/validate-methodology.sh Shared methodology reference validation
scripts/validate-evaluation-scenarios.sh  Pilot pressure-scenario validation
scripts/validate-role-documentation.sh  Role responsibility-link validation
docs/methodology/               Lifecycle, contracts, handoffs, and pilot guide
docs/evaluations/               Development-store behavioral scenarios
docs/workflows/                 Mermaid lifecycle and role workflows
docs/examples/                  Copy-ready role and workflow examples
docs/history/README.md          Historical-document policy and roadmap boundary
docs/history/specs/              Completed design specifications
docs/history/plans/              Completed implementation plans
docs/migrations/                 Compatibility and migration guidance
docs/                            Maintainer and methodology documentation
  CONTRIBUTING.md                Maintainer and contributor guidance
docs/versioning.md               Versioning and release procedure
VERSION                         Coordinated package version
CHANGELOG.md                    Release history
```

Future roles and expansion tasks are tracked in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues); no local backlog file is maintained.
