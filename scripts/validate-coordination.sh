#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
coordination="$repo_root/docs/methodology/coordination.md"
expert="$repo_root/skills/shopify-expert/SKILL.md"

if [[ ! -f "$coordination" ]]; then
  echo "FAIL: missing docs/methodology/coordination.md" >&2
  exit 1
fi

for required in \
  'Routing matrix' \
  'Parallel-safe work' \
  'Join gates' \
  'Coordination packet'; do
  if ! grep -Fq "## $required" "$coordination"; then
    echo "FAIL: coordination guide is missing: $required" >&2
    exit 1
  fi
done

for required in 'Dependencies' 'Branch status' 'Join outcome' 'needs-review'; do
  if ! grep -Fqi "$required" "$coordination"; then
    echo "FAIL: coordination guide is missing: $required" >&2
    exit 1
  fi
done

for required in \
  'references/methodology/coordination.md' \
  'parallel-safe' \
  'join gate' \
  'dependencies' \
  'complete or explicitly skipped' \
  'conflicting or incomplete join'; do
  if ! grep -Fqi "$required" "$expert"; then
    echo "FAIL: shopify-expert is missing coordination requirement: $required" >&2
    exit 1
  fi
done

handoff="$repo_root/docs/methodology/handoff-record.md"
for required in 'Dependencies:' 'Parallel branch status:' 'Join outcome:' 'Unresolved conflicts:' 'Next-state evidence:'; do
  if ! grep -Fq "$required" "$handoff"; then
    echo "FAIL: handoff record is missing coordination field: $required" >&2
    exit 1
  fi
done

echo "PASS: multi-role coordination guidance is present"
