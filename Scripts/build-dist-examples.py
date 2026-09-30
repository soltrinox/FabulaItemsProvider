#!/usr/bin/env python3
"""Deterministic bulk extractor: Fabula Items -> Dist/Examples + manifests + provenance."""
from __future__ import annotations

import hashlib
import json
import re
import shutil
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
INVENTORY = ROOT / "Dist/Inventory/components.json"
EXAMPLES = ROOT / "Dist/Examples"
COMPONENTS = ROOT / "Dist/Components"
FOUNDATION = ROOT / "Dist/Foundation"
THEME = ROOT / "Dist/Theme"
REJECTED_OUT = ROOT / "Dist/Inventory/rejected-dispositions.json"
PROVENANCE = ROOT / "Dist/Provenance/catalog.json"
MANIFESTS = ROOT / "Manifests"

MIT_HEADER = "// MIT \u00a9 2022 jasudev \u2014 adapted for Fabula Dist toolkit\n"

HANDCRAFTED_COMPONENT_NAMES = {
    "FabulaFormSection", "FabulaPickerRow", "FabulaSecureEntryRow", "FabulaPrivateTextField",
    "FabulaRoundedTextFieldStyle", "FabulaDisclosureSection", "FabulaBoundedStepper",
    "FabulaSelectionGrid", "FabulaMinimalProgress", "FabulaConfirmationModifier",
    "FabulaCheckbox", "FabulaSwitch", "FabulaRadioGroup", "FabulaDebouncedText",
    "FabulaSubstringHighlighter", "FabulaShareLinkRow",
}

PASS_PLUS_COMPONENTS = [
    "FormSection", "PickerRow", "SecureEntryRow", "PrivateTextField",
    "RoundedTextFieldStyle", "DisclosureSection", "BoundedStepper", "SelectionGrid",
    "MinimalProgress", "ConfirmationModifier", "Checkbox", "Switch", "RadioGroup",
    "DebouncedText", "SubstringHighlighter", "ShareLinkRow",
]

THIRD_PARTY_IMPORTS = {
    "Alamofire", "SDWebImageSwiftUI", "SDWebImage", "UnsplashProvider", "Scroller",
    "AnimateText", "LottieUI", "Lottie", "AxisSheet", "AxisRatingBar",
    "AxisContribution", "AxisTooltip", "AxisTabView", "AxisSegmentedView",
}

THIRD_PARTY_IMPORT_RE = re.compile(
    r"^import\s+("
    + "|".join(re.escape(x) for x in sorted(THIRD_PARTY_IMPORTS, key=len, reverse=True))
    + r"|Axis\w+)\b",
    re.M,
)

FABULA_COLOR_MAP = {
    "fabulaPrimary": "primary", "fabulaSecondary": "secondary",
    "fabulaBack0": "back0", "fabulaBack1": "back1", "fabulaBack2": "back2",
    "fabulaFore1": "fore1", "fabulaFore2": "fore2",
    "fabulaBar1": "bar1", "fabulaBar2": "bar2",
    "fabulaForeWB100": "foreWB100", "fabulaBackWB100": "backWB100",
}

LOCAL_THEME_BLOCK = """
fileprivate enum LocalTheme {
    static let primary = Color(red: 0.969, green: 0.475, blue: 0.278)
    static let secondary = Color(red: 0.122, green: 0.753, blue: 0.843)
    static let back0 = Color(red: 0.980, green: 0.980, blue: 0.980)
    static let back1 = Color(red: 0.941, green: 0.941, blue: 0.941)
    static let back2 = Color(red: 0.902, green: 0.902, blue: 0.902)
    static let fore1 = Color(red: 0.125, green: 0.125, blue: 0.196)
    static let fore2 = Color(red: 0.565, green: 0.561, blue: 0.580)
    static let bar1 = Color(red: 0.952, green: 0.952, blue: 0.956)
    static let bar2 = Color(red: 0.894, green: 0.897, blue: 0.895)
    static let foreWB100 = Color.black
    static let backWB100 = Color.white
}
"""

LOCAL_DEVICE_BLOCK = """
#if canImport(UIKit)
import UIKit
fileprivate enum LocalDevice {
    static var isPad: Bool { UIDevice.current.userInterfaceIdiom != .phone }
}
#else
fileprivate enum LocalDevice {
    static var isPad: Bool { false }
}
#endif
"""

LOCAL_HAPTICS_BLOCK = """
#if canImport(UIKit)
fileprivate enum LocalHaptics {
    static func impact(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .soft) {
        let g = UIImpactFeedbackGenerator(style: style)
        g.prepare()
        g.impactOccurred()
    }
}
#else
fileprivate enum LocalHaptics {
    static func impact() {}
}
#endif
"""


def sha256_text(s: str) -> str:
    return hashlib.sha256(s.encode()).hexdigest()


def sha256_file(p: Path) -> str:
    return hashlib.sha256(p.read_bytes()).hexdigest()


