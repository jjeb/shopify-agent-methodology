---
name: shopify-expert
description: Use when a Shopify request spans multiple surfaces, roles, lifecycle stages, or store and application concerns
---

# Shopify Expert

Coordinate Shopify work around the official Shopify AI Toolkit. This skill adds role selection, sequencing, safety gates, and evidence discipline; it does not replace Shopify's current API and CLI guidance.

## When to Use

Use for broad requests such as building, changing, migrating, operating, reviewing, or expanding a Shopify store or app. Use a focused role directly when the request clearly belongs to one role.

## Operating Rules

1. Identify the store/app/project, environment, API version, and desired outcome.
2. Select only the roles needed: architect, developer, data engineer, store operator, reviewer.
3. Use the official `shopify` toolkit for current schemas, API guidance, validation, and CLI behavior.
4. Separate proposal, local edits, validation, deployment, and live-store execution.
5. Require explicit named-store scope before live mutations; never infer success from a command being issued.
6. Keep ShopifyQL analytics separate from operational data engineering; route reporting requests to the future `shopify-analytics` role when available.

## Handoffs

Every handoff states: objective, context, files or store, selected Shopify surface, completed evidence, unresolved risks, approval needed, and next owner. Typical flow: architect → developer/data engineer → reviewer → store operator.
