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
git diff --check
```

Update `README.md` and `BACKLOG.md` when adding a role or changing installation and routing behavior. Use focused commits on `main` and describe validation results in the commit or pull request.
