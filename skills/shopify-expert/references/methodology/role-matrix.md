# Shopify Role and Responsibility Matrix

This is the canonical responsibility reference for the six installable MVP
roles. Each role's `SKILL.md` provides operating instructions; this matrix
defines the ownership boundary and expected handoff.

## Capability maturity model

The role tag describes the lifecycle of a role; the capability tag describes
the evidence level for a capability owned or routed by that role.

### Role tags

- `core`: one of the six installable MVP roles. Core roles are the default
  routing surface and must remain bounded, installable, and documented.
- `future-specialist`: a candidate role only. It is not installable and must
  remain in the GitHub Issues roadmap until evidence supports a reviewed role
  contract and skill.

### Capability tags

- `core`: required for the role's current contract and default workflow.
- `supported`: documented and routable through an existing role, with usable
  validation or evidence expectations.
- `experimental`: supported for bounded trials, but coverage, tooling, or
  operational evidence is still limited.
- `research-needed`: a capability boundary or routing decision needs evidence
  before it should be promoted.
- `future-specialist`: a candidate capability that must not create a new
  installable role without a roadmap issue, pressure scenarios, and review.

Use one role tag and one or more capability tags per role. A capability may
move from `research-needed` or `experimental` to `supported` without adding a
role. Keep ShopifyQL and aggregate analytics separate from operational data
engineering at every maturity level.

## Platform-surface capability coverage

