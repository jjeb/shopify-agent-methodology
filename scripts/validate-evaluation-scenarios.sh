#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
scenarios="$repo_root/docs/evaluations/store-pilot-scenarios.md"

required_scenarios=(
  'Read-only store inspection'
  'Bounded reversible preview'
  'ShopifyQL analytics routing'
  'Unsafe mutation refusal'
  'Evidence and readback'
  'Minimum-role routing'
  'Vertical-slice prioritization'
  'Recursive-validation stop'
  'Methodology budget checkpoint'
  'Proportional review'
)

if [[ ! -f "$scenarios" ]]; then
  echo "FAIL: missing docs/evaluations/store-pilot-scenarios.md" >&2
  exit 1
fi

for scenario in "${required_scenarios[@]}"; do
  if ! grep -Fq "## $scenario" "$scenarios"; then
    echo "FAIL: missing evaluation scenario: $scenario" >&2
    exit 1
  fi
  section="$(awk -v heading="## $scenario" '
    $0 == heading { in_section=1; next }
    in_section && /^## / { exit }
    in_section { print }
  ' "$scenarios")"
  for required_text in '**Expected routing:**' '**Pass criteria:**'; do
    if ! grep -Fq "$required_text" <<<"$section"; then
      echo "FAIL: scenario '$scenario' is missing $required_text" >&2
      exit 1
    fi
  done
done

echo "PASS: store-pilot evaluation scenarios are present"
