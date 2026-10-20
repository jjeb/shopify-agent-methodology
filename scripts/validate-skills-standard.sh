#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v skills-ref >/dev/null 2>&1; then
  cat >&2 <<'EOF'
FAIL: skills-ref is not installed.

Install the official Agent Skills reference validator, then retry:

  python -m venv .venv
  .venv/bin/python -m pip install \
    "git+https://github.com/agentskills/agentskills.git#subdirectory=skills-ref"
  bash scripts/validate-skills-standard.sh
EOF
  exit 2
fi

for skill_dir in "$repo_root"/skills/*; do
  [[ -d "$skill_dir" ]] || continue
  echo "Validating ${skill_dir#"$repo_root"/}"
  skills-ref validate "$skill_dir"
done

echo "PASS: all skills satisfy the Agent Skills specification"
