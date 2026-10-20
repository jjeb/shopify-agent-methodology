# Shopify Role Skills Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Build six installable Shopify role skills with validation and a future-work TODO.

**Architecture:** Each role is a self-contained `SKILL.md` under `skills/`. The coordinator routes to the other roles and to Shopify's official toolkit; the role files provide judgment, safety, and handoff contracts rather than duplicated API reference.

**Tech Stack:** Markdown, YAML frontmatter, Bash validation, `npx skills` installation convention.

**Spec:** `docs/superpowers/specs/2026-10-20-shopify-role-skills-design.md`

## Global Constraints

- Keep the initial package to six skills.
- Complement, do not replace, Shopify's official `shopify` toolkit.
- Do not claim live-store or deployment success without direct evidence.
- Track deferred roles and future tasks in `TODO.md`.

## Review Focus

- A broad prompt should route through `shopify-expert`, not skip architecture or review.
- Live mutations must require named store context and explicit confirmation.
- Shopify API details should be delegated to current official toolkit guidance.
- Data changes must distinguish aggregate analytics from record-level operations.
- Handoffs must state evidence, unresolved risks, and the next owner.

### Task 1: Repository package

**Files:** `README.md`, `TODO.md`, six `skills/*/SKILL.md` files.

- [ ] Write the six role documents and installation guidance.
- [x] Record deferred roles and future capability tasks.

### Task 2: Validation

**Files:** `scripts/validate-skills.sh`.

- [x] Add structural checks for frontmatter, required sections, and TODO coverage.
- [ ] Run the validator after the skill documents exist.
