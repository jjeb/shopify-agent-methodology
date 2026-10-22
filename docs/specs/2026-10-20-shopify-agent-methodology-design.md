# Shopify Agent Methodology Design

## Problem

Shopify's official tools provide the platform knowledge needed to build and
operate stores, apps, storefronts, extensions, data systems, and analytics.
An agent still needs a dependable way to decide which kind of work is being
requested, which role should own it, what must happen first, how work is handed
off, and when a live-store action is safe.

This repository should become a Shopify-focused agent methodology: a portable,
role-based operating model around Shopify's official toolkit. It should help a
person move from a merchant goal to a designed, implemented, reviewed,
operated, and measurable result without pretending that a prompt replaces
Shopify's current documentation or CLI.

## Goals

- Provide clear, discoverable roles with non-overlapping responsibilities.
- Cover the store and app lifecycle from discovery through improvement.
- Route a request to the smallest set of useful roles.
- Make handoffs and work products explicit enough for another agent to continue.
- Require stronger evidence and authorization as work approaches a live store.
- Give a person a safe development-store pilot workflow.
- Establish behavioral evaluations before expanding the role catalog.
- Keep the package installable across supported agent harnesses.

## Non-goals

- Replacing Shopify's official AI Toolkit, API reference, schema validators, or
  Shopify CLI.
- Copying volatile Shopify API details into this repository.
- Automatically mutating a merchant's store without explicit authorization.
- Creating a separate role for every Shopify feature before real usage proves
  that the boundary is useful.
- Treating a successful CLI command as proof that the intended live state exists.

## Operating model

The default lifecycle is:

```text
discover → architect → implement → validate → review → deploy/operate → measure → improve
```

The coordinator may skip stages only when it records why a stage is not
applicable. It may run independent discovery, data, or review work in parallel,
but writes and release decisions remain gated by the relevant owner and
reviewer.

### Work states

Every request and handoff should identify its current state:

1. `proposed`: the goal and constraints are being clarified.
2. `designed`: the solution boundary, dependencies, permissions, and rollout
   are agreed.
3. `implemented`: local code or configuration exists but is not necessarily
   validated or deployed.
4. `validated`: automated and platform-specific checks have run.
5. `reviewed`: an independent review has recorded findings and disposition.
6. `deployed`: an intended environment received the change.
7. `operated`: an approved store action was performed with readback evidence.
8. `measured`: analytics or operational evidence was collected and interpreted.

No state may be inferred from a plan, an attempted command, or an agent's
confidence. The next state requires evidence appropriate to that transition.

### Role contract

Each role must define:

- **Owns:** decisions and work products for which the role is accountable.
- **Use when:** concrete routing signals.
- **Do not use for:** nearby work owned by another role.
- **Requires:** context, authorization, environment, and prior artifacts.
- **Produces:** a structured result another role can consume.
- **Handoffs:** who receives the result and what remains unresolved.
- **Safety gates:** actions that require confirmation or independent review.

The six MVP roles remain:

| Role | Primary responsibility | Boundary |
| --- | --- | --- |
| `shopify-expert` | Coordinate and route work | Does not replace specialist decisions or platform docs |
| `shopify-architect` | Define solution boundaries and rollout | Does not implement or operate the store |
| `shopify-developer` | Implement code and configuration | Does not silently publish or mutate production |
| `shopify-data-engineer` | Build operational data flows | Does not own ShopifyQL or aggregate analytics |
| `shopify-store-operator` | Perform approved named-store work | Does not infer authorization or scope |
| `shopify-reviewer` | Independently assess readiness and evidence | Does not approve its own unreviewed changes |

Future roles are promoted only when repeated work creates a meaningful routing,
depth, or accountability problem. The GitHub roadmap currently tracks platform,
commerce strategy, storefront, extensions, apps, and analytics as candidates.

## Handoff protocol

Role handoffs use a concise structured record:

```text
Request:
Current state:
Target store/project/environment:
Decision or work completed:
Evidence:
Files, commands, or links:
Required permissions/scopes:
Known risks and unresolved questions:
Recommended next role:
Explicit authorization still required:
```

An agent must not hide an unresolved question inside a confident conclusion.
Unknowns remain visible as `needs-review`.

## Initial store-pilot scope

The first implementation phase should be safe to test against a development
store. It should support a read-only inspection and a reversible preview flow,
not a production migration or publishing workflow.

The pilot should let a user ask the system to:

1. identify the store, environment, and requested outcome;
2. route the request through architect, developer/operator, and reviewer roles;
3. inspect store metadata or an existing project read-only;
4. propose a bounded change;
5. implement or prepare the change locally;
6. validate it with Shopify's current toolkit and CLI guidance;
7. preview or dry-run the result where supported; and
8. report evidence, remaining approval, and rollback steps.

Publishing, broad data writes, customer-data access, and irreversible changes
remain out of the first pilot unless explicitly authorized in a later phase.

## Phased delivery

### Phase 1: Methodology foundation

Create role contracts, lifecycle states, handoff records, coordinator routing,
the development-store pilot guide, and the first behavioral pressure scenarios.
Ship as one focused PR from `main`.

### Phase 2: Role coordination

Strengthen coordinator behavior for sequential and parallel work, missing
context, approval gates, and structured handoffs. Add role-specific references
only where repeated tasks justify them.

### Phase 3: Shopify workflow packs

Add focused workflows for app development, themes/storefronts, extensions and
Functions, operational data, ShopifyQL analytics, release management, and store
operations.

### Phase 4: Evaluation and compatibility

Add pressure tests, regression fixtures, supported-agent checks, installation
smoke tests, and a release/versioning policy.

### Phase 5: Public ecosystem

Add contribution examples, sanitized end-to-end playbooks, issue templates,
change communication, and a stable public package contract.

## Success criteria

The first pilot is successful when a user can install the package, provide a
development-store target, request a bounded change, observe the selected roles
and handoffs, receive a reviewable proposal or preview, and distinguish clearly
between what was proposed, implemented, validated, and actually changed.
