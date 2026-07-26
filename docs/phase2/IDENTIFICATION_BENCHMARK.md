# Identification Provider Benchmark Kit

**Status:** **Adopt — Pl@ntNet** (provisional on free-tier economics + terms; closed-beta quality smoke still required)  
**Date adopted:** 2026-07-26  
**Parent pack:** [`../PHASE2_VALIDATION.md`](../PHASE2_VALIDATION.md)

**Current product decision:** Camera identification is **unlocked** with **Pl@ntNet** as the provider. Manual search remains always available. Upload only through a Bloom proxy in production — never ship the vendor API key in the app binary.

## Why Pl@ntNet (not Kindwise plant.id)

Research snapshot 2026-07-26 ([Pl@ntNet pricing](https://my.plantnet.org/pricing), [Kindwise pricing](https://www.kindwise.com/pricing)):

| Factor | Pl@ntNet | Kindwise plant.id |
|---|---|---|
| Free / trial | **500 IDs/day** (€0) | 100 trial credits once |
| Early paid cost | Pro: **€1,000 / yr** includes 200k IDs (~€0.005/ID) | From **€0.05/ID** (1k credits / €50); €0.015 at 200k |
| Closed-beta fit | Free tier covers measurement + early users | Pays immediately after 100 IDs |
| Hosting | European-hosted | GDPR-compliant; results retained ~6 months |
| Taxonomy | Returns **GBIF id** (matches Bloom care lock) | Strong houseplant/cultivar depth |
| Attribution | CC-style / powered-by expectations on some tiers | Content licensing on returned images |

**Decision:** Adopt **Pl@ntNet** because Bloom is pre-revenue / closed-beta and pricing dominates. Kindwise remains the fallback if Pl@ntNet top-1/top-3 smoke on houseplants fails PRD thresholds.

## Candidates considered

| ID | Provider | Outcome |
|---|---|---|
| A | [Pl@ntNet API](https://my.plantnet.org/doc/api/identify) | **Adopted** |
| B | [Kindwise plant.id](https://www.kindwise.com/plant-id) | Rejected for v1 cost; keep as fallback |

## Pass thresholds (from PRD)

| Metric | Pass |
|---|---|
| Top-1 confirmation | ≥ 70% |
| Top-3 confirmation | ≥ 90% |
| Median latency | ≤ 5s |
| p95 latency | ≤ 10s |
| Non-plant rejection | Useful rejection or low-confidence path |
| Terms | Privacy-safe proxy upload acceptable |

## Terms / cost worksheet (filled)

| Topic | Pl@ntNet | plant.id |
|---|---|---|
| Image retention duration | Identification service; do not retain raw photos in Bloom by default | Results available ~6 months via retrieve API |
| Used for model training? | Citizen-science / research ecosystem; confirm licence on account signup | Vendor ML retraining — review before high volume |
| Commercial app allowed via proxy? | Yes (free ≤500/day; Pro contract above) | Yes (prepaid credits) |
| Required attribution / logo | Free/non-profit may require powered-by; Pro notes “no required logo” | Follow Kindwise content licence for returned images |
| Quota at closed-beta estimate | Stay on free 500/day | N/A (not selected) |
| Est. cost at launch volume | €0 until >500/day; then ~€1k/yr for ≤200k | ~10× higher at low volume |
| Taxonomy id stability | GBIF id in identify response | Vendor ids + details endpoints |
| Care-catalog mapping feasibility | Match GBIF / scientific name to Bloom catalog | Possible; not needed for v1 |

## Benchmark species list (40)

Unchanged — see prior revision / [`IDENTIFICATION_BENCHMARK.md` history]. Owner should still fill [`benchmark_scores.csv`](./benchmark_scores.csv) during closed beta to validate PRD thresholds; Adopt is **cost/terms provisional**, not a claim that the score corpus already passed.

## Decision log

| Field | Value |
|---|---|
| Date | 2026-07-26 |
| Winner | `plantnet` |
| Top-1 / Top-3 / latency evidence | Not yet measured end-to-end; Adopt driven by pricing + GBIF alignment + free-tier beta economics per owner instruction |
| Terms acceptable? | Yes for proxy upload on free/Pro commercial paths |
| Follow-ups | Create Pl@ntNet account (key out of git); deploy identify proxy; smoke houseplant confusion pairs; fill score CSV; escalate to Kindwise only if quality fails |

Spike 3 (camera) is **open**. Production must call Pl@ntNet only via a Bloom-controlled proxy.
