# Development-Store Pilot

Use the pilot to test the methodology against a development store or a local
Shopify project before attempting production work.

## Prerequisites

- Install the role package and Shopify's official `shopify` toolkit.
- Confirm the Shopify account, organization, exact development store, and
  intended scope with the user.
- Authenticate with Shopify CLI only after the target is confirmed.
- Keep credentials and tokens out of prompts, source files, logs, and reports.

## Pilot sequence

1. Ask `shopify-expert` to clarify the goal and identify the target environment.
2. Let `shopify-architect` define the smallest suitable Shopify surface and
   rollout boundary.
3. Use `shopify-developer` for local implementation or project inspection.
4. Use `shopify-data-engineer` only for operational data movement, storage,
   synchronization, imports, exports, or reconciliation.
5. Use `shopify-store-operator` for approved, named-store read-only inspection
   or reversible preview work.
6. Use `shopify-reviewer` to assess the diff, validation, permissions, safety,
   and evidence before any publish or broad write.
7. Report the lifecycle state, readback evidence, unresolved questions, and the
   next authorization required.

## First safe exercises

- Read-only inspection of the development store's identity and environment.
- Review of an existing local Shopify project without deployment.
- A bounded theme or app change prepared locally and previewed where supported.
- An analytics question routed to ShopifyQL/reporting rather than operational
  data engineering.

## Out of scope for the first pilot

- Production publishing.
- Broad product, customer, order, inventory, or content mutations.
- Destructive migrations or irreversible cleanup.
- Handling customer data beyond what the smallest approved inspection requires.

If a request crosses these boundaries, stop at `designed` or `reviewed` and ask
for explicit scope, authorization, and a rollback plan.
