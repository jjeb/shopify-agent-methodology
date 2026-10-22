#!/usr/bin/env python3
"""Validate relative Markdown links inside the installable skills package."""

from __future__ import annotations

import re
import sys
from pathlib import Path


LINK_PATTERN = re.compile(r"!?(?:\[[^\]]*\])\(([^)]+)\)")


def main() -> int:
    repo_root = Path(__file__).resolve().parents[1]
    skills_root = repo_root / "skills"
    failures = []

    for markdown_file in sorted(skills_root.rglob("*.md")):
        text = markdown_file.read_text(encoding="utf-8")
        for raw_target in LINK_PATTERN.findall(text):
            target = raw_target.strip().split(maxsplit=1)[0].strip("<>")
            if not target or target.startswith(("#", "http://", "https://", "mailto:")):
                continue
            target_path = target.split("#", 1)[0]
            if not target_path:
                continue
            resolved = (markdown_file.parent / target_path).resolve()
            try:
                resolved.relative_to(skills_root.resolve())
            except ValueError:
                failures.append(f"{markdown_file.relative_to(repo_root)}: link escapes skills/: {target}")
                continue
            if not resolved.is_file():
                failures.append(f"{markdown_file.relative_to(repo_root)}: missing target: {target}")

    if failures:
        for failure in failures:
            print(f"FAIL: {failure}", file=sys.stderr)
        return 1

    print("PASS: all relative Markdown links under skills/ resolve")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
