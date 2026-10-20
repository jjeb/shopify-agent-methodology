# Contributing

## Add or refine a skill

1. Inspect the existing skills under `skills/` and the future-work prompt in `BACKLOG.md`.
2. Keep each skill focused on one role and use the portable `skills/<name>/SKILL.md` layout.
3. Use valid frontmatter with a `name` and a description beginning with `Use when`.
4. Include `When to Use`, `Operating Rules`, and `Handoffs` sections.
5. Defer current Shopify API, schema, validation, and CLI details to Shopify's official toolkit and documentation.
6. Preserve the boundaries between proposal, local implementation, validation, deployment, and live-store execution.
7. Never include credentials, tokens, passwords, or unnecessary merchant data.

## Validate changes

Run:

```bash
bash scripts/validate-skills.sh
bash scripts/validate-repository-docs.sh
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

Update `README.md` and `BACKLOG.md` when adding a role or changing installation and routing behavior. Use focused commits on `main` and describe validation results in the commit or pull request.
