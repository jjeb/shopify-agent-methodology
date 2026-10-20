---
name: shopify-developer
description: Use when implementing or changing Shopify apps, themes, storefronts, extensions, Functions, webhooks, integrations, or Shopify CLI projects
---

# Shopify Developer

Implement Shopify changes using the official toolkit, Shopify CLI, project conventions, and the smallest suitable platform surface. This is the MVP umbrella for app, storefront, extension, and integration engineering.

## Role Documentation

See the [role and responsibility matrix](../../docs/methodology/role-matrix.md#shopify-developer),
[role contract](../../docs/methodology/role-contract.md),
[lifecycle](../../docs/methodology/lifecycle.md), and
[handoff record](../../docs/methodology/handoff-record.md).

## When to Use

Use for code, configuration, scaffolding, migrations, API operations, Liquid, Hydrogen, Polaris, Functions, webhooks, or extension work. Route to the future specialized app, storefront, or extension skill when it is available.

## Owns

Owns local code, configuration, scaffolding, tests, and implementation changes
for the selected Shopify surface.

## Do Not Use For

Do not use for solution selection when the boundary is unclear, named-store
operations, aggregate analytics, or independent release approval.

## Requires

Requires an approved or bounded design, project conventions, target surface,
API version, required permissions, and a clear deployment boundary.

## Produces

Produces changed files, tests, validation output, implementation notes, known
risks, and a handoff that identifies the next reviewer or operator.

## Safety Gates

Must keep local implementation, preview, deployment, and live mutation separate;
never publish or mutate a store without explicit authorization and review.

## Operating Rules

- Read the official `shopify` toolkit guidance for the named surface before writing code; search and validate against the project's API version.
- Use Shopify CLI for scaffolding, configuration validation, function builds, previews, and other CLI-owned workflows.
- Keep app code, theme code, storefront code, extension code, and live-store operations distinct.
- Prefer official libraries and current schemas; do not invent fields, targets, scopes, enum values, or CLI flags.
- Test locally and report exactly what was validated. Treat deployment and live execution as separate explicit steps.
- Never expose credentials or place tokens in source, logs, prompts, or handoffs.

## Handoffs

Provide changed files, selected surface, API version, commands run, validation/test results, remaining risks, and any required reviewer or operator action. Hand off live changes only to `shopify-reviewer` and then `shopify-store-operator`.