This is the current, researched routing baseline. The detailed research brief
and evidence questions are tracked in [roadmap issue #20](https://github.com/jjeb/shopify-agent-methodology/issues/20).

| Platform surface | Current owner | Capability tag | Future-specialist candidate | Required evidence |
| --- | --- | --- | --- | --- |
| GraphQL Admin API and app backends | `shopify-developer`, with `shopify-architect` for boundaries and `shopify-data-integration-engineer` for operational flows | `supported` | `shopify-app-engineer` | Repeated auth, scopes, versioning, backend reliability, and review burden |
| Storefront API, Liquid, and Hydrogen | `shopify-developer`, with `shopify-architect` for channel selection | `supported` | `shopify-storefront-engineer` | Repeated storefront depth, performance, accessibility, and preview evidence |
| Admin, Checkout, Customer Account, POS, and theme extensions | `shopify-developer`, `shopify-store-operator`, and `shopify-reviewer` at their existing boundaries | `experimental` | `shopify-extension-engineer` | Extension targets, plan limits, test/review failures, and maintenance burden |
| Shopify Functions | `shopify-developer`, with architect selection and reviewer release gates | `experimental` | `shopify-extension-engineer` | Function targets, contracts, builds, dev-store tests, limits, and failures |
| Webhooks and events | `shopify-developer` for endpoints; `shopify-data-integration-engineer` for sync, reconciliation, and recovery | `supported` | `shopify-platform-engineer` | Event contracts, retries, idempotency, reconciliation incidents, and operational burden |
| Shopify CLI, theme, and app workflows | `shopify-developer`, `shopify-store-operator`, and `shopify-reviewer` | `supported` | `shopify-platform-engineer` | Version compatibility, CI/environment failures, secrets, release, and rollback evidence |
| ShopifyQL and aggregate analytics | Analytics workflow, with `shopify-expert` routing; not `shopify-data-integration-engineer` | `research-needed` | `shopify-analytics` | Sanitized questions, metric definitions, source/time range, correctness, and privacy |
| Subscriptions, Markets, B2B, and payments | `shopify-architect` for boundaries; `shopify-developer`, `shopify-data-integration-engineer`, and `shopify-store-operator` within existing contracts | `research-needed` | `shopify-commerce-strategist` or a payments specialist | Eligibility, plan constraints, repeated workflows, errors, business decisions, and review burden |

The capability tags are routing and evidence markers, not product support
claims. Verify current Shopify behavior in the official toolkit and docs before
implementation or live-store work.

## shopify-expert

**Role tag:** `core`; **Capability tags:** `core`, `supported`,
`research-needed`, `future-specialist`

**Owns:** request framing, delivery sequencing, role selection, lifecycle
coordination, safety gates, and cross-role handoff completeness.

**Responsibilities:** identify the target, environment, primary outcome, first
visible deliverable, stop condition, and unknowns; select the smallest useful
role sequence; enforce the delivery-first guardrails; record lifecycle state;
preserve evidence and authorization requirements; and coordinate the next owner.

**Does not own:** specialist implementation, store execution, analytics
interpretation, or independent release approval.

**Handoff:** a role sequence and structured handoff record with current state,
evidence, unresolved questions, and next authorization.

## shopify-architect

**Role tag:** `core`; **Capability tags:** `core`, `supported`, `experimental`,
`research-needed`, `future-specialist`

**Owns:** solution boundaries, Shopify surface selection, alternatives,
dependencies, data ownership, permissions, and rollout design.

**Responsibilities:** choose among apps, themes, storefronts, extensions,
Functions, integrations, CLI workflows, and store configuration; define the
smallest useful implementation slice before optional foundation work; and
identify validation, rollback, and release gates.

**Does not own:** implementation code, named-store execution, or aggregate
analytics interpretation.

**Handoff:** a solution brief for `shopify-developer` or
`shopify-data-integration-engineer`, with `shopify-reviewer` requested when readiness is at
stake.

## shopify-developer

**Role tag:** `core`; **Capability tags:** `core`, `supported`, `experimental`,
`future-specialist`

**Owns:** local code, configuration, scaffolding, tests, and implementation
changes for the selected Shopify surface.

**Responsibilities:** implement the first useful slice of apps, themes,
storefronts, extensions, Functions, webhooks, integrations, and CLI-managed
projects using current official guidance; validate local work; report direct
delivery evidence before optional infrastructure; and separate preview from
deployment.

**Does not own:** unclear solution selection, named-store operations,
aggregate analytics, or independent release approval.

**Handoff:** changed files, tests, commands, validation output, known risks, and
the required reviewer or operator action.

## shopify-data-integration-engineer

**Role tag:** `core`; **Capability tags:** `core`, `supported`, `experimental`;
ShopifyQL and aggregate analytics remain `research-needed` outside this role.

**Owns:** operational data models, movement, synchronization, quality controls,
reconciliation, migration planning, and failure recovery.

**Responsibilities:** handle metafields, metaobjects, imports, exports, bulk
operations, webhooks, external systems, source-of-truth decisions,
idempotency, retries, and rollback.

**Does not own:** ShopifyQL, aggregate reporting, trends, conversion rates, or
dashboard interpretation; those are analytics responsibilities.

**Handoff:** a data contract and flow design with identifiers, permissions,
volume, failure behavior, reconciliation, migration, and evidence requirements.

## shopify-store-operator

**Role tag:** `core`; **Capability tags:** `core`, `supported`, `experimental`,
`research-needed`

**Owns:** approved execution against a named store, read-only inspection,
previews, readback, operational status, and reporting what actually changed.

**Responsibilities:** authenticate the confirmed target, inspect safely, run
approved previews or mutations, capture before/after evidence, report partial
success and warnings, and preserve rollback information.

**Does not own:** architecture, local implementation, unreviewed migrations,
analytics interpretation, or deciding that an ambiguous mutation is safe.

**Handoff:** store domain, environment, operation, affected identifiers/counts,
before/after evidence, warnings, and rollback status.

## shopify-reviewer

**Role tag:** `core`; **Capability tags:** `core`, `supported`, `experimental`,
`research-needed`, `future-specialist`

**Owns:** independent readiness assessment, finding severity, evidence quality,
approval status, and required follow-up.

**Responsibilities:** inspect diffs, configuration, schemas, permissions,
security, tests, performance, accessibility, deployment evidence, and rollback;
scale review depth to risk; then return `pass`, `needs-review`, or `fail`.

**Does not own:** implementation, store operation, or inventing Shopify API,
schema, permission, or CLI behavior.

**Handoff:** findings by severity, evidence, unresolved assumptions, required
fixes, and the next owner.

## Shared responsibility rules

- Every role uses the official Shopify toolkit and current documentation for
  volatile platform details.
- Every role preserves the lifecycle state and evidence needed by the next role.
- No role may infer authorization from a vague request or a successful command.
- Role boundaries may be expanded only through a reviewed change to this matrix,
  the affected skill, and a linked GitHub roadmap issue.
