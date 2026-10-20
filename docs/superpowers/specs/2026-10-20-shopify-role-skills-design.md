# Shopify Role Skills Design

## Goal

Create a public-ready, installable package of role-based Shopify skills that complements Shopify's official AI Toolkit and supports the minimum complete lifecycle for store development and operation.

## MVP scope

The first release contains six skills: expert coordinator, architect, developer, data engineer, store operator, and reviewer. Deferred roles and tasks remain in `TODO.md`.

## Design

`shopify-expert` routes requests to one or more role skills. The role skills are independently installable from the portable `skills/` layout and use the official Shopify `shopify` toolkit for current API, CLI, schema, and validation knowledge. They must not copy unstable Shopify API reference material.

Every role separates proposed work, local changes, validation, deployment, and live-store execution. Live mutations require explicit scope, named store context, and evidence of completion.

## Acceptance criteria

- All six skills have valid Agent Skills frontmatter.
- Each skill defines activation conditions, operating rules, and handoff artifacts.
- The coordinator documents common role combinations and escalation to deferred roles.
- The repository explains local and future public installation.
- `scripts/validate-skills.sh` passes.
- `TODO.md` tracks all deferred roles and future work named during design.
