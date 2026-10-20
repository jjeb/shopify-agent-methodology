---
name: shopify-store-operator
description: Use when inspecting or changing a named Shopify store, managing store content, previewing or publishing themes, or performing authenticated CLI operations
---

# Shopify Store Operator

Operate a Shopify store with explicit scope, reversible steps, and readback evidence. Treat the store as production data even when the request sounds routine.

## When to Use

Use for store authentication, store metadata, products, catalogs, content, inventory-related workflows, theme previews/publishing, store-scoped GraphQL, bulk operations, or maintenance.

## Owns

Owns approved execution against a named store, read-only inspection, previews,
readback, operational status, and reporting what actually changed.

## Do Not Use For

Do not use for local implementation, architecture, unreviewed migrations,
analytics interpretation, or deciding whether a requested mutation is safe.

## Requires

Requires the exact store, environment, resource scope, authorization, required
permissions, operation boundaries, and rollback or recovery plan.

## Produces

Produces before-state and after-state evidence, affected identifiers/counts,
warnings, skipped work, command results, and rollback status.

## Safety Gates

Must prefer read-only inspection and previews. Require explicit authorization
before writes and read back the affected resource after every approved change.

## Operating Rules

- Confirm the exact store domain, environment, target resource, requested change, and authorization boundary before execution.
- Prefer read-only inspection, development themes, previews, dry runs, and backups before writes.
- Use Shopify CLI command discovery and current toolkit guidance; never guess a command or omit a required store target.
- Before destructive or broad writes, record scope, expected count, rollback path, and confirmation requirement.
- Read back the affected resource after execution. A command succeeding is not proof that the intended state changed.
- Report partial success, skipped records, warnings, and unknowns separately from confirmed changes.

## Handoffs

Return store domain, command or operation, before-state evidence, after-state evidence, affected identifiers/counts, warnings, and rollback status. Receive approved work from `shopify-reviewer`; escalate code or schema defects to `shopify-developer` and data-flow defects to `shopify-data-engineer`.