def adapt_source(text: str, item_id: int) -> str | None:
    if THIRD_PARTY_IMPORT_RE.search(text):
        return None
    if "adaptiveAxisSheet" in text:
        return None
    needs_theme = any(k in text for k in FABULA_COLOR_MAP)
    needs_device = bool(re.search(r"\bisPad\b", text))
    needs_haptics = "vibration(" in text

    body = text
    body = re.sub(r"^(?://[^\n]*\n)+", "", body)
    body = re.sub(r"^(?:import\s+\w+\s*\n)+", "", body)
    body = re.sub(r"^#if canImport\(UIKit\)\nimport UIKit\n#endif\n", "", body, flags=re.M)

    for old, new in FABULA_COLOR_MAP.items():
        body = body.replace(f"Color.{old}", f"LocalTheme.{new}")
        body = re.sub(rf"(?<!LocalTheme)\.{old}\b", f"LocalTheme.{new}", body)
    body = body.replace("Color.LocalTheme.", "LocalTheme.")
    body = body.replace("LocalTheme.LocalTheme.", "LocalTheme.")
    body = re.sub(r"\bvibration\(", "LocalHaptics.impact(", body)
    body = re.sub(r"(?<!LocalDevice\.)\bisPad\b", "LocalDevice.isPad", body)
    body = re.sub(r"^\s*print\([^\n]*\)\s*$", "        // print removed", body, flags=re.M)
    body = re.sub(r"(?<![\w.])print\([^;\n]*\)", "()", body)
    body = body.replace("Bundle.module", "Bundle.main")
    body = re.sub(r"\bstruct\s+P(\d+)_([A-Za-z0-9_]+)\b", r"struct FabulaExample\1_\2", body)
    body = re.sub(r"\bP(\d+)_([A-Za-z0-9_]+)\(", r"FabulaExample\1_\2(", body)

    sys_imports = re.findall(r"^import\s+(\w+)\s*$", text, re.M)
    allowed = {
        "SwiftUI", "Foundation", "Combine", "CoreGraphics", "QuartzCore", "MapKit",
        "SpriteKit", "SceneKit", "AVKit", "PhotosUI", "Charts", "OSLog", "CryptoKit",
        "CoreImage", "CoreMotion", "GameController", "WebKit", "PDFKit",
    }
    for imp in sys_imports:
        if imp in THIRD_PARTY_IMPORTS or imp.startswith("Axis") or imp in ("Lottie", "LottieUI", "SDWebImage"):
            return None
    import_lines = ["import SwiftUI"]
    for imp in sys_imports:
        if imp in allowed and imp != "SwiftUI" and imp != "UIKit":
            if f"import {imp}" not in import_lines:
                import_lines.append(f"import {imp}")
        elif imp == "UIKit":
            pass

    head = MIT_HEADER + f"// Upstream id: P{item_id}\n// Adapted: local theme; print removed; no third-party.\n\n"
    head += "\n".join(import_lines) + "\n"
    if needs_device or needs_haptics or "UIKit" in sys_imports:
        head += LOCAL_DEVICE_BLOCK
    if needs_haptics:
        head += LOCAL_HAPTICS_BLOCK
    if needs_theme:
        head += LOCAL_THEME_BLOCK
    return head + "\n" + body


def folder_name_for(row: dict) -> str:
    stub = re.sub(r"[^A-Za-z0-9_]", "", str(row.get("title") or "").replace(" ", ""))
    if not stub:
        stub = re.sub(r"^P\d+_", "", row["filename"].replace(".swift", ""))
    return f"P{row['id']}_{stub}"[:100]


