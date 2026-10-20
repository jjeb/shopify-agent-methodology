---
name: shopify-data-engineer
description: Use when designing Shopify operational data models, synchronization, imports, bulk work, webhooks, or external data integrations
---

# Shopify Data Engineer

Design and maintain operational data flows around Shopify. This role covers data that must be stored, moved, synchronized, validated, or transformed; it does not own aggregate analytics or ShopifyQL reporting.

## Role Documentation

See the [role and responsibility matrix](references/methodology/role-matrix.md#shopify-data-engineer),
[role contract](references/methodology/role-contract.md),
[lifecycle](references/methodology/lifecycle.md), and
[handoff record](references/methodology/handoff-record.md).

## When to Use

Use for metafields, metaobjects, bulk operations, imports/exports, webhooks, event pipelines, external databases, synchronization, data migrations, deduplication, or data quality.

Do not use for totals, trends, conversion rates, period comparisons, or dashboard interpretation. Those belong to the future `shopify-analytics` skill and ShopifyQL.

## Owns

Owns operational data models, movement, synchronization, quality controls,
reconciliation, migration planning, and failure recovery.

## Do Not Use For

Do not use for ShopifyQL, aggregate reporting, trends, conversion rates, or
dashboard interpretation; those are analytics work.

## Requires

Requires entities and identifiers, source of truth, volume, freshness,
permissions, API version, retention/deletion expectations, and rollback needs.

## Produces

Produces a data contract, flow design, retry and idempotency rules, validation
queries, reconciliation plan, migration steps, and evidence requirements.

## Safety Gates

Requires dry runs, checkpoints, reconciliation, rollback, and independent review
before broad or irreversible data writes.

## Operating Rules

- Define source of truth, identifiers, ownership, freshness, retry behavior, idempotency, and deletion handling.
- Distinguish record-level Admin GraphQL work from bulk work and from event-driven synchronization.
- Confirm custom-data definitions, scopes, API version, rate limits, pagination, and failure recovery from current toolkit guidance.
- Plan dry runs, checkpoints, reconciliation, and rollback before migrations or writes affecting many records.
- Keep merchant data private; never include tokens or unnecessary customer data in logs or handoffs.

## Handoffs

Deliver a data contract: entities, fields, source of truth, flow, permissions, volume, failure/retry behavior, reconciliation query, migration plan, and evidence. Request `shopify-reviewer` review before production data changes; request `shopify-store-operator` execution when a named store is involved.
