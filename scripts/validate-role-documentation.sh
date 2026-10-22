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

for required_tag in core supported experimental research-needed future-specialist; do
  if ! grep -Fq "\`$required_tag\`" "$matrix"; then
    echo "FAIL: role matrix is missing capability tag: $required_tag" >&2
    exit 1
  fi
done
if ! grep -Fq '## Capability maturity model' "$matrix" || ! grep -Fq '## Platform-surface capability coverage' "$matrix"; then
  echo "FAIL: role matrix is missing canonical maturity or platform coverage sections" >&2
  exit 1
fi

for role in "${roles[@]}"; do
  skill="$skills_root/$role/SKILL.md"
  anchor="../../docs/methodology/role-matrix.md#$role"
  if ! grep -Fq "$anchor" "$skill"; then
    echo "FAIL: $skill does not link to its role documentation" >&2
    exit 1
  fi
  if ! grep -Fq "## $role" "$matrix"; then
    echo "FAIL: role matrix is missing the $role responsibility section" >&2
    exit 1
  fi
  if ! grep -Fq '## Capability maturity' "$skill"; then
    echo "FAIL: $skill is missing capability maturity documentation" >&2
    exit 1
  fi
done

for role in shopify-architect shopify-developer shopify-reviewer shopify-store-operator; do
  if ! grep -Fq '../../docs/methodology/delivery-guardrails.md' "$skills_root/$role/SKILL.md"; then
    echo "FAIL: $skills_root/$role/SKILL.md does not link to delivery guardrails" >&2
    exit 1
  fi
done

echo "PASS: every role links to documented responsibilities"
