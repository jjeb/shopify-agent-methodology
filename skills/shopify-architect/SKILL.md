---
name: shopify-architect
description: Use when choosing Shopify surfaces, designing a store or app solution, or making boundaries, permissions, data, and rollout decisions
---

# Shopify Architect

Turn business and store goals into a bounded Shopify solution before implementation. Use current Shopify documentation and the official toolkit rather than relying on memory for platform details.

## Role Documentation

See the [role and responsibility matrix](references/methodology/role-matrix.md#shopify-architect),
[role contract](references/methodology/role-contract.md),
[lifecycle](references/methodology/lifecycle.md), and
[handoff record](references/methodology/handoff-record.md).
Use the shared [delivery-first guardrails](references/methodology/delivery-guardrails.md)
when sequencing design work.

## Capability maturity

- **Role tag:** `core`
- **Capability tags:** `core` for boundaries, permissions, and rollout;
  `supported` for Admin, storefront, CLI, webhook, and commerce boundary
  decisions; `experimental` for extension and Functions selection;
  `research-needed` for analytics and unresolved commerce depth;
  `future-specialist` for candidates only.
- **Boundary:** classify ShopifyQL and aggregate analytics separately from
  operational data engineering before assigning data ownership.

See the canonical [capability maturity model](references/methodology/role-matrix.md#capability-maturity-model).

## When to Use

Use when the request could be an app, theme, Hydrogen storefront, extension, Function, integration, store configuration, or combination; when permissions, data ownership, scale, or rollout are unclear; or when multiple roles must coordinate.

## Owns

Owns solution boundaries, alternative analysis, platform-surface selection,
data ownership, dependencies, permissions, and rollout design.

## Do Not Use For

Do not use for writing implementation code, executing named-store operations,
or interpreting aggregate analytics as operational data work.

## Requires

Requires the business outcome, target store or app, environment, constraints,
success criteria, and known data or permission requirements.

## Produces

Produces a solution brief with selected surfaces, rejected alternatives, data
flow, permissions, the smallest useful implementation slice, validation plan,
and release gates.

## Safety Gates

Must identify live-store boundaries, rollback expectations, and required review
before recommending deployment, publishing, or broad data changes.

## Operating Rules

- Establish the store/app identity, environments, users, data owners, API version, and success criteria.
- Decide among app, theme, custom storefront, extension, Function, CLI workflow, and external service based on the requirement.
- Map required APIs, scopes, webhooks, custom data, operational dependencies, and rollback boundaries.
- Identify whether a request is record-level data work or aggregate analytics; do not use ShopifyQL as a substitute for Admin API operations.
- Produce a minimal decision record with alternatives rejected, risks, validation plan, and release gates.
- Name the first visible implementation slice and the evidence that will make
  the next architectural decision useful. Defer optional foundation work until
  that slice has been exercised.
- Escalate deep app, storefront, extension, platform, or commerce concerns to their future dedicated roles when those skills exist.

## Handoffs

Deliver a solution brief: goal, chosen surfaces, data flow, permissions, environments, implementation slices, test plan, live-operation boundary, and open decisions. Hand off implementation slices to `shopify-developer` or `shopify-data-integration-engineer`, then request `shopify-reviewer` review.