def main() -> None:
    data = json.loads(INVENTORY.read_text())
    rows = data["components"]
    EXAMPLES.mkdir(parents=True, exist_ok=True)
    MANIFESTS.mkdir(parents=True, exist_ok=True)

    for child in list(EXAMPLES.iterdir()):
        if child.is_dir() and re.match(r"P\d+_", child.name):
            shutil.rmtree(child)

    extracted = []
    rejected = []
    pattern_only = []

    for row in rows:
        disp = row["disposition"]
        item_id = row["id"]
        filename = row["filename"]
        src = ROOT / row["source_path"]

        if disp in ("third-party-reference", "reject"):
            rejected.append({
                "id": item_id, "filename": filename, "disposition": disp,
                "reasons": row.get("rejection_reasons", []),
                "external_dependencies": row.get("external_dependencies", []),
                "extraction_status": "inventory_only",
            })
            continue
        if disp == "pattern-only":
            pattern_only.append({
                "id": item_id, "filename": filename, "disposition": disp,
                "reasons": row.get("rejection_reasons", []),
                "extraction_status": "pattern_documented",
            })
            continue

        if not src.exists():
            rejected.append({
                "id": item_id, "filename": filename, "disposition": "reject",
                "reasons": ["missing_source_file"], "extraction_status": "inventory_only",
            })
            continue

        text = src.read_text(errors="replace")
        if THIRD_PARTY_IMPORT_RE.search(text):
            rejected.append({
                "id": item_id, "filename": filename, "disposition": "third-party-reference",
                "reasons": ["third_party_import_in_source"], "extraction_status": "inventory_only",
            })
            continue

        adapted = adapt_source(text, item_id)
        if adapted is None:
            rejected.append({
                "id": item_id, "filename": filename, "disposition": "reject",
                "reasons": ["adapt_failed_or_axis_helper"], "extraction_status": "inventory_only",
            })
            continue

        fname = folder_name_for(row)
        out_dir = EXAMPLES / fname
        out_dir.mkdir(parents=True, exist_ok=True)
        (out_dir / f"{fname}.swift").write_text(adapted)
        meta = {
            "id": item_id, "filename": filename, "disposition": disp,
            "upstream_sha256": row.get("sha256"),
            "adapted_sha256": sha256_text(adapted),
            "adaptation": "theme_local_tokens;print_removed;renamed_FabulaExample;no_third_party",
        }
        (out_dir / "metadata.json").write_text(json.dumps(meta, indent=2) + "\n")
        extracted.append({"id": item_id, "folder": fname, "disposition": disp})

    REJECTED_OUT.write_text(json.dumps({
        "rejected": rejected,
        "pattern_only": pattern_only,
        "counts": {
            "rejected": len(rejected),
            "pattern_only": len(pattern_only),
            "examples_extracted": len(extracted),
        },
    }, indent=2) + "\n")

    catalog_entries = []
    for base, kind in [(FOUNDATION, "foundation"), (THEME, "theme"), (COMPONENTS, "component"), (EXAMPLES, "example")]:
        if not base.exists():
            continue
        for f in sorted(base.rglob("*.swift")):
            entry = {
                "dist_path": str(f.relative_to(ROOT / "Dist")),
                "kind": kind,
                "sha256": sha256_file(f),
                "license": "MIT",
                "copyright": "Copyright (c) 2022 jasudev",
            }
            md = f.parent / "metadata.json"
            if md.exists():
                mdata = json.loads(md.read_text())
                if "upstream_ids" in mdata:
                    entry["upstream_ids"] = mdata["upstream_ids"]
                    entry["adaptation"] = "handcrafted_production_api"
                elif "id" in mdata:
                    entry["upstream_id"] = mdata["id"]
                    entry["upstream_sha256"] = mdata.get("upstream_sha256")
                    entry["adaptation"] = mdata.get("adaptation", "bulk_example_adapt")
            catalog_entries.append(entry)

    lic = ROOT / "Dist/Provenance/LICENSE"
    PROVENANCE.write_text(json.dumps({
        "license_file": "Dist/Provenance/LICENSE",
        "license_present": lic.exists(),
        "entry_count": len(catalog_entries),
        "entries": catalog_entries,
    }, indent=2) + "\n")

    component_names = sorted(d.name for d in COMPONENTS.iterdir() if d.is_dir() and (d / f"{d.name}.swift").exists())
    example_folders = sorted(d.name for d in EXAMPLES.iterdir() if d.is_dir())

    (MANIFESTS / "full.yaml").write_text(
        "name: fabula-dist-full\nfoundation:\n  - FabulaFoundation\ntheme:\n  - FabulaTheme\n"
        "components:\n" + "".join(f"  - {n}\n" for n in component_names)
        + "examples:\n" + "".join(f"  - {n}\n" for n in example_folders)
    )
    (MANIFESTS / "dependency-free.yaml").write_text(
        "name: fabula-dist-dependency-free\nnotes: Dist-only; no third-party.\n"
        "foundation:\n  - FabulaFoundation\ntheme:\n  - FabulaTheme\n"
        "components:\n" + "".join(f"  - {n}\n" for n in component_names)
        + "examples:\n" + "".join(f"  - {n}\n" for n in example_folders)
    )
    (MANIFESTS / "pass-plus.yaml").write_text(
        "name: pass-plus-fabula-vendor\nconsumer: PASS PLUS\ninclude_examples: false\n"
        "foundation:\n  - FabulaFoundation\ntheme:\n  - FabulaTheme\n"
        "components:\n" + "".join(f"  - Fabula{n}\n" for n in PASS_PLUS_COMPONENTS)
        + "examples_debug_only:\n" + "".join(f"  - Fabula{n}\n" for n in PASS_PLUS_COMPONENTS)
    )

    print(json.dumps({
        "examples_extracted": len(extracted),
        "rejected": len(rejected),
        "pattern_only": len(pattern_only),
        "components": len(component_names),
        "example_folders_total": len(example_folders),
        "provenance_entries": len(catalog_entries),
    }, indent=2))
    print("[PASS] build-dist-examples complete")


if __name__ == "__main__":
    main()
