# Evaluation Run Log

Use this lightweight log during the first development-store pilots. It is
manual, local, and opt-in; it does not enable hidden telemetry or require a
metrics service.

## Copy-ready prompt

Include this prompt after the task description:

```text
Run this task in evaluation mode. At the end, provide a sanitized run summary
using exactly these fields:

Run ID:
Date:
Repository and branch:
Store/environment:
Request:
Roles used and handoffs:
Lifecycle state at start:
Lifecycle state at end:
Changes made:
Validation performed:
Readback performed:
Review result: pass, needs-review, or fail
Human corrections:
Unresolved risks:
Outcome: success, partial, blocked, or failed

Do not include credentials, access tokens, customer data, full API responses,
or unredacted private prompts. If a field was not applicable or not run, say
so explicitly. Separate observed evidence from assumptions. Do not claim a
live-store result without readback evidence.
```

## Storage

Save each summary in the client or store repository, for example:

```text
.agent-methodology/runs/YYYY-MM-DD-short-name.md
```

Keep the directory local and add it to `.gitignore` when the repository should
not commit run records. Commit only sanitized summaries that the client has
approved. After several pilots, use repeated failures and corrections to decide
whether structured JSONL collection or aggregate reporting is justified.

## What to measure

- Correct role selection and routing
- Complete handoffs and evidence
- Safety-gate compliance
- Human corrections and `needs-review` decisions
- Validation and readback success
- Partial failures, retries, and rollback needs
- Whether the outcome was successful, partial, blocked, or failed
