#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

required_files=(
  docs/methodology/lifecycle.md
  docs/methodology/role-contract.md
  docs/methodology/handoff-record.md
  docs/methodology/store-pilot.md
)

for relative_file in "${required_files[@]}"; do
  file="$repo_root/$relative_file"
  if [[ ! -f "$file" ]]; then
    echo "FAIL: missing $relative_file" >&2
    exit 1
  fi
done

echo "PASS: methodology references are present"
