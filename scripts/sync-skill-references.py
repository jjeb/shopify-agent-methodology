#!/usr/bin/env python3
"""Synchronize canonical methodology documents into each installable skill."""

from __future__ import annotations

import argparse
import filecmp
import shutil
import sys
from pathlib import Path


ROLES = (
    "shopify-expert",
    "shopify-architect",
    "shopify-developer",
    "shopify-data-integration-engineer",
    "shopify-store-operator",
    "shopify-reviewer",
)
METHODOLOGY_FILES = (
    "role-matrix.md",
    "role-contract.md",
    "lifecycle.md",
    "handoff-record.md",
    "delivery-guardrails.md",
)
EXPERT_ONLY_FILES = ("coordination.md",)


def expected_files(repo_root: Path):
    canonical_root = repo_root / "docs" / "methodology"
    for role in ROLES:
        destination_root = repo_root / "skills" / role / "references" / "methodology"
        filenames = METHODOLOGY_FILES + (EXPERT_ONLY_FILES if role == "shopify-expert" else ())
        for filename in filenames:
            yield canonical_root / filename, destination_root / filename


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--check", action="store_true", help="fail when generated copies are missing or stale")
    args = parser.parse_args()
    repo_root = Path(__file__).resolve().parents[1]
    failures = []

    for source, destination in expected_files(repo_root):
        if not source.is_file():
            failures.append(f"missing canonical source: {source.relative_to(repo_root)}")
            continue
        if args.check:
            if not destination.is_file():
                failures.append(f"missing generated reference: {destination.relative_to(repo_root)}")
            elif not filecmp.cmp(source, destination, shallow=False):
                failures.append(f"stale generated reference: {destination.relative_to(repo_root)}")
        else:
            destination.parent.mkdir(parents=True, exist_ok=True)
            shutil.copyfile(source, destination)

    if failures:
        for failure in failures:
            print(f"FAIL: {failure}", file=sys.stderr)
        return 1

    mode = "checked" if args.check else "synchronized"
    print(f"PASS: skill methodology references {mode}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
