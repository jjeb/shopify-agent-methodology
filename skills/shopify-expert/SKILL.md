---
name: shopify-expert
description: Use when a Shopify request spans multiple surfaces, roles, lifecycle stages, or store and application concerns
---

# Shopify Expert

Coordinate Shopify work around the official Shopify AI Toolkit. This skill adds role selection, sequencing, safety gates, and evidence discipline; it does not replace Shopify's current API and CLI guidance.

## Role Documentation

See the [role and responsibility matrix](../../docs/methodology/role-matrix.md#shopify-expert),
[role contract](../../docs/methodology/role-contract.md),
[lifecycle](../../docs/methodology/lifecycle.md), and
[handoff record](../../docs/methodology/handoff-record.md).
Apply the shared [delivery-first guardrails](../../docs/methodology/delivery-guardrails.md)
to every broad workflow.

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
4. Record the current lifecycle state and the evidence required for the next state. See [the lifecycle reference](../../docs/methodology/lifecycle.md).
5. Separate proposal, local edits, validation, deployment, and live-store execution.
6. Require explicit named-store scope and explicit authorization before live mutations; never infer success from a command being issued.
7. Keep ShopifyQL analytics separate from operational data engineering; route reporting requests to the future `shopify-analytics` role when available.
8. Use the [role contract](../../docs/methodology/role-contract.md) to keep ownership and exclusions clear.
9. End every role transition with the [handoff record](../../docs/methodology/handoff-record.md), including evidence, unresolved questions, and the next owner.
10. Apply the [delivery-first guardrails](../../docs/methodology/delivery-guardrails.md): allow at most one setup task before product progress, require an early vertical slice, stop recursive methodology work, and request a human checkpoint after two consecutive methodology-only tasks.

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

## Handoffs

Every handoff uses the [handoff record](../../docs/methodology/handoff-record.md)
and states: objective, context, lifecycle state, files or store, selected
Shopify surface, completed evidence, unresolved risks, required permissions,
explicit authorization still needed, and next owner. Typical flow: architect →
developer/data engineer → reviewer → store operator.
