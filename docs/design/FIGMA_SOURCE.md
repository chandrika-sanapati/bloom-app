# Bloom Figma Source

**Last reviewed:** 2026-07-25

## Rule

Figma is **vision, not product spec**.

- Visual language (colour, type, spacing, calm card UI) may inspire Flutter.
- Product features, navigation, and scope are defined by [`../PRD.md`](../PRD.md), [`../SCOPE.md`](../SCOPE.md), and [`../BLOOM_EXECUTION_PLAN.md`](../BLOOM_EXECUTION_PLAN.md).
- Do not implement Community, exact care quantities, recommendation feeds, accounts, or a Home/Scan/Community tab bar just because they appear in Figma.

## File

| Field | Value |
|---|---|
| File name | Plant care app - Bloom |
| File key | `n3dPoS2OakACxSrkbu8cfW` |
| URL | https://www.figma.com/design/n3dPoS2OakACxSrkbu8cfW/Plant-care-app---Bloom |
| Pages observed | `Page 1` (`0:1`), `Page 2` (`132:2122`) |

Open any frame with:

```text
https://www.figma.com/design/n3dPoS2OakACxSrkbu8cfW/Plant-care-app---Bloom?node-id=<NODE>&m=dev
```

Convert Figma node IDs by replacing `:` with `-` in the URL (for example `2016:7617` → `2016-7617`).

## Local pack

| Path | Purpose |
|---|---|
| [`SCREEN_INVENTORY.md`](./SCREEN_INVENTORY.md) | Curated frame map with v1 / deferred / anti-pattern tags |
| [`reference/`](./reference/) | Committed PNG snapshots of core screens |
| [`../DESIGN.md`](../DESIGN.md) | Android-first design system distilled for Flutter |

## When to re-fetch from Figma

Re-open the live file when:

- A visual decision needs pixel-level confirmation not covered by local PNGs
- Tokens or components change in Figma and the team intentionally refreshes the vision pack
- A new screen exists in Figma that should be catalogued before implementation

Prefer updating the inventory and a small set of reference PNGs over bulk-exporting every frame.

## Authorship note

Reference PNGs were exported via Figma MCP on 2026-07-25 for local clarity. They can drift from the live file; the inventory node IDs remain the durable links back to Figma.
