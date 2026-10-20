# Shopify Consulting Roles: Vision and Backlog

## Mission

Help people build, manage, operate, and grow Shopify stores and apps with
specialized agent roles that understand the work from different professional
perspectives. The repository should make Shopify development more approachable
without hiding platform complexity or encouraging unsafe live-store changes.

The role skills sit alongside Shopify's official tools, AI Toolkit, CLI, and
documentation. They do not replace those sources. Instead, they help an agent
choose the right Shopify capability, coordinate the people or roles involved,
make dependencies and permissions explicit, and produce evidence that a change
is ready to use.

## Vision

Provide a dependable, installable team of Shopify experts that can support the
full store lifecycle:

- understand a merchant's goal and turn it into a bounded technical plan;
- design and build apps, themes, storefronts, extensions, integrations, and
  data workflows;
- operate stores safely across development, preview, staging, and production;
- review security, permissions, data quality, performance, accessibility, and
  release readiness;
- interpret store performance and business signals without confusing analytics
  with operational data changes; and
- help a person move from an idea to an implemented, validated, maintainable,
  and measurable Shopify solution.

The long-term goal is not one oversized Shopify skill. It is a coordinated
role system where each role has a clear boundary, useful handoffs, and enough
Shopify context to work independently while remaining aligned with the official
platform guidance.

## Product principles

- **Complement the platform:** defer current API, schema, CLI, and policy facts
  to Shopify's official sources.
- **Role clarity:** add a specialized role only when it improves routing,
  decisions, or accountability.
- **Lifecycle coverage:** connect discovery, architecture, implementation,
  data, operations, review, release, and ongoing improvement.
- **Safety by default:** distinguish proposals, local changes, deployments,
  and confirmed live-store results; require explicit authorization for writes.
- **Evidence over confidence:** report what was inspected, changed, validated,
  and read back; mark unknowns as `needs-review`.
- **Portable installation:** keep skills compatible with supported agents and
  make the package easy to install from a public repository.

## How to use this backlog

This file is both a product backlog and a handoff prompt for a future agent.
When promoting an item, first inspect the existing six MVP roles, identify the
real routing or workflow gap, define the new role's boundary, add pressure
tests, update installation and documentation, and validate the complete skill
package. Do not create a role merely to mirror every Shopify product area.

These items are intentionally deferred from the MVP. Keep them visible and promote one when real usage shows that the six core skills are too broad.

## Completed foundation

- [x] Define the shared Shopify work lifecycle, role contract, handoff record,
  and development-store pilot boundary.
- [x] Add coordinator routing for lifecycle state, role selection, handoffs,
  explicit authorization, and evidence.
- [x] Normalize the six MVP skills around consistent role contracts.
- [x] Add initial development-store pressure scenarios for routing, safety, and
  readback evidence.

## Deferred roles

- [ ] `shopify-platform-engineer`: split out CI/CD, environments, secrets, observability, deployment, release automation, and incident response.
- [ ] `shopify-commerce-strategist`: split out pricing, subscriptions, B2B, Markets, payments, sales channels, marketing, and growth planning.
- [ ] `shopify-storefront-engineer`: split storefront implementation from the general developer role when Liquid, Hydrogen, Storefront API, performance, or accessibility needs dedicated depth.
- [ ] `shopify-extension-engineer`: split Admin, Checkout, Customer Account, POS, Polaris, Functions, targets, and migration workflows from the general developer role.
- [ ] `shopify-app-engineer`: split app backends, Admin GraphQL, Customer Account, Partner, Payments Apps, auth, webhooks, and official backend libraries from the general developer role.
- [ ] `shopify-analytics`: separate ShopifyQL, reporting, metrics, trends, segmentation, and dashboard interpretation from operational data engineering.

## Capability backlog

- [ ] Add explicit UCP and agent-commerce workflows when they become stable enough for a dedicated operating contract.
- [ ] Keep ShopifyQL and aggregate analytics out of `shopify-data-engineer`; promote `shopify-analytics` when analytics work becomes a first-class workflow.
- [ ] Add role-specific reference files only when repeated tasks exceed the useful size of `SKILL.md`.
- [ ] Add automated pressure tests for routing, handoffs, unsafe live-store mutations, and evidence claims.
- [ ] Add compatibility checks for supported agent targets and `npx skills` releases.
- [ ] Add a release/versioning policy before the first public repository release.
- [ ] Add contribution guidance and examples from sanitized, non-store-specific workflows.
- [x] Add a GitHub Actions validation job for the repository and the official Agent Skills specification.
