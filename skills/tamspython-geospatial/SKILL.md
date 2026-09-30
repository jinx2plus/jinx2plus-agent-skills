---
name: tamspython-geospatial
description: Guardrails and workflow for working in the TAMSPython repository on GeoPandas, PostGIS, DTG, node-link topology, and regional traffic-analysis scripts. Use when modifying or reviewing TAMSPython code that touches CRS conversion, spatial joins, large geospatial tables, `db_utils.py`, `geom_utils.py`, `tams_processing.py`, or dated pipeline scripts such as `INTEGRATED_MAIN_*`, `TAcalc_*`, `NODELINKID_*`, and `LINKID_*`.
---

# TAMSPython Geospatial

## Overview

Treat this repository as a geospatial script collection with a small set of shared invariants, not as a clean package. Optimize for correctness of CRS and topology first, then for large-scale runtime and memory behavior.

If the requested refactor direction is abstract or underspecified, ask a short clarifying question before changing behavior. If the current approach is technically weak, say so directly and replace it with a defensible alternative.

## Core Rules

1. Assume new processing should end in `EPSG:32652` unless the script clearly targets a different CRS for I/O compatibility.
2. Convert `EPSG:4326`, `EPSG:5179`, or `EPSG:5181` inputs before distance, buffer, nearest, or join logic.
3. Preserve node-link topology fields unless the user explicitly wants a schema change:
   `LINK_ID`, `F_NODE`, `T_NODE`, `oLINK_ID`, `NODE_ID`, `REPNODE_ID`, `NODETYPE`, `TYPEOF`, `IC_ID`, `IS_ID`.
   `LINK_ID` is an opaque string identifier: its only valid pandas dtype is `object`/`string` and its DB type is `text`/`varchar`. Normalize it before every join, filter, deduplication, comparison, or export; never cast it to integer or float, which can corrupt leading zeros, prefixes, suffixes, and separators.
4. Respect the dual geometry-column convention:
   in-memory GeoDataFrame work usually uses `geometry`, while DB or shapefile-facing code often uses `geom`.
5. Prefer existing helpers over ad-hoc rewrites:
   `db_utils.py`, `geom_utils.py`, `tams_processing.py`.
6. Never introduce a slower row-wise loop when a vectorized `pandas`/`GeoPandas`/`numpy`/`shapely` alternative exists.
7. For large DTG or regional processing, prefer chunked or sink-to-disk flows. Avoid giant in-memory concatenation.
8. Do not casually replace working import style inside legacy scripts. If a dated script uses old helpers, keep that style unless you are refactoring the whole flow.
9. Treat hardcoded DB connection values in the repo as existing sensitive configuration. Do not echo secrets in summaries or duplicate them into new files.

## Workflow

### 1. Build context from the real entry point

Locate the script the user is actually using first. In this repository, the newest dated file is often the active variant, but `_FINAL` and `_F` can override that assumption.

If the task is broad, inspect:
- `INTEGRATED_MAIN_*`
- `TAcalc_*`
- `NODELINKID_*`
- `LINKID_*`
- `drjm_*`
- `Step*` or `STEP*`

### 2. Check spatial invariants before editing

Before modifying logic, verify:
- input CRS and output CRS
- active geometry column name
- whether distances or buffers are in meters
- whether `sjoin`, `sjoin_nearest`, `overlay`, or `buffer` are being applied before CRS normalization
- whether a change could break representative-node or opposite-link logic

If you see topology-sensitive logic, explicitly protect:
- dummy-node synchronization via `REPNODE_ID`
- reverse-link matching via `oLINK_ID`
- stable node-link joins through `F_NODE` and `T_NODE`

### 3. Choose the fastest safe implementation

Use this priority order for large workloads:

1. existing vectorized `pandas`/`GeoPandas` merge or groupby
2. `shapely` spatial index or `STRtree`
3. chunked processing with incremental writes
4. DuckDB spatial or similar set-based execution if already present in the flow
5. Python loops only for small control logic or unavoidable topology edge cases

Avoid:
- `DataFrame.apply(..., axis=1)` on large tables
- repeated `concat` inside loops
- full-table `sjoin` when a cheap spatial prefilter or shard can narrow candidates first
- unnecessary geometry materialization when tabular operations are sufficient

## Repository-Specific Guidance

### CRS and geometry

- Use projected coordinates before `buffer`, `distance`, `centroid`, `sjoin_nearest`, or distance thresholds like 10m, 30m, 40m, 50m, 180m.
- Use `renamegeomto_geometry` or `renamegeometryto_geom` from `geom_utils.py` instead of manual one-off renames when a shared helper is already appropriate.
- When uploading to PostGIS, align with `upload_geodata` behavior: active geometry becomes `geom`, duplicate columns are removed, and 2D coercion may occur.

### Topology and classification

- `tams_processing.py` is the anchor for reusable node/link logic.
- `nodesandlinks()` and `findopposite()` assume stable identifiers; changing join keys or dedup strategy can silently corrupt downstream analytics.
- `fix_dummy_node_types()` depends on group-wise propagation inside `REPNODE_ID`; do not replace it with partial updates.
- `classify_planar_nodes()` uses distance-based semantics for `TYPEOF` A/B/C/F. Do not alter thresholds or IC inclusion rules without calling out the behavioral change.

### Regional behavior

Do not assume all CHUNG regions behave identically. Check whether the target script branches on:
- `IKSAN`
- `DAEJEON`
- `SH` or `SEOUL`
- `WONJU`
- `BUSAN`
- `SEJONG`

`SH/SEOUL` especially may have different source-field or buffer behavior.

## Refactoring Policy

When asked to refactor:

1. State the current bottleneck or risk in a `<thought>` block before editing.
2. Prefer performance over cosmetic readability in hot paths.
3. Preserve behavior unless the current behavior is clearly wrong or too expensive.
4. If a proposed change could alter topology, region semantics, or metric thresholds, say so explicitly.
5. If a fix requires a tradeoff between speed and exactness, choose the exact method unless the user asked for approximation.

## Verification

After edits, run the smallest relevant verification available. Prefer targeted checks over broad reruns.

Typical commands in this repository:

```powershell
python test_db_conn.py
python quick_test.py
python test_office.py
python sisul_parquet_analysis_final.py
python INTEGRATED_MAIN_260210.py --region IKSAN --dummy_radius 150 --cpx_radius 100
python TAcalc_TAMM_260203_forallCHUNG.py --chung IKSAN
```

Also verify:
- CRS is still `32652` where expected
- geometry column name matches the consumer
- row counts or ID uniqueness did not regress
- no new duplicate `LINK_ID`, `NODE_ID`, `IC_ID`, or `IS_ID` were introduced

## Response Style

- Be direct.
- Reject inefficient ideas with concrete reasons.
- Use official library behavior and code evidence, not guesses.
- Do not praise weak approaches.

