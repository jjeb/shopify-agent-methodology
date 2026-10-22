#!/usr/bin/env bash
set -euo pipefail

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
readme="$repo_root/README.md"
getting_started="$repo_root/docs/getting-started.md"

for required in \
  "npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a claude-code -y" \
  "npx skills add jjeb/shopify-agent-methodology --skill '*' -g -a pi -y" \
  "npx skills add jjeb/shopify-agent-methodology --all"; do
  if ! grep -Fq "$required" "$getting_started" || ! grep -Fq "$required" "$readme"; then
    echo "FAIL: installation command is missing from README.md or docs/getting-started.md: $required" >&2
    exit 1
  fi
done

if ! command -v npx >/dev/null 2>&1; then
  echo "FAIL: npx is required for public skills CLI smoke tests" >&2
  exit 1
fi

temp_home="$(mktemp -d)"
trap 'rm -rf "$temp_home"' EXIT
export HOME="$temp_home"
export XDG_CONFIG_HOME="$temp_home/.config"
export XDG_CACHE_HOME="$temp_home/.cache"

if ! help_output="$(npx --yes skills add --help 2>"$temp_home/skills-cli-error.log")"; then
  if [[ "${CI:-}" == "true" ]]; then
    cat "$temp_home/skills-cli-error.log" >&2
    echo "FAIL: public skills CLI help could not be executed in CI" >&2
    exit 1
  fi
  echo "SKIP: public skills CLI unavailable locally; deterministic command checks passed" >&2
  cat "$temp_home/skills-cli-error.log" >&2
  exit 0
fi
for flag in '--skill' '--all' '-a' '-g' '-y'; do
  if ! grep -Fq -- "$flag" <<<"$help_output"; then
    echo "FAIL: public skills CLI does not advertise expected flag: $flag" >&2
    exit 1
  fi
done

echo "PASS: public skills CLI exposes safe Claude Code/Pi installation semantics"
