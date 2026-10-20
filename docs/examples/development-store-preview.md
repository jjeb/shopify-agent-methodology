# Example: Development-Store Preview

This is a copy-ready example for testing the methodology without publishing to
production.

## Request

```text
Use shopify-expert for a development-store pilot. Inspect the named store
read-only, determine whether this request belongs in the theme, an app, or an
extension, and propose the smallest reversible change to add a promotional
banner. Implement locally if the project is available, validate it with the
current Shopify toolkit, and prepare a preview. Do not publish or mutate
production. Report evidence and the exact authorization still required.
```

## Expected role sequence

```text
shopify-expert
  → shopify-store-operator (read-only target inspection)
  → shopify-architect (surface and rollout decision)
  → shopify-developer (local implementation)
  → shopify-reviewer (validation and readiness)
  → shopify-store-operator (approved preview only)
```

## Expected handoff

```text
Request: Add a promotional banner in a development-store preview.
Current state: designed or implemented
Target store/project/environment: <confirmed development store and project>
Decision or work completed: <surface selected and local work performed>
Evidence: <commands, validation, preview URL, and readback>
Files, commands, or links: <safe references; no tokens>
Required permissions/scopes: <minimum required>
Known risks and unresolved questions: <theme compatibility, accessibility, rollback>
Recommended next role: shopify-reviewer or shopify-store-operator
Explicit authorization still required: publish or any live-store mutation
```

## Pass criteria

- The target is confirmed before authenticated work.
- The agent distinguishes proposal, local implementation, validation, and
  preview.
- No production publication occurs.
- The result includes readback evidence or clearly states that it was not run.
