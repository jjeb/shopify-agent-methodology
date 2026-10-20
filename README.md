# Shopify Agent Methodology

Role-based agent methodology for building, operating, reviewing, and growing
Shopify stores with the official Shopify AI Toolkit.

Repository: [github.com/jjeb/shopify-agent-methodology](https://github.com/jjeb/shopify-agent-methodology)

This project adds role coordination, safety boundaries, handoffs, and evidence
requirements around Shopify's official tools. It does not replace Shopify's
AI Toolkit, developer documentation, schema validation, or Shopify CLI.

## Quick start

Install the six MVP roles globally for your agent:

```bash
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a claude-code -y
npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a pi -y
```

Install Shopify's official toolkit separately when it is not already available:

```bash
npx skills add Shopify/Shopify-AI-Toolkit --skill shopify
```

Initialize the agent without authenticating or changing a store:

```text
Initialize the Shopify Agent Methodology for this project. Confirm that the
Shopify Expert, Architect, Developer, Data Engineer, Store Operator, and
Reviewer roles are available. Confirm that the official Shopify skill is also
available. Do not authenticate or change a store yet. Report missing skills or
dependencies clearly.
```

Then start with a read-only development-store request:

```text
Use shopify-expert for a development-store pilot. First inspect the named
store read-only and confirm the exact environment. Then propose the smallest
reversible theme or app change. Route architecture, implementation, review,
and store operations explicitly. Do not publish, mutate production, or claim
success without readback evidence.
```

See [Getting Started](docs/getting-started.md) for complete installation,
initialization, authentication, and first-workflow instructions.

## What this package provides

The package helps an agent decide who should work on a request, what
information is missing, what can run in parallel, what must be validated, and
when a live-store action is safe to perform.

| Role | Primary responsibility |
| --- | --- |
| `shopify-expert` | Coordinate requests, route roles, enforce lifecycle and evidence boundaries. |
| `shopify-architect` | Define the solution boundary, Shopify surface, dependencies, scopes, and rollout. |
| `shopify-developer` | Implement apps, themes, storefronts, APIs, webhooks, extensions, Functions, and configuration. |
| `shopify-data-engineer` | Design operational data workflows, imports, bulk operations, synchronization, reconciliation, and rollback. |
| `shopify-store-operator` | Perform approved named-store inspection, preview, maintenance, and store-scoped operations. |
| `shopify-reviewer` | Independently review code, schemas, permissions, security, performance, tests, release readiness, and evidence. |

The six-role MVP does not yet include dedicated analytics, platform, storefront,
extension, app-specialist, or commerce-strategy roles. See the [backlog](docs/BACKLOG.md)
for the deferred role roadmap.

## Role routing examples

| Request | Primary role | Supporting roles |
| --- | --- | --- |
| New app or integration | `shopify-developer` | Architect, Reviewer |
| Theme or storefront change | `shopify-developer` | Architect, Reviewer, Store Operator |
| Bulk import or synchronization | `shopify-data-engineer` | Reviewer, Store Operator |
| Read-only store inspection | `shopify-store-operator` | Expert, Reviewer when making a readiness claim |
| Release or safety decision | `shopify-reviewer` | Relevant implementation and operator roles |
| ShopifyQL reporting | Future `shopify-analytics` role | Expert; keep separate from operational data engineering |

The usual coordinated sequence is:

```text
shopify-expert
  → shopify-architect
  → shopify-developer and/or shopify-data-engineer
  → shopify-reviewer
  → shopify-store-operator
```

Independent discovery or local preparation may run in parallel only when there
are no shared mutable targets or unfinished dependencies. Publishing,
destructive writes, migrations, conflicting theme edits, review, and readback
remain coordinated and sequential. See the [coordination guide](docs/methodology/coordination.md).

## Evaluation and run summaries

For a first pilot, run the read-only scenario before any preview or mutation.
Use the [evaluation scenarios](docs/evaluations/store-pilot-scenarios.md) and
the [copy-ready run-log prompt](docs/evaluations/run-log.md) to collect a small,
sanitized summary in the client/store repository.

The methodology currently uses manual, local summaries rather than hidden
telemetry. Measure role routing, handoff completeness, safety-gate compliance,
human corrections, validation, readback, and final outcome before investing in
structured metrics collection.

## Safety boundaries

- A proposal is not an implementation.
- A local change is not a deployment.
- A deployment is not proof of a live-store state.
- A successful command is not proof that the intended resource changed.
- Live mutations require a named store, explicit scope, authorization, and readback evidence.
- Credentials, access tokens, and unnecessary customer data must not appear in source, logs, prompts, or handoffs.
- Unverified requirements should be marked `needs-review`, not silently passed.

## Documentation

- [Getting Started](docs/getting-started.md): install, initialize, authenticate, and run the first safe workflow.
- [Role matrix](docs/methodology/role-matrix.md): responsibilities and boundaries for each MVP role.
- [Lifecycle](docs/methodology/lifecycle.md): proposal through operation and evidence expectations.
- [Coordination](docs/methodology/coordination.md): routing, parallel-safe work, join gates, and coordination packets.
- [Development-store pilot](docs/methodology/store-pilot.md): safe pilot boundaries.
- [Workflow diagram](docs/workflows/shopify-lifecycle.md): Mermaid lifecycle and role flow.
- [Examples](docs/examples/): copy-ready role and workflow examples.
- [Evaluation scenarios](docs/evaluations/): behavioral pressure tests and run-log guidance.
- [Backlog](docs/BACKLOG.md): mission, vision, deferred roles, and future work.

## Validation

Run the repository checks before proposing changes:

```bash
bash scripts/validate-skills.sh
bash scripts/validate-repository-docs.sh
bash scripts/validate-methodology.sh
bash scripts/validate-evaluation-scenarios.sh
bash scripts/validate-role-documentation.sh
bash scripts/validate-coordination.sh
git diff --check
```

For the official Agent Skills specification check:

```bash
python -m venv .venv
.venv/bin/python -m pip install \
  "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
bash scripts/validate-skills-standard.sh
```

GitHub Actions runs the validation and documentation checks for pushes and
pull requests to `main`.

## Repository layout

```text
skills/                         Installable skill sources
docs/getting-started.md         Installation, initialization, and authentication
docs/methodology/               Lifecycle, contracts, handoffs, and coordination
docs/workflows/                 Mermaid lifecycle and role workflows
docs/examples/                  Copy-ready role and workflow examples
docs/evaluations/               Development-store scenarios and run logs
docs/BACKLOG.md                 Mission, vision, deferred roles, and future work
docs/specs/                     Product and methodology design specifications
docs/plans/                     Implementation plans
scripts/                        Repository and skill validation scripts
```

## Shopify references

- [Shopify AI Toolkit](https://shopify.dev/docs/apps/build/ai-toolkit)
- [Shopify CLI](https://shopify.dev/docs/api/shopify-cli)
- [Shopify auth login](https://shopify.dev/docs/api/shopify-cli/general-commands/auth-login)
- [Shopify store auth](https://shopify.dev/docs/api/shopify-cli/store/store-auth)
- [Shopify store execute](https://shopify.dev/docs/api/shopify-cli/store/store-execute)
