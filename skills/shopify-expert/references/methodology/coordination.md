# Multi-Role Shopify Coordination

Use this guide when a request spans multiple Shopify surfaces or lifecycle
stages. The coordinator owns routing and join points; specialist roles own
their decisions and artifacts.

## Capability maturity in routing

Read the [canonical capability maturity model](role-matrix.md#capability-maturity-model)
before routing a researched platform surface. `core` and `supported` work may
follow the normal matrix. `experimental` work needs a bounded trial and
reviewer evidence. `research-needed` work stays explicit in the handoff, and
`future-specialist` is a candidate label only; it does not create or dispatch
a new installable role. Route ShopifyQL and aggregate analytics separately from
operational data engineering.

## Routing matrix

| Request signal | Primary role | Supporting roles | Default order |
| --- | --- | --- | --- |
| Unclear surface, scope, permissions, or rollout | `shopify-architect` | `shopify-expert`, `shopify-reviewer` | Expert → architect → reviewer |
| App, theme, storefront, extension, Function, or integration code | `shopify-developer` | `shopify-architect`, `shopify-reviewer` | Architect → developer → reviewer |
| Imports, exports, bulk operations, synchronization, or reconciliation | `shopify-data-engineer` | `shopify-architect`, `shopify-reviewer`, operator | Architect → data engineer → reviewer → operator |
| Named-store inspection or reversible preview | `shopify-store-operator` | `shopify-expert`, reviewer | Expert → operator → reviewer when readiness is claimed |
| ShopifyQL, totals, trends, or conversion analysis | Analytics workflow | `shopify-expert`, future `shopify-analytics` | Expert → analytics workflow |
| Publish, broad write, migration, or release claim | `shopify-reviewer` | owning implementer, operator | Implementer → reviewer → operator |

Select the smallest useful set. Do not add every role by default.

## Parallel-safe work

Work may run in parallel only when all of the following are true:

- the tasks have no shared mutable target;
- each task has a distinct owner and output;
- neither task depends on the other's unfinished decision;
- no task performs a live mutation; and
- the coordinator has recorded how outputs will be joined.

Examples of parallel-safe work include independently reviewing a local diff and
checking a documentation requirement, or analyzing two read-only data sources.

Never parallelize publishing, destructive writes, migrations, conflicting theme
edits, shared configuration changes, or actions whose target or authorization
has not been confirmed.

## Join gates

The coordinator must join parallel work before advancing the lifecycle:

1. **Design gate:** architecture decisions, scope, ownership, and permissions
   agree or the conflict is returned to `needs-review`.
2. **Implementation gate:** changed files and data artifacts have one owner and
   a reproducible validation path.
3. **Review gate:** the reviewer sees all relevant outputs, not only the fastest
   branch, and records a disposition.
4. **Operation gate:** the exact store, environment, scope, authorization,
   rollback, and readback plan are confirmed before a write.

Every parallel group records:

- `Dependencies`: upstream task IDs and required artifacts.
- `Branch status`: `pending`, `running`, `complete`, `blocked`, or
  `skipped-with-reason`.
- `Join outcome`: `accepted`, `conflict`, or `needs-review`.
- `Evidence`: outputs and checks from every branch, including failed or skipped
  work.

No lifecycle state advances until every required branch has completed with
evidence or has been explicitly marked not applicable. Conflicting or
incomplete results remain `needs-review`; the coordinator must not silently
choose a winner.

## Coordination packet

Use this packet to start a role or join its result:

```text
Request:
Lifecycle state:
Target project/store/environment:
Primary role:
Supporting roles:
Dependencies:
Parallel-safe tasks:
Shared mutable targets:
Join gate:
Expected artifact:
Required permissions/scopes:
Evidence required:
Known risks and unresolved questions:
Explicit authorization still required:
Next owner:
```

Each role returns the packet with its section completed. The coordinator must
preserve conflicts and missing fields instead of silently choosing a winner.
Every multi-role handoff also records branch status, join outcome, unresolved
conflicts, and next-state evidence in the handoff record.
