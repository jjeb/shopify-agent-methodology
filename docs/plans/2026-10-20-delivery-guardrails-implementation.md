# Shopify Delivery Guardrails Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Make the Shopify role system prioritize measurable store or product delivery and prevent methodology work from delaying implementation.

**Architecture:** Add one shared delivery-guardrails reference document, make `shopify-expert` the enforcement point, and link the affected roles and evaluation scenarios to the shared rules. Extend repository validators so the guardrails cannot silently disappear from the package.

**Tech Stack:** Markdown skill documents, Bash validation scripts, GitHub Actions, shell-based evaluation scenario checks.

**Spec:** `docs/specs/2026-10-20-shopify-agent-methodology-design.md`

## Global Constraints

- Preserve the six MVP roles; do not add a delivery-manager role.
- Defer current Shopify API, CLI, schema, and policy details to Shopify's official toolkit and documentation.
- Keep live-store writes explicitly authorized, reviewed, reversible where possible, and verified by readback.
- Keep ShopifyQL analytics separate from operational data engineering.
- Keep project-specific implementation details out of this reusable methodology repository.
- Do not make future roles or generic evaluation infrastructure prerequisites for the MVP.

## Review Focus

- A broad request must select the minimum useful roles rather than dispatching every role.
- A methodology-only task must not run indefinitely without a delivery checkpoint.
- A migration must produce an early vertical slice before broad foundation work expands.
- Recursive validation must stop unless it addresses an immediate safety, credential, data-loss, or production risk.
- Review depth must match the risk of the work, especially documentation versus live-store mutations.

### Task 1: Add the shared delivery guardrails reference

**Files:**
- Create: `docs/methodology/delivery-guardrails.md`
- Test: `scripts/validate-methodology.sh`

**Interfaces:**
- Produces the canonical rules referenced by `shopify-expert`, the role matrix, the README, and evaluation scenarios.

- [ ] **Step 1: Write the failing validator assertion**

Add `docs/methodology/delivery-guardrails.md` to the required methodology files in `scripts/validate-methodology.sh`, then run the validator and confirm it fails because the document is absent.

- [ ] **Step 2: Write the guardrails document**

Document the primary outcome rule, one-task setup budget, vertical-slice checkpoint, recursion stop, two-task human checkpoint, proportional review, escalation triggers, and status/evidence rules. Include a compact decision flow and concrete Shopify examples.

- [ ] **Step 3: Run the methodology validator**

Run `bash scripts/validate-methodology.sh` and verify it passes.

- [ ] **Step 4: Commit**

```bash
git add docs/methodology/delivery-guardrails.md scripts/validate-methodology.sh
git commit -m "docs: define Shopify delivery guardrails"
```

### Task 2: Make the coordinator enforce delivery control

**Files:**
- Modify: `skills/shopify-expert/SKILL.md`
- Modify: `docs/methodology/role-contract.md`
- Modify: `docs/methodology/role-matrix.md`
- Test: `scripts/validate-skills.sh`

**Interfaces:**
- Consumes `docs/methodology/delivery-guardrails.md`.
- Produces coordinator instructions that every broad workflow can follow without adding another role.

- [ ] **Step 1: Add failing structural checks**

Extend `scripts/validate-skills.sh` to require the coordinator link and key delivery-control terms. Run it and confirm the new checks fail before the skill is updated.

- [ ] **Step 2: Update the coordinator contract**

Add a required delivery brief containing primary outcome, first visible deliverable, setup work, stop condition, and success evidence. Require the coordinator to apply the shared guardrails before dispatching roles.

- [ ] **Step 3: Update role ownership documentation**

Make delivery sequencing an explicit `shopify-expert` responsibility, make the architect produce an implementation slice, make the developer prioritize a working slice, and make the reviewer apply proportional review.

- [ ] **Step 4: Run structural validation**

Run `bash scripts/validate-skills.sh` and `bash scripts/validate-role-documentation.sh` and verify both pass.

- [ ] **Step 5: Commit**

```bash
git add skills/shopify-expert/SKILL.md docs/methodology/role-contract.md docs/methodology/role-matrix.md scripts/validate-skills.sh
git commit -m "feat: enforce delivery-first role coordination"
```

### Task 3: Align specialist roles with the guardrails

**Files:**
- Modify: `skills/shopify-architect/SKILL.md`
- Modify: `skills/shopify-developer/SKILL.md`
- Modify: `skills/shopify-reviewer/SKILL.md`
- Modify: `skills/shopify-store-operator/SKILL.md`

