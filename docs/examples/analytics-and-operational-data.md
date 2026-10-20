# Example: Analytics Versus Operational Data

This example protects the boundary between aggregate analytics and data
engineering.

## Analytics request

```text
Use the Shopify analytics workflow to compare conversion rate and net sales
between the last two complete months. State the date range, source, filters,
limitations, and interpretation. Do not update products, orders, customers, or
inventory.
```

Expected handling: route to the analytics workflow or future
`shopify-analytics` role. Do not route to `shopify-data-engineer` simply because
the request contains the word “data.”

## Operational-data request

```text
Use shopify-data-engineer to design a product synchronization flow from the
ERP into Shopify. Define the source of truth, identifiers, fields, webhook and
bulk strategy, idempotency, retries, reconciliation, permissions, dry run, and
rollback. Do not execute writes.
```

Expected handling: produce a data contract and flow design. Aggregate ShopifyQL
reporting is not part of this handoff.

## Review questions

- Is the request measuring or changing records?
- Is the time range and source explicit for analytics?
- Is the source of truth explicit for synchronization?
- Are permissions, dry runs, reconciliation, and rollback defined before writes?
