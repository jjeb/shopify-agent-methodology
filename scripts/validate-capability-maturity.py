#!/usr/bin/env python3
"""Validate machine-readable capability maturity against the role matrix."""

from __future__ import annotations

import json
import re
import sys
from pathlib import Path


def section(text: str, heading: str) -> str:
    match = re.search(
        rf"^## {re.escape(heading)}$\n(?P<body>.*?)(?=^## |\Z)",
        text,
        re.MULTILINE | re.DOTALL,
    )
    if not match:
        raise ValueError(f"role matrix is missing section: {heading}")
    return match.group("body")


def main() -> int:
    repo_root = Path(__file__).resolve().parents[1]
    metadata_path = repo_root / "docs/methodology/capability-maturity.json"
    matrix_path = repo_root / "docs/methodology/role-matrix.md"
    failures: list[str] = []

    try:
        metadata = json.loads(metadata_path.read_text(encoding="utf-8"))
        matrix = matrix_path.read_text(encoding="utf-8")
    except (OSError, json.JSONDecodeError) as exc:
        print(f"FAIL: cannot read capability maturity sources: {exc}", file=sys.stderr)
        return 1

    tags = set(metadata.get("capability_tags", []))
    expected_tags = {"core", "supported", "experimental", "research-needed", "future-specialist"}
    if tags != expected_tags:
        failures.append(f"capability_tags must be {sorted(expected_tags)}, got {sorted(tags)}")

    role_tags = metadata.get("role_tags", {})
    role_capability_tags = metadata.get("role_capability_tags", {})
    if set(role_tags) != set(role_capability_tags):
        failures.append("role_tags and role_capability_tags must contain the same roles")
    for role, expected in role_tags.items():
        if expected != ["core"]:
            failures.append(f"{role}: installable role tag must be ['core']")
    for role, expected in role_capability_tags.items():
        if not set(expected) <= tags:
            failures.append(f"{role}: contains an unknown capability tag")

    try:
        role_sections = {role: section(matrix, role) for role in role_capability_tags}
    except ValueError as exc:
        failures.append(str(exc))
        role_sections = {}

    for role, expected in role_capability_tags.items():
        body = role_sections.get(role, "")
        role_match = re.search(r"\*\*Role tag:\*\*\s+`([^`]+)`", body)
        capability_match = re.search(
            r"\*\*Capability tags:\*\*\s+(.*?)(?:\n\n|\Z)",
            body,
            re.DOTALL,
        )
        if not role_match or role_match.group(1) != role_tags[role][0]:
            failures.append(f"{role}: role tag differs from capability-maturity.json")
        if not capability_match:
            failures.append(f"{role}: missing capability tags in role matrix")
        else:
            actual = set(re.findall(r"`([^`]+)`", capability_match.group(1)))
            if actual != set(expected):
                failures.append(
                    f"{role}: capability tags differ; expected {sorted(expected)}, got {sorted(actual)}"
                )

    coverage = metadata.get("platform_surfaces", [])
    expected_coverage = {item["name"]: item["capability_tag"] for item in coverage}
    if any(item.get("capability_tag") not in tags for item in coverage):
        failures.append("platform_surfaces contains an unknown capability tag")
    coverage_section = section(matrix, "Platform-surface capability coverage")
    actual_coverage = {}
    for line in coverage_section.splitlines():
        if not line.startswith("|") or line.startswith("| ---") or "Platform surface" in line:
            continue
        columns = [column.strip() for column in line.strip("|").split("|")]
        if len(columns) >= 3:
            tag_match = re.fullmatch(r"`([^`]+)`", columns[2])
            if tag_match:
                actual_coverage[columns[0]] = tag_match.group(1)
    if actual_coverage != expected_coverage:
        failures.append("platform surface capability tags differ from capability-maturity.json")
    if not re.search(r"ShopifyQL and aggregate analytics.*operational data\s+engineering", matrix, re.DOTALL):
        failures.append("role matrix is missing the ShopifyQL analytics boundary")
    if not metadata.get("analytics_boundary"):
        failures.append("metadata is missing analytics_boundary")

    if failures:
        for failure in failures:
            print(f"FAIL: {failure}", file=sys.stderr)
        return 1
    print("PASS: capability maturity metadata matches role matrix")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
