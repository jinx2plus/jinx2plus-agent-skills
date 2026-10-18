---
name: sports-palette-designer
description: Design Python Matplotlib/Plotly charts, dashboards, reports and slides with carefully assigned sports-team-inspired colors. Use when asked for color combinations, sports team palettes, chart styling, data visualization themes, dashboard design, or polished figure aesthetics. Keep source team colors separate from adjusted display colors, and select categorical/sequential/diverging encoding based on the data.
---

# Sports Palette Designer

Design chart palettes using the `jinx2plus/sports-team-colors` Python library. The palette is *inspired* by sports teams; it is not an official team-sponsored design guideline. Load `references/chart-design.md` for the chart semantic rules and `references/color-theory.md` for the visual system.

## Working procedure

1. **Understand the data before choosing color:** categorical series, ordered magnitude, or signed deviations around a meaningful reference. Determine whether existing semantic colors (accident severity, traffic signal status, risk grades) are prescribed; those override this skill.
2. **Locate the library:** use an existing installed `sports_colors` module or a local checkout of `https://github.com/jinx2plus/sports-team-colors`. Never assume it is installed and never execute unreviewed remote Python source. If missing, explain installation or use a local dependency-aware fallback without inventing team HEX codes.
3. **Choose an actual team ID**, e.g. `nba-lakers`, preferably stated by the user. If unspecified, select a named catalog entry and explain why the hues suit the data and audience. Do not treat other brands' color guidelines as official sports branding.
4. **Request an appropriate palette** with `get_palette(team, chart_type=..., n_colors=..., theme='light'|'dark', accessibility='wcag-aa')`. For the original four colors use `get_team_colors(team)`; `get_palette` may adjust rendering colors without changing source data.
5. **Design the surrounding visuals:** neutral background, foreground text, chart labels, hierarchy, gridlines, legends, annotations, whitespace and print-safe output. Use one or two emphasis colors deliberately; do not spray all four colors across unrelated UI elements.
6. **Run the auditor:** `audit_palette(palette.colors, background=palette.background)` and review `palette.warnings`. Adjust patterns, markers, direct labels and line styles if colors are insufficiently distinguishable.
7. **Render and inspect the actual output** in its target size (print/PPT/mobile). Verify legibility at 100% and in greyscale; do not claim full accessibility based only on contrast ratios.
8. **Report provenance and transformations:** which sports team, raw vs derived HEX codes, reason for chart type, contrast warnings and manual review still needed.

## Quick example

```python
from sports_colors import get_palette, audit_palette, matplotlib_rc
import matplotlib.pyplot as plt

palette = get_palette('nba-lakers', chart_type='categorical', n_colors=3,
                      theme='light', accessibility='wcag-aa')
with plt.rc_context(matplotlib_rc(palette)):
    fig, ax = plt.subplots()
    ax.bar(['A', 'B', 'C'], [12, 8, 5], color=palette.colors)
    ax.set_ylabel('Mean delay (s)')
    fig.tight_layout()
    fig.savefig('chart.png', dpi=180)
    plt.close(fig)
print(palette.warnings)
print(audit_palette(palette.colors, background=palette.background).issues)
```

Plotly: `fig.update_layout(**plotly_layout(palette))` from `sports_colors`. Optional dependencies: Matplotlib plus cycler (via Matplotlib); Plotly for Plotly usage.

## Non-negotiable guardrails

- Official team color values remain distinct from output-facing colors. `get_palette(...).original_colors` is source data; `.colors` are display colors.
- Avoid assigning arbitrary team colors to ordered risk or public-safety categories. Use agency-standard thresholds; style nonsemantic chrome only.
- Do not equate a 3:1 contrast against a background with pairwise discrimination, text legibility, or complete WCAG compliance.
- For more than four categories, generated hues are *not* official sports branding. Prefer direct labels and redundant encoding for important findings.
- Recheck source/season/logo usage rights for published branding. This repository does not grant trademark rights.

## Deliverable checklist

State chosen team, semantic chart type, light/dark background, whether values were adjusted, contrast or color-vision warnings, and the output file or reproducible source. Until [sports-team-colors PR #1](https://github.com/jinx2plus/sports-team-colors/pull/1) is merged, install the library from pinned commit `333f3ca41d0c91a2c25cbae69ec695b6a7a10a9c` (branch `feat/chart-aware-palettes-20261019`), not `main`. Follow the exact checkout and import verification in this repository's README. Read [version-matched usage docs](https://github.com/jinx2plus/sports-team-colors/blob/333f3ca41d0c91a2c25cbae69ec695b6a7a10a9c/docs/USAGE.md). Once released, update the documented revision rather than assuming that any `main` checkout provides the required API.
