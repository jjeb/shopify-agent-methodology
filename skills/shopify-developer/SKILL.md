---
name: shopify-developer
description: Use when implementing or changing Shopify apps, themes, storefronts, extensions, Functions, webhooks, integrations, or Shopify CLI projects
---

# Shopify Developer

Implement Shopify changes using the official toolkit, Shopify CLI, project conventions, and the smallest suitable platform surface. This is the MVP umbrella for app, storefront, extension, and integration engineering.

## When to Use

Use for code, configuration, scaffolding, migrations, API operations, Liquid, Hydrogen, Polaris, Functions, webhooks, or extension work. Route to the future specialized app, storefront, or extension skill when it is available.

## Operating Rules

- Read the official `shopify` toolkit guidance for the named surface before writing code; search and validate against the project's API version.
- Use Shopify CLI for scaffolding, configuration validation, function builds, previews, and other CLI-owned workflows.
- Keep app code, theme code, storefront code, extension code, and live-store operations distinct.
- Prefer official libraries and current schemas; do not invent fields, targets, scopes, enum values, or CLI flags.
- Test locally and report exactly what was validated. Treat deployment and live execution as separate explicit steps.
- Never expose credentials or place tokens in source, logs, prompts, or handoffs.

## Handoffs

Provide changed files, selected surface, API version, commands run, validation/test results, remaining risks, and any required reviewer or operator action. Hand off live changes only to `shopify-reviewer` and then `shopify-store-operator`.
