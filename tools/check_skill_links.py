#!/usr/bin/env python3
"""Check that SKILL.md reference links point to existing bundled files."""

from __future__ import annotations

import re
import sys
from pathlib import Path


def main() -> int:
    root = Path(sys.argv[1]) if len(sys.argv) > 1 else Path.cwd()
    skill = root / "SKILL.md"
    if not skill.exists():
        print(f"Missing SKILL.md: {skill}", file=sys.stderr)
        return 1

    text = skill.read_text(encoding="utf-8")
    refs = sorted(set(re.findall(r"`(references/[^`]+?\.md)`", text)))
    missing = [ref for ref in refs if not (root / ref).is_file()]

    if missing:
        print("Missing referenced files:", file=sys.stderr)
        for ref in missing:
            print(f"- {ref}", file=sys.stderr)
        return 1

    print(f"All referenced files exist ({len(refs)} checked).")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
