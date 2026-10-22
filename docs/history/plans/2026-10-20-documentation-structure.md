# Documentation Structure Implementation Plan

> **For agentic workers:** Use the repository's execution workflow to implement this plan task-by-task.

**Goal:** Make the README a concise entry point while moving installation and evaluation details into focused documentation files and moving deferred work to GitHub Issues.

**Architecture:** Keep `README.md` focused on orientation, quick start, role routing, safety, and links. Put setup/authentication in `docs/getting-started.md`, evaluation run logging in `docs/evaluations/run-log.md`, and product direction in GitHub Issues. Update validators and contributor references so the external roadmap is authoritative.

**Tech Stack:** Markdown, Bash validation scripts, GitHub Actions.

## Global Constraints

- Preserve the official Shopify AI Toolkit as the source of current Shopify platform details.
- Do not include credentials, tokens, customer data, or private prompts in documentation examples.
- Keep installation commands compatible with the public repository and supported `npx skills` targets.
- Validate all changed documentation and repository references before commit.

## Review Focus

- A new user can install and initialize the roles without reading the entire README.
- Authentication remains explicit and does not imply that installation grants store access.
- Moving the backlog to GitHub Issues does not leave stale local links or validator paths.
- Evaluation instructions remain copy-ready and privacy-safe.
- The README still explains the six-role MVP boundary and ShopifyQL separation.

## Tasks

- [x] Create focused setup and evaluation documents; consolidate backlog content for GitHub Issues.
- [x] Reduce README duplication and link to the focused documents.
- [x] Update validators and contributor documentation for the GitHub Issues roadmap.
- [x] Run repository documentation, skill, methodology, evaluation, and whitespace checks.
