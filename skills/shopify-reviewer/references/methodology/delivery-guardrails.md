# Delivery-First Guardrails

These guardrails keep the role system focused on the merchant's requested
outcome. Methodology, evaluation, and role coordination are support work; they
are not the outcome unless the user explicitly asks for methodology work.

## Primary outcome rule

Before selecting roles, write a short delivery brief:

- **Outcome:** what the user or store should be able to do.
- **First visible deliverable:** the smallest artifact or behavior that proves
  progress.
- **Environment:** local project, development store, preview, staging, or
  production.
- **Setup required:** only the dependencies or access needed for the first
  deliverable.
- **Stop condition:** the evidence that makes the next decision useful.
- **Success evidence:** tests, preview output, readback, or other direct proof.

If the first visible deliverable is unclear, stay in discovery and ask the
smallest question that resolves it. Do not expand the role system to avoid
making that decision.

## Minimum-role routing

Select only roles required for the current outcome. A broad request does not
automatically require every role.

- Use `shopify-expert` for framing and coordination.
- Add `shopify-architect` only when the Shopify surface, ownership,
  permissions, or rollout is unclear.
- Add `shopify-developer` for local code or configuration.
- Add `shopify-data-integration-engineer` for operational data movement or reconciliation.
- Add `shopify-store-operator` when a named store must be inspected or changed.
- Add `shopify-reviewer` when the risk or claim requires independent review.

Parallelize independent discovery or review only. Keep implementation,
authorization, publishing, and live mutations sequential.

## Setup budget and delivery checkpoint

Allow at most one setup or methodology task before product or store progress.
The next task must produce one of the following:

- a working local slice;
- a development-store readback;
- an unpublished preview;
- a validated data contract with a runnable test; or
- another artifact directly exercising the requested outcome.

Do not add generic scripts, role refinements, evaluation infrastructure, or
reference material before this checkpoint unless the work addresses an
immediate security, credential, data-loss, or production-risk blocker.

Two consecutive methodology-only tasks require a human checkpoint. The
coordinator must report what was deferred, why it is a blocker, and the next
smallest delivery action instead of dispatching another support task.

## Vertical-slice rule

For migrations, new stores, and broad features, choose one end-to-end slice
before expanding the foundation. The slice should exercise the highest-risk
boundary and be independently reviewable.

For example, a storefront migration should first prove one product page,
variant selection, native cart behavior, checkout handoff, and the appropriate
preview or readback evidence. It should not begin with a complete generic
theme system, every content page, or release automation.

## Recursion stop

Do not build or refine tools whose primary purpose is to validate the
methodology, the validators, or the role package while a product outcome is
waiting. Record the idea in the GitHub Issues roadmap and continue delivery.

Stop only for an immediate risk involving credentials, data loss, production
impact, unsafe authorization, or an inability to establish the target
environment. A failing check must be understood and reported; it does not
automatically justify expanding the validation system.

## Proportional review

Match review effort to risk:

| Work | Minimum review |
| --- | --- |
| Wording or link change | Author self-review and link/check validation |
| Small isolated script or role change | Focused test plus one review |
| Local implementation | Tests, relevant official validators, and focused review |
| Store mutation or broad data change | Exact target, authorization, rollback plan, independent review, and readback |
| Production publication or release claim | Full readiness review and explicit release authorization |

Do not apply a production-grade review loop to low-risk documentation while
leaving the actual store flow untested.

## Evidence and status

Every handoff must state the current lifecycle state, completed evidence,
unresolved risks, and next owner. A command being issued is not proof of a
change; a successful deployment is not proof of the live state; and a plan is
not an implementation.

Use `needs-review` or `partial` when a required evidence boundary has not been
completed. Use `blocked` only when a concrete external dependency prevents the
next safe action. Never mark a workflow complete because its supporting
methodology is complete.

## Decision flow

```text
Define outcome and first visible deliverable
        |
        v
Select minimum roles and one setup task at most
        |
        v
Produce a vertical slice or direct evidence
        |
        +--> blocked by safety/target ambiguity? stop and ask
        |
        v
Review according to risk and expand only with evidence
```
