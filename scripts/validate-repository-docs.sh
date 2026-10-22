#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readme="$repo_root/README.md"

required_strings=(
  'github.com/jjeb/shopify-agent-methodology'
  "npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a claude-code -y"
  "npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a pi -y"
  'bash scripts/validate-repository-docs.sh'
  'delivery-first guardrails'
  'vertical slice'
  'methodology budget'
  'store-pilot-scenarios.md'
  'github.com/jjeb/shopify-agent-methodology/issues'
  'docs/history/README.md'
  'capability maturity'
  'future-specialist'
  'roadmap issue #20'
  'shopify-data-integration-engineer'
  'docs/migrations/2026-10-22-data-integration-engineer-role-rename.md'
)

for required in "${required_strings[@]}"; do
  if ! grep -Fq "$required" "$readme"; then
    echo "FAIL: README.md is missing required text: $required" >&2
    exit 1
  fi
done

if [[ ! -f "$repo_root/VERSION" ]] || [[ "$(tr -d '[:space:]' < "$repo_root/VERSION")" != "0.3.0" ]]; then
  echo "FAIL: VERSION must be 0.3.0" >&2
  exit 1
fi
if [[ ! -f "$repo_root/CHANGELOG.md" ]] || ! grep -Fq '[0.3.0]' "$repo_root/CHANGELOG.md"; then
  echo "FAIL: CHANGELOG.md is missing the 0.3.0 entry" >&2
  exit 1
fi

if grep -Fq 'shopify-consulting-roles' "$readme"; then
  echo "FAIL: README.md still contains the old repository name" >&2
  exit 1
fi

if grep -Fq 'The coordinator will normally use:' "$readme"; then
  echo "FAIL: README still presents a fixed all-role workflow" >&2
  exit 1
fi

for required_file in \
  docs/methodology/delivery-guardrails.md \
  docs/evaluations/store-pilot-scenarios.md; do
  if [[ ! -f "$repo_root/$required_file" ]]; then
    echo "FAIL: README-linked documentation is missing: $required_file" >&2
    exit 1
  fi
done

if grep -Eq 'npx skills add (<github-owner>|/Users/|/home/)' "$readme"; then
  echo "FAIL: README.md contains a placeholder or personal installation path" >&2
  exit 1
fi

if [[ -d "$repo_root/docs/superpowers" ]]; then
  echo "FAIL: docs/superpowers is an obsolete documentation nesting layer" >&2
  exit 1
fi

for required_file in \
  CONVENTIONS.md \
  docs/workflows/shopify-lifecycle.md \
  docs/examples/development-store-preview.md \
  docs/examples/analytics-and-operational-data.md \
  docs/history/README.md \
  docs/migrations/2026-10-22-data-integration-engineer-role-rename.md; do
  if [[ ! -f "$repo_root/$required_file" ]]; then
    echo "FAIL: missing required documentation example: $required_file" >&2
    exit 1
  fi
done

for historical_dir in docs/plans docs/specs; do
  if [[ -d "$repo_root/$historical_dir" ]] && find "$repo_root/$historical_dir" -type f -print -quit | grep -q .; then
    echo "FAIL: $historical_dir contains active documents; move completed records under docs/history" >&2
    exit 1
  fi
done

if [[ -f "$repo_root/docs/BACKLOG.md" ]]; then
  echo "FAIL: docs/BACKLOG.md is obsolete; deferred work belongs in GitHub Issues" >&2
  exit 1
fi

if [[ -f "$repo_root/BACKLOG.md" ]]; then
  echo "FAIL: BACKLOG.md is obsolete; deferred work belongs in GitHub Issues" >&2
  exit 1
fi

if ! grep -Fq '```mermaid' "$repo_root/docs/workflows/shopify-lifecycle.md"; then
  echo "FAIL: lifecycle workflow must include a Mermaid diagram" >&2
  exit 1
fi

echo "PASS: repository name and installation documentation are current"
