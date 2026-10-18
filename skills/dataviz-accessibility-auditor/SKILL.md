---
name: dataviz-accessibility-auditor
description: Review data visualization color contrast, color-vision-deficiency differentiation, redundant encodings and semantic color correctness. Trigger for accessibility audits of Matplotlib/Plotly charts, sports team color combinations, dashboard figures, presentation charts, scientific plots and thematic transport maps.
---

# Data Visualization Accessibility Auditor

Audit the *actual output* and underlying palettes. Use this skill after `sports-palette-designer` or when a user asks whether existing figures are readable/accessibility-compliant. Read `references/audit-checklist.md` for the review sequence.

## Audit procedure

1. Capture intended viewing context: actual canvas background(s), light/dark, font size, projector vs print, and user-important data elements. If a graphic or SVG is supplied, inspect it directly before relying on static HEX lists.
2. Identify categorical/sequential/diverging data encoding. Check whether the colors have defined public-safety meaning; mark arbitrary semantic overrides as errors.
3. Use `contrast_ratio(text, background)` for ordinary text (AA 4.5:1) or essential graphical marks against their adjacent background (target 3:1). Thresholds are *not* universal to every decorative element or adjacent category pair.
4. Call `audit_palette(colors, background=...)` from `sports_colors` **only after verifying that the installed version exposes this API**. The library [PR #1](https://github.com/jinx2plus/sports-team-colors/pull/1) has been merged. Use tested merge commit `caff63869e7f6c74f33de03c4d46d0e27907a4bc`, pinned and verified with the installation/API import command in the root README. The required APIs are now available on `main`; this pin protects against future changes. Read `issues`, including `graphics_contrast`, `duplicate`, `similar_colors`, and `cvd_similarity`. The CVD and OKLab warnings are approximations only.
5. Verify series remain distinguishable with direct labels, patterns, markers, line styles and legends. All chart users should be able to identify which data each color represents without relying on hue alone.
6. Render at target size, inspect label clipping/overlap, monitor contrast, grayscale, and any printed or projected output. Do not claim a chart is WCAG-conformant from a numeric palette audit alone.
7. Report precise findings with: severity, affected colors/element, contrast ratio when calculable, data-interpretation impact and the smallest appropriate fix. Preserve original team/source colors; adjust rendering variants only.

## Python quick audit

```python
from sports_colors import audit_palette, contrast_ratio
colors = ['#552583', '#FDB927', '#FFFFFF']
report = audit_palette(colors, background='#FFFFFF')
for issue in report.issues:
    print(issue.severity, issue.code, issue.colors, issue.message)
print('Purple/white:', round(contrast_ratio('#552583', '#FFFFFF'), 2))
```

Use `report.passed` **only** as "no error-level issues in these specific automated tests." It does not mean the full visualization is accessible.

## Deliverable

Provide a concise **pass/needs-fix** table, distinguishing objective contrast failures from heuristic CVD warnings, and give code or design changes where possible. If the rendered output was not inspected, mark visual review as pending.
