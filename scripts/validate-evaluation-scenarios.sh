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
done

echo "PASS: store-pilot evaluation scenarios are present"
