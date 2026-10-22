#!/usr/bin/env python3
"""Validate the repository version, changelog, and optional release tag."""

from __future__ import annotations

import argparse
import re
import sys
from pathlib import Path


SEMVER = re.compile(
    r"^(0|[1-9]\d*)\.(0|[1-9]\d*)\.(0|[1-9]\d*)"
    r"(?:-[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?"
    r"(?:\+[0-9A-Za-z-]+(?:\.[0-9A-Za-z-]+)*)?$"
)


def main() -> int:
    parser = argparse.ArgumentParser(description=__doc__)
    parser.add_argument("--tag", help="also require a matching v-prefixed release tag")
    args = parser.parse_args()

    repo_root = Path(__file__).resolve().parents[1]
    version_path = repo_root / "VERSION"
    changelog_path = repo_root / "CHANGELOG.md"
    failures = []

    if not version_path.is_file():
        failures.append("missing VERSION")
        version = ""
    else:
        version = version_path.read_text(encoding="utf-8").strip()
        if not SEMVER.fullmatch(version):
            failures.append(f"VERSION is not valid SemVer: {version!r}")

    if not changelog_path.is_file():
        failures.append("missing CHANGELOG.md")
    else:
        changelog = changelog_path.read_text(encoding="utf-8")
        if "## [Unreleased]" not in changelog:
            failures.append("CHANGELOG.md is missing the Unreleased section")
        if version and f"## [{version}]" not in changelog:
            failures.append(f"CHANGELOG.md is missing a section for {version}")

    if args.tag and args.tag != f"v{version}":
        failures.append(f"release tag {args.tag!r} does not match VERSION {version!r}")

    if failures:
        for failure in failures:
            print(f"FAIL: {failure}", file=sys.stderr)
        return 1

    suffix = f" and tag {args.tag}" if args.tag else ""
    print(f"PASS: version {version}{suffix} is valid")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
