# Shopify Agent Methodology Foundation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:executing-plans to implement this plan task-by-task.

**Goal:** Make the six MVP roles usable as a small Shopify development methodology that can be installed and piloted safely against a development store.

**Architecture:** Keep the portable `skills/<name>/SKILL.md` package as the runtime surface. Add shared lifecycle, role-contract, handoff, and pilot guidance under `docs/` so the skills can point to stable local references without copying Shopify's volatile platform documentation. Add scenario-based evaluation fixtures and strengthen the custom validator only where a structural invariant is deterministic.

**Tech Stack:** Markdown skill files, Bash validation, GitHub Actions, `npx skills`, Shopify CLI, and the official Shopify AI Toolkit as the external source of current platform behavior.

**Spec:** `docs/history/specs/2026-10-20-shopify-agent-methodology-design.md`

## Global Constraints

- Preserve the official Shopify toolkit and CLI as the source of current API, schema, validation, and command behavior.
- Keep the six MVP role boundaries explicit, especially the separation between operational data engineering and ShopifyQL analytics.
- Do not authorize or perform live-store writes by default.
- Every workflow must distinguish proposed, implemented, validated, reviewed, deployed, operated, and measured states.
- Every role handoff must preserve evidence, unresolved questions, required permissions, and explicit authorization still required.
- Keep `SKILL.md` files concise; put shared or conditional detail in linked references.
- All changes must pass `bash scripts/validate-skills.sh`, official `skills-ref` validation, and `git diff --check`.

## Review Focus

- A request for analytics must not route to `shopify-data-engineer` merely because it involves data; add a routing test for ShopifyQL and aggregate metrics.
- A development-store preview must not be described as a production deployment; add a state-transition test.
- A successful command must not be treated as proof of the intended resource change; add an evidence test requiring readback.
- A role must not perform a write without named-store context, scope, and explicit authorization; add an unsafe-mutation pressure scenario.
- A handoff must not discard unresolved permissions, data ownership, rollback, or environment questions; add a completeness test.

---

### Task 1: Add shared methodology references

**Files:**
- Create: `docs/methodology/lifecycle.md`
- Create: `docs/methodology/role-contract.md`
- Create: `docs/methodology/handoff-record.md`
- Create: `docs/methodology/store-pilot.md`

**Interfaces:**
- Consumes: the lifecycle states, role contract, handoff protocol, and pilot constraints from the design spec.
- Produces: stable local references that each role can link to without duplicating the complete methodology.

- [x] **Step 1: Write reference acceptance checks**

  Define a small Bash or text-based check that each reference exists, names the
  required states/fields, and includes the development-store safety boundary.

- [x] **Step 2: Run the checks and verify they fail**

  Run the check before creating the references. Expected: failure naming the
  missing reference files or required terms.

- [x] **Step 3: Write the four references**

  Keep them operational: lifecycle transitions and evidence; the role contract;
  the handoff record; and the safe development-store pilot procedure.

- [x] **Step 4: Run the checks and verify they pass**

  Expected: all required references and invariants pass.

- [x] **Step 5: Commit**

  `git commit -m "docs: add Shopify methodology references"`

### Task 2: Upgrade coordinator routing

**Files:**
- Modify: `skills/shopify-expert/SKILL.md`
- Modify: `README.md`
- Test: `scripts/validate-skills.sh`

**Interfaces:**
- Consumes: the shared lifecycle, role contract, and handoff references from Task 1.
- Produces: coordinator behavior that selects the smallest role set, records lifecycle state, and emits a structured next handoff.

- [x] **Step 1: Add failing structural checks**

  Require `shopify-expert` to reference lifecycle states, role boundaries,
  handoff records, and explicit authorization before mutations.

- [x] **Step 2: Run `bash scripts/validate-skills.sh` and verify it fails**

  Expected: the new coordinator requirements are reported as missing.

- [x] **Step 3: Update `shopify-expert/SKILL.md`**

  Add routing signals, state transitions, role-selection rules, parallelization
  boundaries, and a required handoff output. Link to the shared references.

- [x] **Step 4: Add README pilot invocation examples**

  Document one read-only inspection and one reversible development-store preview
  request, including the expected role sequence and evidence.

- [x] **Step 5: Run validation and verify it passes**

  Run the repository validator and official validator. Expected: PASS.

