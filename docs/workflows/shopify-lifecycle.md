# Shopify Agent Workflow

Use this workflow for requests that span more than one Shopify role. It keeps
the agent's responsibility, lifecycle state, and approval boundary visible.

```mermaid
flowchart LR
    A[Merchant goal] --> B[shopify-expert\nclarify target and scope]
    B --> C[shopify-architect\nchoose surface and rollout]
    C --> D{Work type}
    D -->|Code or configuration| E[shopify-developer\nimplement locally]
    D -->|Operational data| F[shopify-data-integration-engineer\ndesign flow and reconciliation]
    D -->|Store inspection or preview| G[shopify-store-operator\nread-only or reversible action]
    D -->|Analytics or ShopifyQL| H[Analytics workflow\nseparate from operational data]
    E --> I[Validate with official toolkit and CLI]
    F --> I
    G --> I
    H --> I
    I --> J[shopify-reviewer\nindependent readiness review]
    J --> K{Approved and authorized?}
    K -->|No| L[Return needs-review\nwith owner and next action]
    K -->|Yes| M[shopify-store-operator\nexecute named-store action]
    M --> N[Read back and report evidence]
    N --> O[Measure and improve]
```

## How to apply it

1. Start at `proposed` with a named project/store target and desired outcome.
2. Let the architect choose the smallest appropriate Shopify surface.
3. Run independent discovery or review work in parallel only when it cannot
   mutate shared state.
4. Keep implementation, approval, publishing, and live mutations sequential.
5. Move to the next lifecycle state only with the evidence described in
   [lifecycle.md](../methodology/lifecycle.md).
6. Use the [handoff record](../methodology/handoff-record.md) at every role
   transition.

## Safety boundary

The diagram shows possible routing, not automatic permission. A preview is not
a publication, a deployment is not proof of live state, and a successful
command is not proof that the intended resource changed.
