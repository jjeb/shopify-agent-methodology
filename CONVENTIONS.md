# Repository Conventions

These conventions apply to the Shopify Agent Methodology repository and are
the first project-specific guidance an agent should read before changing it.

## Purpose and boundaries

- This repository contains portable role skills and the methodology around
  them; it does not replace Shopify's official AI Toolkit, documentation, or
  CLI.
- Keep the six MVP roles focused: `shopify-expert`, `shopify-architect`,
  `shopify-developer`, `shopify-data-engineer`, `shopify-store-operator`, and
  `shopify-reviewer`.
- Keep ShopifyQL, reporting, trends, and aggregate analytics separate from
  operational data engineering.
- Do not add a new role merely to mirror a Shopify product area. Propose the
  gap in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues)
  first and demonstrate it with a pressure scenario.

## Source of truth

- Role ownership: `docs/methodology/role-matrix.md`.
- Shared role contract: `docs/methodology/role-contract.md`.
- Lifecycle states: `docs/methodology/lifecycle.md`.
- Handoffs: `docs/methodology/handoff-record.md`.
- Delivery sequencing and methodology limits:
  `docs/methodology/delivery-guardrails.md`.
- Public installation and usage: `README.md`.
- Deferred work: the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues).
- Contribution workflow: `docs/CONTRIBUTING.md`.

When guidance overlaps, keep the role skill concise and link to the shared
source instead of copying the same rule into multiple files.

## Skill structure

Each installable skill lives at `skills/<skill-name>/SKILL.md` and must:

- use YAML frontmatter with a matching `name` and a description beginning with
  `Use when`;
- include `When to Use`, `Owns`, `Do Not Use For`, `Requires`, `Produces`,
  `Safety Gates`, `Operating Rules`, and `Handoffs` sections;
- link to its role section in `docs/methodology/role-matrix.md`;
- use the official Shopify toolkit for current platform facts; and
- state boundaries and exclusions clearly enough for routing decisions.

Keep API fields, schema details, CLI flags, and other volatile Shopify facts in
official documentation or the official `shopify` skill. Do not invent or
duplicate them here.

## Delivery-first behavior

Every broad workflow begins with a delivery brief containing the primary
outcome, first visible deliverable, environment, setup required, stop
condition, and success evidence.

- Select the minimum roles needed for the current outcome.
- Allow at most one setup or methodology task before direct product or store
  progress.
- Prefer an end-to-end vertical slice before broad foundations.
- Stop recursive validation unless it addresses an immediate security,
  credential, data-loss, or production-risk blocker.
- Request a human checkpoint after two consecutive methodology-only tasks.
- Scale review to risk; named-store mutations require explicit authorization,
  independent review where applicable, and readback evidence.

Preserve these fields in every handoff. A plan, successful command, or local
change is not proof of a live-store result.

## Documentation placement

- `docs/methodology/`: reusable role, lifecycle, handoff, safety, and delivery
  guidance.
- `docs/workflows/`: Mermaid diagrams and reusable workflow descriptions.
- `docs/examples/`: sanitized copy-ready examples.
- `docs/evaluations/`: pressure scenarios and evaluation guidance.
- `docs/specs/`: approved design specifications.
- `docs/plans/`: implementation plans.
- GitHub Issues: deferred capabilities and future roles; keep the existing
  root `BACKLOG.md` only as migration source until the consolidated roadmap
  issue is created.

Do not store project-specific client, store, or credential information in this
public methodology repository.

## Validation

Before committing documentation or skill changes, run:

```bash
bash scripts/validate-skills.sh
bash scripts/validate-repository-docs.sh
bash scripts/validate-methodology.sh
bash scripts/validate-evaluation-scenarios.sh
bash scripts/validate-role-documentation.sh
git diff --check
```

When available, also run:

```bash
bash scripts/validate-skills-standard.sh
```

The official `skills-ref` validator is required in CI but may need to be
installed locally in a virtual environment. Report that limitation rather
than treating local structural checks as equivalent.

## Git and review

- Use focused commits with imperative messages, such as
  `docs: clarify delivery guardrails`.
- Review the diff for accidental credentials, client data, absolute local
  paths, stale repository names, and obsolete documentation nesting.
- Do not push, merge, publish, or change GitHub settings unless explicitly
  requested.
- Before claiming completion, report the exact validation commands and any
  unavailable checks.
