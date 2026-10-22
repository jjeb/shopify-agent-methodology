# Contributing

Read the repository-level [CONVENTIONS.md](../CONVENTIONS.md) before making
changes. It defines the source-of-truth documents, delivery-first rules, and
required validation checks.

## Add or refine a skill

1. Inspect the existing skills under `skills/` and the deferred-work items in the [GitHub Issues roadmap](https://github.com/jjeb/shopify-agent-methodology/issues).
2. Keep each skill focused on one role and use the portable `skills/<name>/SKILL.md` layout.
3. Use valid frontmatter with a `name` and a description beginning with `Use when`.
4. Include `When to Use`, `Operating Rules`, and `Handoffs` sections.
5. Include the role contract headings: `Owns`, `Do Not Use For`, `Requires`,
   `Produces`, and `Safety Gates`.
6. Link shared lifecycle, role-contract, and handoff guidance from
   `docs/methodology/` instead of duplicating it in every skill.
7. Add or change capability ownership in the canonical [role matrix](methodology/role-matrix.md),
   using the role tag `core` and capability tags `core`, `supported`,
   `experimental`, `research-needed`, or `future-specialist`. Future
   specialists are candidates only; do not add an installable role without a
   roadmap issue and evidence.
   Keep `methodology/capability-maturity.json` synchronized with the matrix.
8. Put workflow diagrams and copy-ready usage examples in `docs/workflows/`
   and `docs/examples/`; keep completed design specifications and
   implementation plans in `docs/history/specs/` and `docs/history/plans/`.
   Treat those files as historical records, not active roadmap items; use the
   GitHub Issues roadmap and project for current deferred work.
9. For an installable role rename, update the canonical directory/frontmatter,
   all current routing references, generated references, validators, and add a
   compatibility guide; do not retain a duplicate alias.
10. Defer current Shopify API, schema, validation, and CLI details to Shopify's official toolkit and documentation.
11. Preserve the boundaries between proposal, local implementation, validation, deployment, and live-store execution.
12. Never include credentials, tokens, passwords, or unnecessary merchant data.

## Validate changes

Run:

```bash
bash scripts/validate-skills.sh
bash scripts/validate-repository-docs.sh
bash scripts/validate-methodology.sh
bash scripts/validate-evaluation-scenarios.sh
bash scripts/validate-role-documentation.sh
python3 scripts/validate-capability-maturity.py
bash scripts/validate-installation-smoke.sh
python3 scripts/sync-skill-references.py --check
git diff --check
```

For the official Agent Skills specification check, install `skills-ref` in a
local virtual environment and run:

```bash
python -m venv .venv
.venv/bin/python -m pip install \
  "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
bash scripts/validate-skills-standard.sh
```

Pull requests to `main` run both checks in GitHub Actions. The official
validator checks package format and frontmatter; it does not replace behavioral
review of role routing, safety boundaries, or handoffs.

Before proposing a new role, run the relevant scenarios in
`docs/evaluations/store-pilot-scenarios.md` and explain why the existing roles
cannot cover the request. Keep future work in GitHub Issues as a separate,
reviewable issue-sized item.

Update `README.md` and the relevant GitHub roadmap issue when adding a role or
changing installation and routing behavior. Use focused commits on `main` and
describe validation results in the commit or pull request.
