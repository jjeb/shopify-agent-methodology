#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
matrix="$repo_root/docs/methodology/role-matrix.md"
skills_root="$repo_root/skills"
roles=(
  shopify-expert
  shopify-architect
  shopify-developer
  shopify-data-engineer
  shopify-store-operator
  shopify-reviewer
)

if [[ ! -f "$matrix" ]]; then
  echo "FAIL: missing docs/methodology/role-matrix.md" >&2
  exit 1
fi

for role in "${roles[@]}"; do
  skill="$skills_root/$role/SKILL.md"
  anchor="references/methodology/role-matrix.md#$role"
  if ! grep -Fq "$anchor" "$skill"; then
    echo "FAIL: $skill does not link to its role documentation" >&2
    exit 1
  fi
  if ! grep -Fq "## $role" "$matrix"; then
    echo "FAIL: role matrix is missing the $role responsibility section" >&2
    exit 1
  fi
done

for role in shopify-architect shopify-developer shopify-reviewer shopify-store-operator; do
  if ! grep -Fq 'references/methodology/delivery-guardrails.md' "$skills_root/$role/SKILL.md"; then
    echo "FAIL: $skills_root/$role/SKILL.md does not link to delivery guardrails" >&2
    exit 1
  fi
done

echo "PASS: every role links to documented responsibilities"