**Interfaces:**
- Consumes the shared guardrails and coordinator handoff contract.
- Produces role behavior that supports early delivery without weakening store safety.

- [ ] **Step 1: Add role-specific delivery rules**

Require the architect to identify the first slice, the developer to report working evidence before optional infrastructure, the reviewer to scale review to risk, and the operator to perform safe read-only validation early when the request requires a store.

- [ ] **Step 2: Check role boundaries**

Preserve each role’s exclusions and confirm that no specialist becomes a general coordinator or analytics role.

- [ ] **Step 3: Run role and skills validation**

Run `bash scripts/validate-role-documentation.sh` and `bash scripts/validate-skills.sh`.

- [ ] **Step 4: Commit**

```bash
git add skills/shopify-architect/SKILL.md skills/shopify-developer/SKILL.md skills/shopify-reviewer/SKILL.md skills/shopify-store-operator/SKILL.md
git commit -m "docs: align Shopify roles with delivery guardrails"
```

### Task 4: Add pressure scenarios for methodology overhead

**Files:**
- Modify: `docs/evaluations/store-pilot-scenarios.md`
- Modify: `scripts/validate-evaluation-scenarios.sh`

**Interfaces:**
- Produces evaluation cases that test observable coordinator behavior rather than merely checking document presence.

- [ ] **Step 1: Add required scenario names to the validator**

Require scenarios for minimum-role routing, vertical-slice prioritization, recursive-validation stopping, methodology budget escalation, and proportional review. Run the validator and confirm it fails until the scenarios exist.

- [ ] **Step 2: Write the scenarios**

For each scenario, define setup, agent request, expected role selection, expected stop or continuation behavior, required evidence, and failure conditions. Keep examples sanitized and store-independent.

- [ ] **Step 3: Run the scenario validator**

Run `bash scripts/validate-evaluation-scenarios.sh` and verify it passes.

- [ ] **Step 4: Commit**

```bash
git add docs/evaluations/store-pilot-scenarios.md scripts/validate-evaluation-scenarios.sh
git commit -m "test: add delivery guardrail pressure scenarios"
```

### Task 5: Document usage, status, and future backlog

**Files:**
- Modify: `README.md`
- Modify: `BACKLOG.md`
- Modify: `scripts/validate-repository-docs.sh`

**Interfaces:**
- Produces public-facing installation and usage guidance that explains how the guardrails prevent methodology overhead.

- [ ] **Step 1: Add README requirements to the documentation validator**

Require README references to the delivery guardrails, vertical slices, methodology budget, and evaluation scenarios. Run the validator and confirm it fails before the README update.

- [ ] **Step 2: Update README**

Add a short “delivery-first behavior” section, a copy-ready prompt that asks the coordinator to enforce the guardrails, and links to the detailed methodology and evaluation documents. Clarify that the rules apply to the agent workflow, not only to Shopify migration projects.

- [ ] **Step 3: Update BACKLOG**

Record the guardrail system as completed foundation work and retain future improvements such as automated pressure tests, routing selection, role specificity, and upstream extraction without making them prerequisites for current use.

- [ ] **Step 4: Run documentation validation**

Run `bash scripts/validate-repository-docs.sh` and verify it passes.

- [ ] **Step 5: Commit**

```bash
git add README.md BACKLOG.md scripts/validate-repository-docs.sh
git commit -m "docs: explain delivery-first methodology usage"
```

### Task 6: Run the complete repository verification

**Files:**
- Modify: none unless verification exposes a required correction.

- [ ] **Step 1: Run repository checks**

```bash
bash scripts/validate-methodology.sh
bash scripts/validate-role-documentation.sh
bash scripts/validate-evaluation-scenarios.sh
bash scripts/validate-repository-docs.sh
bash scripts/validate-skills.sh
```

- [ ] **Step 2: Run official Agent Skills validation when available**

Run `bash scripts/validate-skills-standard.sh`; if `skills-ref` is unavailable, report that limitation explicitly rather than treating the local checks as equivalent.

- [ ] **Step 3: Review the diff**

Check that every new rule is documented once, links resolve, the six-role boundary is preserved, and no migration-specific details or credentials were introduced.

- [ ] **Step 4: Commit any verification corrections**

Use a focused documentation or test commit only if verification identifies a real defect.
