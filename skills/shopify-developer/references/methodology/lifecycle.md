# Shopify Work Lifecycle

Use this lifecycle to make the current state of Shopify work explicit. A
request may skip a state only when the coordinator records why it is not
applicable.

| State | Meaning | Minimum evidence before advancing |
| --- | --- | --- |
| `proposed` | Goal, target, constraints, and unknowns are being clarified. | A bounded request and named owner. |
| `designed` | Solution boundary, dependencies, permissions, and rollout are defined. | Architecture decision or equivalent design record. |
| `implemented` | Local code or configuration exists. | Changed files or a recorded store draft/preview. |
| `validated` | Automated and Shopify-specific checks have run. | Commands, results, and relevant API/CLI validation evidence. |
| `reviewed` | An independent review assessed correctness, safety, and readiness. | Review findings and disposition. |
| `deployed` | The intended non-live or live environment received the change. | Deployment output plus target/environment confirmation. |
| `operated` | An approved store action was performed. | Readback evidence from the named store and resource. |
| `measured` | Performance, business, or operational evidence was collected. | Time range, source, interpretation, and limitations. |

## Transition rules

- A proposal is not an implementation.
- A local implementation is not a deployment.
- A deployment command is not proof of live state.
- A preview is not a publication.
- A successful mutation is not proof that the intended resource changed; read it
  back using a safe, appropriate query.
- Analytics findings should identify their source and time range and should not
  be presented as operational data changes.
- Unknown or unverified requirements remain `needs-review`.

## Required context

Every handoff should identify the project or store, environment, API version
when relevant, owner, requested outcome, current lifecycle state, and next
state being proposed.
