#!/usr/bin/env python3
"""Manifest-driven sync from Fabula Dist -> consumer FabulaToolkit tree."""
from __future__ import annotations

import argparse
import hashlib
import json
import re
import shutil
import subprocess
import sys
from datetime import datetime, timezone
from pathlib import Path


def sha256_file(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def parse_simple_yaml_list(text: str, key: str) -> list[str]:
    lines = text.splitlines()
    out: list[str] = []
    in_key = False
    for line in lines:
        if re.match(rf"^{re.escape(key)}:\s*$", line):
            in_key = True
            continue
        if in_key:
            m = re.match(r"^  - (.+)$", line)
            if m:
                out.append(m.group(1).strip())
                continue
            if line and not line.startswith(" "):
                break
            if line.strip() == "":
                continue
            if line.startswith("  ") and not line.startswith("  -"):
                continue
            break
    return out


def git_head(repo: Path) -> str:
    try:
        return subprocess.check_output(
            ["git", "rev-parse", "HEAD"], cwd=repo, text=True
        ).strip()
    except Exception:
        return "unknown"


def collect_files(dist: Path, names: list[str], kind: str) -> list[tuple[Path, str]]:
    pairs: list[tuple[Path, str]] = []
    folder_map = {
        "foundation": "Foundation",
        "theme": "Theme",
        "components": "Components",
        "examples": "Examples",
    }
    base = dist / folder_map[kind]
    for name in names:
        if kind in ("foundation", "theme"):
            for f in base.glob("*.swift"):
                if f.stem == name or name in f.stem:
                    pairs.append((f, f"{folder_map[kind]}/{f.name}"))
        else:
            folder = base / name
            if not folder.is_dir():
                raise FileNotFoundError(
                    f"Missing Dist {kind} entry: {name} under {base}"
                )
            for f in folder.rglob("*"):
                if f.is_file() and f.suffix in (".swift", ".json"):
                    rel = f"{folder_map[kind]}/{name}/{f.relative_to(folder).as_posix()}"
                    pairs.append((f, rel))
    return pairs


def main() -> int:
    ap = argparse.ArgumentParser()
    ap.add_argument("--dist", required=True, type=Path)
    ap.add_argument("--manifest", required=True, type=Path)
    ap.add_argument("--dest", required=True, type=Path)
    ap.add_argument("--lockfile", required=True, type=Path)
    ap.add_argument("--apply", action="store_true")
    ap.add_argument("--check", action="store_true")
    ap.add_argument("--include-debug-examples", action="store_true")
    args = ap.parse_args()
    if args.apply == args.check:
        print("Specify exactly one of --apply or --check", file=sys.stderr)
        return 2

    dist = args.dist.resolve()
    manifest_text = args.manifest.read_text()
    foundation = parse_simple_yaml_list(manifest_text, "foundation") or [
        "FabulaFoundation"
    ]
    theme = parse_simple_yaml_list(manifest_text, "theme") or ["FabulaTheme"]
    components = parse_simple_yaml_list(manifest_text, "components")
    examples: list[str] = []
    if args.include_debug_examples or "include_examples: true" in manifest_text:
        examples = parse_simple_yaml_list(
            manifest_text, "examples_debug_only"
        ) or parse_simple_yaml_list(manifest_text, "examples")

    pairs: list[tuple[Path, str]] = []
    pairs += collect_files(dist, foundation, "foundation")
    pairs += collect_files(dist, theme, "theme")
    pairs += collect_files(dist, components, "components")
    if examples:
        pairs += collect_files(dist, examples, "examples")

    lic = dist / "Provenance" / "LICENSE"
    if lic.exists():
        pairs.append((lic, "Provenance/LICENSE"))

    expected = {
        rel: {"sha256": sha256_file(src), "source": str(src)} for src, rel in pairs
    }
    dest = args.dest.resolve()
    lock_path = args.lockfile.resolve()

    if args.apply:
        if dest.exists():
            shutil.rmtree(dest)
        dest.mkdir(parents=True)
        for src, rel in pairs:
            out = dest / rel
            out.parent.mkdir(parents=True, exist_ok=True)
            shutil.copy2(src, out)
            if out.suffix == ".swift":
                text = out.read_text()
                if "MIT" not in text and "jasudev" not in text.lower():
                    out.write_text(
                        "// MIT © 2022 jasudev — vendored FabulaToolkit\n" + text
                    )
        (dest / "GENERATED.md").write_text(
            "# FabulaToolkit (generated)\n\n"
            "Do not edit files in this tree by hand. "
            "Fix Dist upstream and re-run sync --apply.\n"
            f"Synced: {datetime.now(timezone.utc).isoformat()}\n"
        )
        lock = {
            "synced_at": datetime.now(timezone.utc).isoformat(),
            "upstream_commit": git_head(dist.parent),
            "manifest": str(args.manifest),
            "dest": str(dest),
            "files": {},
            "component_versions": {c: "1.0.0" for c in components},
            "include_debug_examples": bool(examples),
        }
        for _src, rel in pairs:
            p = dest / rel
            h = sha256_file(p)
            lock["files"][rel] = {"sha256": h, "generated_sha256": h}
        lock_path.parent.mkdir(parents=True, exist_ok=True)
        lock_path.write_text(json.dumps(lock, indent=2) + "\n")
        print(f"[PASS] sync --apply wrote {len(expected)} files -> {dest}")
        return 0

    errors: list[str] = []
    if not dest.exists():
        errors.append(f"missing dest tree: {dest}")
    if not lock_path.exists():
        errors.append(f"missing lockfile: {lock_path}")
    else:
        lock = json.loads(lock_path.read_text())
        locked = lock.get("files", {})
        for rel in expected:
            p = dest / rel
            if not p.exists():
                errors.append(f"missing: {rel}")
                continue
            h = sha256_file(p)
            want = locked.get(rel, {}).get("generated_sha256") or locked.get(rel, {}).get(
                "sha256"
            )
            if want and h != want:
                errors.append(f"modified: {rel}")
            if p.suffix == ".swift":
                t = p.read_text()
                if "MIT" not in t and "jasudev" not in t.lower():
                    errors.append(f"unlicensed: {rel}")
        if dest.exists():
            for p in dest.rglob("*"):
                if not p.is_file() or p.name == "GENERATED.md":
                    continue
                rel = p.relative_to(dest).as_posix()
                if rel not in expected:
                    errors.append(f"stale_extra: {rel}")
    if errors:
        print("[FAIL] sync --check")
        for e in errors[:40]:
            print(" ", e)
        return 1
    print(f"[PASS] sync --check ok ({len(expected)} files)")
    return 0


if __name__ == "__main__":
    sys.exit(main())
