#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
skills_root="$repo_root/skills"
required_skills=(
  shopify-expert
  shopify-architect
  shopify-developer
  shopify-data-engineer
  shopify-store-operator
  shopify-reviewer
)

failures=0

if [[ ! -d "$skills_root" ]]; then
  echo "FAIL: missing $skills_root" >&2
  exit 1
fi

for skill in "${required_skills[@]}"; do
  file="$skills_root/$skill/SKILL.md"
  if [[ ! -f "$file" ]]; then
    echo "FAIL: missing $file" >&2
    failures=$((failures + 1))
    continue
  fi

  if ! grep -q '^---$' "$file"; then
    echo "FAIL: $file has no YAML frontmatter" >&2
    failures=$((failures + 1))
  fi
  if ! grep -q '^name: ' "$file" || ! grep -q '^description: Use when ' "$file"; then
    echo "FAIL: $file has invalid required frontmatter" >&2
    failures=$((failures + 1))
  fi
  declared_name="$(sed -n 's/^name: //p' "$file" | head -n 1)"
  if [[ "$declared_name" != "$skill" ]]; then
    echo "FAIL: $file declares name '$declared_name' (expected '$skill')" >&2
    failures=$((failures + 1))
  fi
  for heading in '## When to Use' '## Operating Rules' '## Handoffs'; do
    if ! grep -q "$heading" "$file"; then
      echo "FAIL: $file is missing heading: $heading" >&2
      failures=$((failures + 1))
    fi
  done
  for contract_heading in '## Owns' '## Do Not Use For' '## Requires' '## Produces' '## Safety Gates'; do
    if ! grep -q "$contract_heading" "$file"; then
      echo "FAIL: $file is missing contract heading: $contract_heading" >&2
      failures=$((failures + 1))
    fi
  done
done

coordinator="$skills_root/shopify-expert/SKILL.md"
for coordinator_requirement in \
  'references/methodology/lifecycle.md' \
  'references/methodology/role-contract.md' \
  'references/methodology/handoff-record.md' \
  'references/methodology/delivery-guardrails.md' \
  'delivery brief' \
  'vertical slice' \
  'human checkpoint' \
  'explicit authorization'; do
  if ! grep -Fqi "$coordinator_requirement" "$coordinator"; then
    echo "FAIL: shopify-expert is missing coordinator requirement: $coordinator_requirement" >&2
    failures=$((failures + 1))
  fi
done

todo="$repo_root/BACKLOG.md"
for item in \
  'shopify-platform-engineer' \
  'shopify-commerce-strategist' \
  'storefront-engineer' \
  'extension-engineer' \
  'app-engineer' \
  'shopify-analytics'; do
  if [[ ! -f "$todo" ]] || ! grep -q "$item" "$todo"; then
    echo "FAIL: BACKLOG.md does not track $item" >&2
    failures=$((failures + 1))
  fi
done

if (( failures > 0 )); then
  exit 1
fi

python3 "$repo_root/scripts/sync-skill-references.py" --check
python3 "$repo_root/scripts/validate-skill-links.py"

echo "PASS: six MVP skills and future-role backlog are present and structurally valid"

if command -v skills-ref >/dev/null 2>&1; then
  echo "INFO: skills-ref found; running official Agent Skills validation"
  bash "$repo_root/scripts/validate-skills-standard.sh"
else
  echo "INFO: skills-ref not installed; run scripts/validate-skills-standard.sh for official spec validation"
fi
