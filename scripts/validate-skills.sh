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
  for heading in '## When to Use' '## Operating Rules' '## Handoffs'; do
    if ! grep -q "$heading" "$file"; then
      echo "FAIL: $file is missing heading: $heading" >&2
      failures=$((failures + 1))
    fi
  done
done

todo="$repo_root/BACKLOG.md"
for item in \
  'shopify-platform-engineer' \
  'shopify-commerce-strategist' \
  'storefront-engineer' \
  'extension-engineer' \
  'app-engineer'; do
  if [[ ! -f "$todo" ]] || ! grep -q "$item" "$todo"; then
    echo "FAIL: BACKLOG.md does not track $item" >&2
    failures=$((failures + 1))
  fi
done

if (( failures > 0 )); then
  exit 1
fi

echo "PASS: six MVP skills and future-role TODO are present and structurally valid"
