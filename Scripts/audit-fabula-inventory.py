#!/usr/bin/env python3
"""Deterministic audit of all Fabula Items/*.swift files into Dist/Inventory/components.json."""
from __future__ import annotations

import hashlib
import json
import re
from collections import Counter
from pathlib import Path

ROOT = Path(__file__).resolve().parents[1]
ITEMS = ROOT / "Sources/FabulaItemsProvider/Items"
PROVIDER = ROOT / "Sources/FabulaItemsProvider/ItemsProvider.swift"
OUT = ROOT / "Dist/Inventory/components.json"

THIRD_PARTY = {
    "Alamofire",
    "SDWebImageSwiftUI",
    "SDWebImage",
    "UnsplashProvider",
    "Scroller",
    "AnimateText",
    "LottieUI",
    "AxisSheet",
    "AxisRatingBar",
    "AxisContribution",
    "AxisTooltip",
    "AxisTabView",
    "AxisSegmentedView",
}
FABULA_HELPERS = [
    "fabulaPrimary",
    "fabulaSecondary",
    "fabulaBack",
    "fabulaFore",
    "fabulaBar",
    "fabulaForeWB",
    "fabulaBackWB",
    "vibration(",
    "isPad",
    "adaptiveAxisSheet",
    "Bundle.module",
    "ItemsProvider",
    "FAnyView",
    "ItemData",
]
NETWORK_HINTS = [
    "URLSession",
    "Alamofire",
    "http://",
    "https://",
    "Unsplash",
    "SDWebImage",
]
PRIVACY_SENSITIVE_IDS = {151, 147, 44, 102, 279}
DEPRECATED_HINTS = [
    "disableAutocorrection(",
    "NavigationView",
    "@available",
]
PASS_SHORTLIST = {
    121,
    55,
    151,
    99,
    259,
    59,
    114,
    131,
    50,
    110,
    112,
    102,
    279,
    268,
    265,
    280,
    282,
    281,
}
HIGH_VALUE = {
    282,
    281,
    265,
    279,
    280,
    259,
    121,
    55,
    99,
    59,
    114,
    131,
    110,
    50,
}
REJECT_IDS = {147, 44, 203, 215, 201, 202}
URL_DEMO_IDS = {103, 117, 269}
PATTERN_ONLY_IDS = {112, 102, 151}


