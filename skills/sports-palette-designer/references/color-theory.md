# Sports palette design notes

- Retain source team values as *data*, not a rigid guarantee that every combination is suitable for presentation or text.
- Backgrounds and typography are neutral infrastructure. Use team hues for high-value highlights and limited categorical series; avoid making every element saturated.
- The Python library uses an OKLCH-inspired lightness adjustment to meet the configured contrast target against a specified background. RGB clipping can shift perceived hue; inspect derived values.
- WCAG 2.x AA commonly requires 4.5:1 for normal text and 3:1 for large text; essential non-text visual boundaries need 3:1 against adjacent colors. These are context-dependent checks and do not by themselves prove chart accessibility.
- Pairwise perceptual difference and simulated CVD checks are **heuristics**, not standards. Supplement them with patterns, labels, points and line dashes.
- White-on-white, yellow-on-white and navy-on-black often fail as visible marks, even when the brand uses them legitimately on a contrasting surface.
- Cite the `SOURCES.md` of `jinx2plus/sports-team-colors`; a curated HEX catalogue is not proof of verified 2026 official color standards.
