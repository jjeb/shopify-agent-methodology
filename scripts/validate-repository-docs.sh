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

if [[ -d "$repo_root/docs/superpowers" ]]; then
  echo "FAIL: docs/superpowers is an obsolete documentation nesting layer" >&2
  exit 1
fi

for required_file in \
  docs/workflows/shopify-lifecycle.md \
  docs/examples/development-store-preview.md \
  docs/examples/analytics-and-operational-data.md; do
  if [[ ! -f "$repo_root/$required_file" ]]; then
    echo "FAIL: missing required documentation example: $required_file" >&2
    exit 1
  fi
done

if ! grep -Fq '```mermaid' "$repo_root/docs/workflows/shopify-lifecycle.md"; then
  echo "FAIL: lifecycle workflow must include a Mermaid diagram" >&2
  exit 1
fi

echo "PASS: repository name and installation documentation are current"
