# Care Content — Decision Note

**Status:** Provisional recommendation (owner lock required)  
**Date:** 2026-07-25  
**Parent pack:** [`../PHASE2_VALIDATION.md`](../PHASE2_VALIDATION.md)

## Product constraints (non-negotiable)

From PRD / scope:

- No unsupported exact watering volumes
- No pet/child toxicity claims in v1
- No disease diagnosis
- Schedules are **suggestions** and remain editable
- Every care rule needs a source + content version
- Catalog ≈ 30–50 common houseplants for v1
- Must map to identification taxonomy IDs or a documented manual map

## Options evaluated

### Taxonomy

| Option | Fit | Notes |
|---|---|---|
| **GBIF Taxonomic Backbone** (recommended) | High | Stable `usageKey`, free, reviewable, industry-standard. Use as Bloom’s canonical species id when possible. |
| Provider-native IDs only (Pl@ntNet / plant.id) | Medium | Fine as secondary keys; do not make the care DB depend on one vendor. |
| Wikidata QIDs alone | Medium | Useful crosswalk; less curated for horticultural synonyms than GBIF. |

### Care guidance

| Option | Fit | Notes |
|---|---|---|
| **Originally authored Bloom care plans** citing public extension / RHS-style guidance (recommended) | High | Full control of cautious language; matches “no exact volumes”; versionable in-repo. |
| FloraDB / commercial houseplant datasets | Low–medium for Bloom v1 | Strong GBIF links, but emphasize quantitative volumes and ASPCA toxicity — both largely **out of Bloom v1 scope**. NC sample cannot ship in a commercial app without a commercial license. |
| Kindwise / Plant.id plant details endpoints | Medium | Convenient if plant.id wins ID benchmark; still need Bloom rewriting for cautious, editable schedules. |
| Scraping blogs / retailer pages | Rejected | Fragile licensing and reviewability. |

## Provisional decision (pending owner lock)

| Decision | Provisional choice |
|---|---|
| Taxonomy source | **GBIF** `usageKey` (+ scientific name + common name) |
| Care-content source | **Bloom-authored** plans for a curated catalog, each rule citing a reviewable public source URL |
| Catalog size | **40 species** — same set as [`IDENTIFICATION_BENCHMARK.md`](./IDENTIFICATION_BENCHMARK.md) |
| Content versioning | `care_content_version` string per plan item (start `2026.07`) |
| Toxicity / disease | **Out of scope** — do not import ASPCA fields into v1 UI |
| Exact quantities | **Forbidden** — use qualitative bands (“water when the top soil feels dry”) |
| Horticultural review before closed beta | **Required** (recommend: one independent reviewer for the 40-plant set) |

### Environment answers that may change the suggested schedule

Keep the questionnaire short. Only these knobs adjust defaults:

| Answer | Effect on suggestion |
|---|---|
| Light: low / medium / bright-indirect | Stretch or shorten watering cadence band; adjust “move closer to window” tips |
| Home climate: dry / average / humid | Prefer slightly less frequent watering in humid; mention misting only as optional |
| Potting: small / medium / large | Minor cadence hint only; never invent ml volumes |
| User experience: novice / some experience | Novice copy more cautious; same underlying bands |

If an answer is skipped, use the medium/default band and label the plan as a starting suggestion.

### Cautious language (required phrases)

Use (or close variants) in UI and catalog copy:

- “Suggested for typical indoor conditions — edit to match your home.”
- “When unsure, wait and check the soil rather than watering on a fixed day.”
- “Bloom does not diagnose pests or disease.”

## Rejected for v1

- Shipping FloraDB quantitative ml / lux as user-facing truth
- Any pet-safe / toxic badges
- Auto-generated care from raw LLM without source URLs and human edit
- Per-provider care blobs with no GBIF crosswalk

## v1 catalog workflow

1. Lock this decision note (owner).
2. For each of the 40 benchmark species, author:
   - overview (2–3 sentences)
   - care plan items: water, light, fertilise (optional), check
   - cadence labels as bands, not exact volumes
   - `source_url` + `care_content_version`
   - `gbif_usage_key` when resolved
3. Maintain [`catalog_mapping.csv`](./catalog_mapping.csv) for GBIF + provider taxon ids.
4. Independent horticultural pass before closed beta.

## Owner lock checklist

Reply to lock or override:

1. Accept GBIF + Bloom-authored care plans? (`yes` / alternative)
2. Require independent horticultural review before closed beta? (`yes` / `defer`)
3. Keep toxicity claims out of v1? (`yes` recommended)

Until locked, engineering may keep fixture care copy but must not treat a vendor care API as source of truth.
