# Shopify Role and Responsibility Matrix

This is the canonical responsibility reference for the six installable MVP
roles. Each role's `SKILL.md` provides operating instructions; this matrix
defines the ownership boundary and expected handoff.

## shopify-expert

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

**Owns:** solution boundaries, Shopify surface selection, alternatives,
dependencies, data ownership, permissions, and rollout design.

**Responsibilities:** choose among apps, themes, storefronts, extensions,
Functions, integrations, CLI workflows, and store configuration; define the
smallest useful implementation slice before optional foundation work; and
identify validation, rollback, and release gates.

**Does not own:** implementation code, named-store execution, or aggregate
analytics interpretation.

**Handoff:** a solution brief for `shopify-developer` or
`shopify-data-engineer`, with `shopify-reviewer` requested when readiness is at
stake.

## shopify-developer

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

## shopify-data-engineer

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
