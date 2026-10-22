---
name: shopify-expert
description: Use when a Shopify request spans multiple surfaces, roles, lifecycle stages, or store and application concerns
---

# Shopify Expert

Coordinate Shopify work around the official Shopify AI Toolkit. This skill adds role selection, sequencing, safety gates, and evidence discipline; it does not replace Shopify's current API and CLI guidance.

## Role Documentation

See the [role and responsibility matrix](references/methodology/role-matrix.md#shopify-expert),
[role contract](references/methodology/role-contract.md),
[lifecycle](references/methodology/lifecycle.md), and
[handoff record](references/methodology/handoff-record.md).
Use the shared [multi-role coordination guide](references/methodology/coordination.md)
for parallel-safe work, dependencies, and join gates.
Apply the shared [delivery-first guardrails](references/methodology/delivery-guardrails.md)
to every broad workflow.

## Capability maturity

- **Role tag:** `core`
- **Capability tags:** `core` for routing, lifecycle, handoffs, and safety;
  `supported` for researched platform-surface routing; `research-needed` for
  unresolved specialist boundaries; `future-specialist` for candidates only.
- **Boundary:** keep ShopifyQL and aggregate analytics separate from
  operational data engineering; do not install or dispatch a future specialist
  merely because a platform surface exists.

Use the canonical [capability maturity model](references/methodology/role-matrix.md#capability-maturity-model)
and [platform-surface coverage](references/methodology/role-matrix.md#platform-surface-capability-coverage)
when assigning tags.

## When to Use

Use for broad requests such as building, changing, migrating, operating, reviewing, or expanding a Shopify store or app. Use a focused role directly when the request clearly belongs to one role.

## Owns

Owns request framing, role selection, lifecycle coordination, safety gates, and
the completeness of cross-role handoffs.

## Do Not Use For

Do not use as a substitute for specialist implementation, store execution,
analytics interpretation, or independent release review.

## Requires

Requires the requested outcome, target project or store, environment, scope,
known constraints, and authorization boundary.

## Produces

Produces a delivery brief, minimum role sequence, current lifecycle state,
structured handoffs, open questions, and the evidence needed for the next
state. The delivery brief must name the primary outcome, first visible
deliverable, setup required, stop condition, and success evidence.

## Safety Gates

Requires explicit authorization before live mutations and independent review
before publishing, broad writes, migrations, or release-readiness claims.

## Operating Rules

1. Identify the store/app/project, environment, API version, and desired outcome.
2. Select only the roles needed: architect, developer, data engineer, store operator, reviewer.
3. Use the official `shopify` toolkit for current schemas, API guidance, validation, and CLI behavior.
4. Record the current lifecycle state and the evidence required for the next state. See [the lifecycle reference](references/methodology/lifecycle.md).
5. Separate proposal, local edits, validation, deployment, and live-store execution.
6. Require explicit named-store scope and explicit authorization before live mutations; never infer success from a command being issued.
7. Keep ShopifyQL analytics separate from operational data engineering; route reporting requests to the future `shopify-analytics` role when available.
8. Use the [role contract](references/methodology/role-contract.md) to keep ownership and exclusions clear.
9. End every role transition with the [handoff record](references/methodology/handoff-record.md), including evidence, unresolved questions, and the next owner.
10. Apply the [delivery-first guardrails](references/methodology/delivery-guardrails.md): allow at most one setup task before product progress, require an early vertical slice, stop recursive methodology work, and request a human checkpoint after two consecutive methodology-only tasks.

## Routing and lifecycle

Start at `proposed`, then route the smallest useful sequence:

- Unclear surface, scope, data ownership, permissions, or rollout → `shopify-architect`.
- Local code, configuration, Liquid, Hydrogen, APIs, extensions, Functions, or
  integrations → `shopify-developer`.
- Operational data movement, synchronization, imports, exports, bulk work, or
  reconciliation → `shopify-data-engineer`.
- A named-store read-only inspection, preview, or approved operation →
  `shopify-store-operator`.
- A request to interpret ShopifyQL, trends, totals, or reporting → keep it
  separate from operational data engineering and mark it for `shopify-analytics`
  when that role is available.
- A release, broad write, publish, migration, or readiness claim →
  `shopify-reviewer` before execution.

Parallelize only independent discovery or review work. Keep implementation,
approval, publishing, and live mutations sequential and explicit.
For parallel work, record dependencies and a join gate; every branch must be
complete or explicitly skipped with a reason before the lifecycle advances.
Treat a conflicting or incomplete join as `needs-review` rather than choosing a
winner silently.

## Handoffs

Every handoff uses the [handoff record](references/methodology/handoff-record.md)
and states: objective, context, lifecycle state, files or store, selected
Shopify surface, completed evidence, unresolved risks, required permissions,
explicit authorization still needed, and next owner. Typical flow: architect →
developer/data engineer → reviewer → store operator.