def main() -> None:
    provider_text = PROVIDER.read_text()
    registered = {int(x) for x in re.findall(r"ItemData\(id:\s*(\d+)", provider_text)}
    registered_views = set(
        re.findall(r"FAnyView\((P\d+_[A-Za-z0-9_]+)\(\)\)", provider_text)
    )

    rows: list[dict] = []
    for path in sorted(ITEMS.glob("*.swift")):
        text = path.read_text(errors="replace")
        sha = hashlib.sha256(text.encode()).hexdigest()
        fname = path.name
        m = re.match(r"P(\d+)_(.+)\.swift$", fname)
        item_id = int(m.group(1)) if m else None
        title_stub = m.group(2) if m else fname.replace(".swift", "")

        imports = re.findall(r"^import\s+(\w+)", text, re.M)
        third: list[str] = sorted(set(imports) & THIRD_PARTY)
        for tp in THIRD_PARTY:
            if re.search(rf"^import\s+{re.escape(tp)}\b", text, re.M) and tp not in third:
                third.append(tp)
        third = sorted(set(third))

        fabula_use = [h for h in FABULA_HELPERS if h in text]
        has_network = any(h in text for h in NETWORK_HINTS) or bool(
            set(third) & {"Alamofire", "UnsplashProvider", "SDWebImageSwiftUI"}
        )
        has_privacy = item_id in PRIVACY_SENSITIVE_IDS or any(
            h in text for h in ("SecureField", "AppStorage", "SceneStorage")
        )
        deprecated = [h for h in DEPRECATED_HINTS if h in text]

        entry_types = re.findall(r"public\s+struct\s+(\w+)", text)
        if not entry_types:
            entry_types = re.findall(r"^struct\s+(P\d+_\w+)", text, re.M)

        private_helpers = re.findall(
            r"(?:private|fileprivate)\s+(?:struct|enum|class|func|extension)\s+(\w+)",
            text,
        )

        platform = "both"
        if "import UIKit" in text or "UIKit" in imports:
            platform = "iOS-preferred"

        registered_in_provider = item_id in registered if item_id is not None else False
        view_name = entry_types[0] if entry_types else None
        view_registered = view_name in registered_views if view_name else False

        tags_in_provider: list[str] = []
        if item_id is not None:
            block = re.search(
                rf"ItemData\(id:\s*{item_id},(.*?)FAnyView\(", provider_text, re.S
            )
            if block:
                tm = re.search(r'tags:\s*"([^"]*)"', block.group(1))
                if tm:
                    tags_in_provider = [
                        t.strip() for t in tm.group(1).split(",") if t.strip()
                    ]
                title_m = re.search(r'title:\s*"([^"]*)"', block.group(1))
                if title_m:
                    title_stub = title_m.group(1)

        disposition = "example"
        rejection_reasons: list[str] = []
        tags = {
            "needs_theme": bool(fabula_use),
            "needs_resources": "Bundle.module" in text,
            "platform_specific": platform != "both",
            "network": has_network,
            "privacy_sensitive": has_privacy and item_id in PRIVACY_SENSITIVE_IDS,
            "modernization": bool(deprecated),
            "has_embedded_helpers": len(private_helpers) > 0,
            "third_party": bool(third),
        }

        clean_title = re.sub(r"[^A-Za-z0-9]", "", title_stub)
        proposed_name = f"Fabula{clean_title}" if clean_title else None

        if item_id in PASS_SHORTLIST or "component" in tags_in_provider:
            disposition = "component"

        if third:
            disposition = "third-party-reference"
            rejection_reasons.append(f"third_party:{','.join(third)}")
        elif item_id in REJECT_IDS:
            disposition = "reject"
            if item_id in {147, 44}:
                rejection_reasons.append("privacy:persistence_of_private_draft")
            else:
                rejection_reasons.append("network:remote_fetch_demo")

        if item_id in PATTERN_ONLY_IDS and disposition not in (
            "third-party-reference",
            "reject",
        ):
            disposition = "pattern-only"
            if item_id == 151:
                rejection_reasons.append("privacy:must_rewrite_no_secret_echo")

        if item_id in HIGH_VALUE and disposition not in (
            "third-party-reference",
            "reject",
            "pattern-only",
        ):
            disposition = "component"

        if disposition == "example" and (third or has_network):
            if third:
                disposition = "third-party-reference"
            else:
                disposition = "reject"
                rejection_reasons.append("network:url_or_remote")

        if item_id in URL_DEMO_IDS and disposition == "example":
            disposition = "reject"
            rejection_reasons.append("network:open_url_demo")

        if fname.startswith("P0_") or item_id == 0:
            disposition = "reject"
            rejection_reasons.append("unregistered_template")
            if item_id is None:
                item_id = 0

        if item_id == 50 and disposition == "component":
            rejection_reasons.append("demo_only:extract_minimal_progress_only")

        if item_id == 268 and disposition not in ("third-party-reference", "reject"):
            disposition = "pattern-only"
            rejection_reasons.append("use_native_ShareLink_rewrite")

        extraction_status = {
            "component": "approved_for_extraction",
            "example": "approved_for_example",
            "pattern-only": "pattern_documented",
            "third-party-reference": "inventory_only",
            "reject": "inventory_only",
        }[disposition]

        rows.append(
            {
                "id": item_id,
                "filename": fname,
                "source_path": str(path.relative_to(ROOT)),
                "public_entry_types": entry_types,
                "imports": imports,
                "platform_support": platform,
                "fabula_helper_use": fabula_use,
                "embedded_private_helpers": private_helpers[:40],
                "external_dependencies": third,
                "network_or_remote": has_network,
                "privacy_sensitive": tags["privacy_sensitive"],
                "deprecated_apis": deprecated,
                "provider_tags": tags_in_provider,
                "registered_in_provider": registered_in_provider,
                "view_registered": view_registered,
                "proposed_component_name": proposed_name
                if disposition
                in ("component", "example", "pattern-only")
                else None,
                "title": title_stub,
                "disposition": disposition,
                "extraction_status": extraction_status,
                "rejection_reasons": rejection_reasons,
                "tags": tags,
                "sha256": sha,
                "line_count": text.count("\n") + 1,
            }
        )

    file_ids = [r["id"] for r in rows if r["id"] is not None]
    dupes = [i for i, c in Counter(file_ids).items() if c > 1]
    missing_files = sorted(registered - set(file_ids))
    extra_unregistered = [r for r in rows if not r["registered_in_provider"]]
    stats = Counter(r["disposition"] for r in rows)

    summary = {
        "total_files": len(rows),
        "registered_ids_in_provider": len(registered),
        "disposition_counts": dict(stats),
        "duplicate_ids": dupes,
        "provider_ids_missing_files": missing_files,
        "unregistered_files": [
            {
                "id": r["id"],
                "filename": r["filename"],
                "disposition": r["disposition"],
            }
            for r in extra_unregistered
        ],
        "third_party_count": stats.get("third-party-reference", 0),
        "component_count": stats.get("component", 0),
        "example_count": stats.get("example", 0),
        "pattern_only_count": stats.get("pattern-only", 0),
        "reject_count": stats.get("reject", 0),
    }

    OUT.parent.mkdir(parents=True, exist_ok=True)
    OUT.write_text(json.dumps({"summary": summary, "components": rows}, indent=2) + "\n")
    print(json.dumps(summary, indent=2))
    print(f"Wrote {OUT}")
    if len(rows) != 287:
        raise SystemExit(f"[FAIL] expected 287 files, got {len(rows)}")
    if dupes:
        raise SystemExit(f"[FAIL] duplicate ids: {dupes}")
    print("[PASS] 287 rows, no duplicate IDs")


if __name__ == "__main__":
    main()
