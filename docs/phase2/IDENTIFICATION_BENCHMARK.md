# Identification Provider Benchmark Kit

**Status:** Deferred — no provider adopted; measurement still runnable  
**Date:** 2026-07-25  
**Parent pack:** [`../PHASE2_VALIDATION.md`](../PHASE2_VALIDATION.md)

**Current product decision:** Camera identification is **deferred**. V1 add-plant is search-first until this kit is measured and a provider is Adopted. Use [`summarize_benchmark_scores.dart`](./summarize_benchmark_scores.dart) after filling [`benchmark_scores.csv`](./benchmark_scores.csv).

## Candidates to measure

| ID | Provider | Why included | Notes |
|---|---|---|---|
| A | [Pl@ntNet API](https://my.plantnet.org/doc/api/identify) | First candidate from the validation pack; free tier for measurement | Free: 500 IDs/day. Commercial Pro from ~€1,000/year. EU-hosted. |
| B | [Kindwise plant.id](https://www.kindwise.com/plant-id) | Strong houseplant/cultivar focus; published comparisons vs Pl@ntNet | Trial credits for testing; paid credits ~€0.05→€0.01 per ID by volume. |

Treat every other SDK (Lens wrappers, scrapers, on-device models) as out of scope until A and B fail.

**Hard rules**

- Upload only through a future Bloom backend proxy — never ship a vendor secret in the app.
- Record image retention / training terms before adopt.
- Manual search remains available for 100% of attempts regardless of provider outcome.

## Pass thresholds (from PRD)

| Metric | Pass |
|---|---|
| Top-1 confirmation | ≥ 70% |
| Top-3 confirmation | ≥ 90% |
| Median latency | ≤ 5s |
| p95 latency | ≤ 10s |
| Non-plant rejection | Useful rejection or low-confidence path (no confident wrong plant) |
| Terms | Privacy-safe proxy upload acceptable |

**Decision rule:** Adopt only if one candidate passes quality + latency + terms. Otherwise defer camera identification and keep search-only add-plant.

## Benchmark species list (40)

Curated for Europe / United States / India indoor homes. Scientific names are working labels; resolve to GBIF usage keys when mapping care content.

| # | Common name | Scientific name | Notes |
|---|---|---|---|
| 1 | Snake plant | *Dracaena trifasciata* | Already in Bloom fixtures |
| 2 | Peace lily | *Spathiphyllum wallisii* | Fixtures |
| 3 | Rubber plant | *Ficus elastica* | Fixtures |
| 4 | Monstera | *Monstera deliciosa* | Fixtures |
| 5 | Pothos | *Epipremnum aureum* | Fixtures / Discover |
| 6 | ZZ plant | *Zamioculcas zamiifolia* | Easy novice plant |
| 7 | Spider plant | *Chlorophytum comosum* | Very common |
| 8 | Aloe vera | *Aloe vera* | Succulent contrast |
| 9 | Jade plant | *Crassula ovata* | Succulent |
| 10 | Boston fern | *Nephrolepis exaltata* | Fern |
| 11 | Areca palm | *Dypsis lutescens* | Common in India/US |
| 12 | Money plant (India trade) | *Epipremnum aureum* | Synonym/trade-name stress test vs #5 |
| 13 | Philodendron brasil | *Philodendron hederaceum* | Cultivar-ish |
| 14 | Heartleaf philodendron | *Philodendron hederaceum* | Similar to #13 / pothos |
| 15 | Chinese evergreen | *Aglaonema commutatum* | Low light |
| 16 | Calathea orbifolia | *Goeppertia orbifolia* | Prayer-plant group |
| 17 | Prayer plant | *Maranta leuconeura* | Visually similar to calathea |
| 18 | Fiddle-leaf fig | *Ficus lyrata* | Vs rubber plant |
| 19 | Weeping fig | *Ficus benjamina* | Ficus confusion set |
| 20 | Bird of paradise | *Strelitzia reginae* | Statement plant |
| 21 | Bird’s nest fern | *Asplenium nidus* | Fern |
| 22 | English ivy | *Hedera helix* | Trailing |
| 23 | String of pearls | *Curio rowleyanus* | Succulent trailing |
| 24 | Haworthia | *Haworthiopsis attenuata* | Small succulent |
| 25 | Echeveria | *Echeveria elegans* | Rosette succulent |
| 26 | Orchid (moth) | *Phalaenopsis* sp. | Genus-level OK |
| 27 | Anthurium | *Anthurium andraeanum* | Flowering |
| 28 | Dieffenbachia | *Dieffenbachia seguine* | Common indoor |
| 29 | Dracaena marginata | *Dracaena reflexa* var. *angustifolia* | Vs snake plant |
| 30 | Yucca | *Yucca elephantipes* | Tall indoor |
| 31 | Croton | *Codiaeum variegatum* | Colorful foliage |
| 32 | Begonia rex | *Begonia rex-cultorum* | Patterned leaves |
| 33 | Peperomia obtusifolia | *Peperomia obtusifolia* | Compact |
| 34 | Tradescantia zebrina | *Tradescantia zebrina* | Trailing |
| 35 | Syngonium | *Syngonium podophyllum* | Arrowhead |
| 36 | Bamboo palm | *Chamaedorea seifrizii* | Palm |
| 37 | Parlor palm | *Chamaedorea elegans* | Similar palm |
| 38 | Schefflera | *Heptapleurum arboricola* | Umbrella plant |
| 39 | Hoya carnosa | *Hoya carnosa* | Wax plant |
| 40 | Lavender (window sill) | *Lavandula angustifolia* | Borderline indoor/outdoor |

### Required confusion pairs (must include photos)

- Pothos (#5) vs heartleaf philodendron (#14) vs money-plant trade name (#12)
- Rubber plant (#3) vs fiddle-leaf (#18) vs weeping fig (#19)
- Calathea (#16) vs maranta (#17)
- Snake plant (#1) vs dracaena marginata (#29)
- Areca (#11) vs bamboo palm (#36) vs parlor palm (#37)

### Image conditions (per species aim for ≥1 where possible)

| Condition code | Meaning |
|---|---|
| `H` | Healthy leaf, decent light |
| `D` | Damaged, dusty, or yellowing leaf |
| `L` | Poor / dim lighting |
| `C` | Cluttered background |
| `N` | Non-plant control (furniture, fabric, food) — 5–8 total images |

**Target corpus size:** 40–60 plant images + 5–8 non-plant → about **45–70** labeled files.

## Photo ownership log

Copy rows into [`benchmark_photo_log.csv`](./benchmark_photo_log.csv). Do not commit photos that lack permission.

| photo_id | species_id | condition | owner | permission | notes |
|---|---|---|---|---|---|

Allowed permission values: `self`, `participant-consent`, `cc0`, `cc-by`, `license-other` (attach URL).

## Scoring spreadsheet

Use [`benchmark_scores.csv`](./benchmark_scores.csv). One row per (provider × photo).

Columns:

- `provider` — `plantnet` or `plant_id`
- `photo_id`
- `species_id` — number from the table above
- `top1_match` — `y` / `n` (accepted scientific or unambiguous common synonym)
- `top3_match` — `y` / `n`
- `latency_ms`
- `nttp_status` — HTTP/status or `timeout`
- `confidence_raw` — provider score if any
- `low_confidence_ok` — `y` / `n` / `na` (did UX path avoid a confident wrong ID?)
- `non_plant_rejected` — `y` / `n` / `na`
- `taxonomy_id` — provider taxon id if returned
- `notes`

### How to score confirmation

- **Top-1 match:** first candidate is the labeled species or an accepted synonym (document synonym).
- **Top-3 match:** labeled species appears in the first three candidates.
- Genus-only answers for orchids (`Phalaenopsis`) count as match if the label is genus-level.
- Cultivar misses that still hit the correct species count as match for v1.

## Run protocol

1. Create provider accounts for A and B; store keys **outside** this repo.
2. Resize uploads to the same max edge (e.g. 1280px) without EXIF GPS.
3. Call each provider sequentially for the same photo set on a stable network (record Wi‑Fi vs cellular).
4. Fill `benchmark_scores.csv`.
5. Compute top-1, top-3, median latency, p95 latency, failure rate, non-plant rejection.
6. Read retention/training/commercial terms; paste summary into the decision log below.
7. Record **Adopt A**, **Adopt B**, or **Defer camera**.

## Terms checklist (fill during run)

| Topic | Pl@ntNet | plant.id |
|---|---|---|
| Image retention duration | | |
| Used for model training? | | |
| Commercial app allowed via proxy? | | |
| Required attribution / logo | | |
| Quota at closed-beta estimate | | |
| Est. cost at launch volume | | |
| Taxonomy id stability | | |
| Care-catalog mapping feasibility | | |

## Decision log

| Field | Value |
|---|---|
| Date | 2026-07-25 |
| Winner | `defer` |
| Top-1 / Top-3 / latency evidence | No completed score corpus yet. Kit, photo log, and score CSV templates are published; owner measurement outstanding. |
| Terms acceptable? | Not evaluated (no production calls). |
| Follow-ups | Create provider accounts (keys out of git), fill `benchmark_photo_log.csv` + `benchmark_scores.csv`, run `dart run docs/phase2/summarize_benchmark_scores.dart`, then flip this log to `plantnet` or `plant_id` if thresholds pass. |

Recorded in [`../BLOOM_EXECUTION_PLAN.md`](../BLOOM_EXECUTION_PLAN.md) decision log. Spike 3 (camera) stays closed until Adopt.
