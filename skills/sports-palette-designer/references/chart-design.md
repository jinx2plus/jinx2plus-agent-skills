# Chart semantics and color selection

## Categorical

Use distinct hues for unordered entities such as intersections or companies. One color per series, stable across panels and exports. Legends or direct labels identify series; color must not be the only distinction for essential information. Screen/print contrast may require different colors from exact club branding.

## Sequential

Use ordered lightness for magnitudes (e.g. 0–100 vehicles/minute). Keep hue mostly consistent and follow monotonic lightness. Check that the minimum data level remains visible above the background, and include legend ticks/numeric labels. Do not use a categorical team palette as if its colors are naturally ordered.

## Diverging

Only use when the center has semantic meaning (e.g. difference from baseline, centered on zero). Use comparable contrast on both sides and neutral center; set color limits symmetrically if the analysis requires symmetric interpretation. Two team brand hues are not automatically perceptually balanced; check the actual chart.

## Traffic safety

Preserve existing severe/warning/caution/normal conventions, threshold definitions, legends and organizational style guides for collision risk, signal states and emergency mapping. Do not replace them with sports team hues. Apply team colors instead to nonsemantic title bars, borders and neutral visual identity.

## Figure QA

Render at intended size. Inspect label collisions, axis scaling, legends, monochrome output, line styles and perception at normal zoom. Record raw palette ID, adjusted colors, background and any warnings.
