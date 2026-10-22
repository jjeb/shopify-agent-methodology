# `shopify-data-integration-engineer` migration

The canonical installable role formerly named `shopify-data-engineer` is now
named `shopify-data-integration-engineer`. This is a role-name clarification,
not a new capability or a second role.

## Compatibility mapping

Existing prompts that say:

```text
Use shopify-data-engineer for synchronization, imports, webhooks, bulk work,
reconciliation, or operational data flows.
```

should be interpreted as:

```text
Use shopify-data-integration-engineer for synchronization, imports, webhooks,
bulk work, reconciliation, or operational data flows.
```

The role still owns operational data integration and does not own ShopifyQL,
aggregate reporting, trends, conversion rates, or dashboard interpretation.
Route those requests through the separate analytics workflow and future
`shopify-analytics` candidate boundary.

## Installation and routing

- Install the renamed skill directly with:
  `npx skills add jjeb/shopify-agent-methodology --skill shopify-data-integration-engineer`.
- `npx skills add jjeb/shopify-agent-methodology --all` installs the six
  canonical MVP roles once each.
- Do not create or install a `shopify-data-engineer` alias. An alias would make
  `--all` install two competing roles with the same operational-data boundary.
- Update saved prompts, role selectors, handoff templates, and local routing
  configuration to the new name when convenient; the compatibility mapping
  above preserves intent for older prompt text.

## Scope and evidence

This document is the migration record for the breaking installable name. It
does not change role ownership, capability maturity, ShopifyQL boundaries, or
the GitHub Issues roadmap. Historical plans and specs retain their original
names and wording as historical records.
