# Dist Components Extraction — 2026-09-27

## Deliverable

Created 16 portable Fabula SwiftUI controls under `Dist/Components/<Name>/` with matching `Dist/Examples/<Name>/Example.swift` and `metadata.json`.

## Components

| Component | Upstream | Notes |
|-----------|----------|-------|
| FabulaFormSection | P121 | Form/Section wrapper |
| FabulaPickerRow | P55 | Labeled Picker + Binding |
| FabulaSecureEntryRow | P151 | No plaintext echo; optional local reveal |
| FabulaPrivateTextField | P99 | autocorrectionDisabled + content type |
| FabulaRoundedTextFieldStyle | P259 | Theme-token TextFieldStyle |
| FabulaDisclosureSection | P59 | DisclosureGroup + isExpanded Binding |
| FabulaBoundedStepper | P114 | ClosedRange + Binding (+ labeled helper) |
| FabulaSelectionGrid | P131 | LazyVGrid selection Binding |
| FabulaMinimalProgress | P50 | Minimal ProgressView only |
| FabulaConfirmationModifier | P110 | confirmationDialog ViewModifier |
| FabulaCheckbox | P279 | Accessible Button checkbox; no print |
| FabulaSwitch | P280 | Custom switch; theme.primary; no print |
| FabulaRadioGroup | P265 | Optional Hashable selection; no print |
| FabulaDebouncedText | P282 | Debounce ViewModifier; no print |
| FabulaSubstringHighlighter | P281 | AttributedString highlight helper |
| FabulaShareLinkRow | P268 | ShareLink for caller URL/text only |

## Issues

- `Dist/CONTRACT.md` was not present at extraction time (path missing).
- Dist tree is cursorignored; files written via Python/shell.
- Components depend on `FabulaTheme` / `fabulaTheme` environment from `Dist/Theme`.