- [x] **Step 6: Commit**

  `git commit -m "feat: add Shopify methodology routing"`

### Task 3: Normalize MVP role contracts

**Files:**
- Modify: `skills/shopify-architect/SKILL.md`
- Modify: `skills/shopify-developer/SKILL.md`
- Modify: `skills/shopify-data-engineer/SKILL.md`
- Modify: `skills/shopify-store-operator/SKILL.md`
- Modify: `skills/shopify-reviewer/SKILL.md`

**Interfaces:**
- Consumes: the role-contract and handoff references from Task 1.
- Produces: consistent owns/use/do-not-use/requires/produces/handoffs/safety-gates sections for every role.

- [x] **Step 1: Add failing contract checks**

  Extend the validator to require the role contract headings in all six MVP
  skills, while preserving the existing headings.

- [x] **Step 2: Run the validator and verify it fails**

  Expected: the five specialist roles report missing contract sections.

- [x] **Step 3: Add the contract sections**

  Keep each role specific. Do not copy Shopify API details. Preserve the
  data-engineer/analytics boundary and store-operator authorization boundary.

- [x] **Step 4: Run all structural and official validation**

  Expected: all six roles pass.

- [x] **Step 5: Commit**

  `git commit -m "docs: normalize Shopify role contracts"`

### Task 4: Add pilot evaluation scenarios

**Files:**
- Create: `docs/evaluations/store-pilot-scenarios.md`
- Create: `scripts/validate-evaluation-scenarios.sh`
- Modify: `README.md`
- Update the GitHub Issues roadmap.

**Interfaces:**
- Consumes: coordinator routing and role contracts from Tasks 1–3.
- Produces: copy-ready scenarios for a development-store pilot and deterministic checks that the scenarios cover safety-critical behaviors.

- [x] **Step 1: Write failing scenario checks**

  Check for scenarios covering read-only inspection, bounded preview, analytics
  routing, unsafe mutation refusal, and evidence/readback.

- [x] **Step 2: Run the checks and verify they fail**

  Expected: the missing scenario document is reported.

- [x] **Step 3: Write pressure scenarios**

  Each scenario must state context, user request, expected role routing, unsafe
  temptation, required handoff/evidence, and pass/fail criteria.

- [x] **Step 4: Add pilot instructions**

  Explain how to install the skills, authenticate a development store, run the
  read-only scenario first, and capture output without exposing credentials.

- [x] **Step 5: Run scenario and repository checks**

  Expected: all required scenarios and skill validators pass.

- [x] **Step 6: Commit**

  `git commit -m "test: add Shopify store pilot scenarios"`

### Task 5: Prepare the initial feature PR

**Files:**
- Modify: `README.md`
- Modify: `docs/CONTRIBUTING.md`
- Update the GitHub Issues roadmap.

**Interfaces:**
- Consumes: all methodology references, coordinator behavior, role contracts, and pilot scenarios.
- Produces: a reviewable PR description, contributor workflow, and clearly separated future phases.

- [x] **Step 1: Document the end-to-end pilot workflow**

  Include install, authentication prerequisites, development-store scope, role
  sequence, expected artifacts, and explicit non-goals.

- [x] **Step 2: Update the roadmap**

  Mark only the methodology-foundation items complete. Keep coordination,
  workflow packs, evaluations, compatibility, and public ecosystem work as
  separate future PR-sized items.

- [x] **Step 3: Run the full verification gate**

  Run:

  ```bash
  bash scripts/validate-skills.sh
  bash scripts/validate-skills-standard.sh
  bash scripts/validate-evaluation-scenarios.sh
  git diff --check
  ```

- [x] **Step 4: Commit and open the PR**

  Use a focused title such as `feat: add Shopify agent methodology foundation`.
  The PR body must list scope, non-goals, pilot instructions, validation
  evidence, and explicitly state that no live-store mutation was performed.

## Future PR sequence after the foundation

1. `feat: improve multi-role Shopify coordination`
2. `feat: add Shopify app and storefront workflow packs`
3. `feat: add Shopify data and analytics workflow packs`
4. `test: add behavioral role evaluations`
5. `ci: add agent compatibility and release checks`
6. `docs: publish contribution and ecosystem playbooks`

Each PR should remain independently reviewable, testable, and revertible.
