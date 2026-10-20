#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readme="$repo_root/README.md"

required_strings=(
  'github.com/jjeb/shopify-agent-methodology'
  'npx skills add jjeb/shopify-agent-methodology --all -g -a claude-code'
  'npx skills add jjeb/shopify-agent-methodology --all -g -a pi'
  'bash scripts/validate-repository-docs.sh'
)

for required in "${required_strings[@]}"; do
  if ! grep -Fq "$required" "$readme"; then
    echo "FAIL: README.md is missing required text: $required" >&2
    exit 1
  fi
done

if grep -Fq 'shopify-consulting-roles' "$readme"; then
  echo "FAIL: README.md still contains the old repository name" >&2
  exit 1
fi

if grep -Eq 'npx skills add (<github-owner>|/Users/|/home/)' "$readme"; then
  echo "FAIL: README.md contains a placeholder or personal installation path" >&2
  exit 1
fi

echo "PASS: repository name and installation documentation are current"
