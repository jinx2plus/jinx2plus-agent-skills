# Figure accessibility review checklist

- Are labels, legends, units, chart title and all essential marks present and not clipped at final export size?
- Is each mark evaluated against the actual adjacent color, not only assumed pure white?
- Are normal body labels at least 4.5:1 and essential graphical boundaries at least 3:1 where applicable? Large text AA may use 3:1.
- Does every series have redundant labels/markers/linestyles, especially similar colors or color-vision-deficiency warnings?
- Does sequential encoding show monotonically ordered magnitude and a readable colorbar? Is diverging encoding actually centered on a meaningful baseline?
- Do risk/severity/signal-state maps follow their domain's established semantics? Sports palette colors must not recode safety categories arbitrarily.
- Are original source colors differentiated from derivatives created for accessible display?
- Were figures checked at target size and at least once in grayscale?
- Are sources/years of claimed team branding provided, and are logo/trademark rights respected?

Outputs: affected location, contrast ratio if relevant, severity, concrete improvement, automated vs manual evidence, unverified assumptions.
