# Bloom Screen Inventory (Figma Vision)

**Last reviewed:** 2026-07-25  
**File key:** `n3dPoS2OakACxSrkbu8cfW`

Tags:

- **v1** — visual inspiration for a production v1 screen or pattern
- **deferred** — useful later, not in v1 product scope
- **anti-pattern** — conflicts with locked product decisions; do not ship as-is

Base URL: `https://www.figma.com/design/n3dPoS2OakACxSrkbu8cfW/Plant-care-app---Bloom?node-id=`

## Curated references with local PNGs

| Area | Figma name | Node | Tag | Local PNG | Notes for Flutter |
|---|---|---|---|---|---|
| Today | Home Page | `2016:7617` | v1 + deferred bits | [`reference/today-home.png`](./reference/today-home.png) | Use greeting, search, and task rows. Ignore recommendation rail and Community tab. Map nav to Today / My Plants / Discover. |
| Today empty | Home Page (all done) | `2110:7838` | v1 | [`reference/today-all-done.png`](./reference/today-all-done.png) | Positive empty state pattern. Keep encouragement; drop recommendation rail for v1. |
| My Plants / Discover search | Search Page | `2016:9590` | v1 | [`reference/search-discover.png`](./reference/search-discover.png) | Search + result rows for Discover manual search. Difficulty chips are fine. |
| Discover scan | Scan Photo | `2016:8074` | v1 | [`reference/scan-camera.png`](./reference/scan-camera.png) | Camera framing / capture inspiration. |
| Discover scan live | Scan Photo | `2016:10890` | v1 | [`reference/scan-camera-live.png`](./reference/scan-camera-live.png) | Live viewfinder with plant in frame. |
| Identification high | Scan result | `2016:10767` | v1 | [`reference/scan-result-high.png`](./reference/scan-result-high.png) | Ranked confidence + care summary sheet. Keep candidate confirmation; avoid unsupported exact volumes in copy. |
| Identification low | Scan result | `2016:10333` | v1 | [`reference/scan-result-low.png`](./reference/scan-result-low.png) | Low-confidence recovery with retake / manual search. |
| Identification candidates | Scan result | `2016:10856` | v1 | [`reference/scan-result-candidates.png`](./reference/scan-result-candidates.png) | Multi-candidate picker. |
| Plant detail | Plant Page2 | `2016:10950` | v1 + deferred | [`reference/plant-detail.png`](./reference/plant-detail.png) | Hero photos, overview, care guide rows. Drop Community CTA and similar-plants feed for v1. |
| Plant detail / history | Plant Page | `2016:7771` | v1 + deferred | [`reference/plant-detail-timeline.png`](./reference/plant-detail-timeline.png) | Water schedule + timeline history pattern. Community block is deferred. |
| Settings chrome | Profile Page | `2016:9502` | v1 + deferred | [`reference/profile-settings.png`](./reference/profile-settings.png) | Reminder toggles and help rows inspire Settings. Drop Community, friends, weather alerts, logout/account for v1. Open Settings from app bar, not a tab. |
| Splash | Splash 1 | `2016:9150` | v1 | [`reference/splash.png`](./reference/splash.png) | Soft branded launch visual. |
| Onboarding | Onboarding | `350:1932` | v1 | [`reference/onboarding-welcome.png`](./reference/onboarding-welcome.png) | Welcome / value step. |
| Onboarding | Onboarding | `577:8783` | v1 | [`reference/onboarding-features.png`](./reference/onboarding-features.png) | Feature explanation step. |
| Community (reference only) | Community | `143:472` | deferred / anti-pattern for v1 | [`reference/community-deferred.png`](./reference/community-deferred.png) | Kept only so the vision is visible. Do not implement. |

## Additional shared frames (links only)

These were in the shared selection. They are catalogued for orientation but not exported as PNGs.

| Node | Observed / likely role | Tag |
|---|---|---|
| `2016:11061` … `2016:11054` | Plant detail / care variants | v1 / deferred (inspect before use) |
| `2016:9157`, `2016:9342`, `2016:9343`, `2016:9143` | Icon components | ignore for screens |
| `2016:9304`, `2016:9259`, `2016:9226`, `2016:9225` | Intermediate UI pieces | inspect if needed |
| `2016:7979` | Small component / crop | ignore for screens |
| `2016:9170`, `2016:9171`, `2016:9172` | Component variants | ignore for screens |
| `2016:8098`, `2016:8124`, `2016:8111`, `2016:8161` | Scan / plant flow variants | v1 inspiration |
| `2016:7636`, `2016:7666`, `2016:7656`, `2016:7646`, `2016:7687`, `2016:7697`, `2110:7616`, `2110:7727` | Today / home task states | v1 |
| `2016:9408`, `2016:9375`, `2016:9441`, `2016:9201` | Flow variants | inspect |
| `2016:7985`, `2016:8660`, `2016:8567`, `2016:8225`, `2016:8227` | Supporting screens | inspect |
| `2016:9094`, `2016:9127`, `2016:9118`, `2016:9136` | Components / states | inspect |
| `2016:7719`, `2016:7709`, `2016:7823` | Plant detail variants | v1 + deferred community |
| `2016:11074`, `2016:11072`, `2016:11070`, `2016:11076` | Later plant-detail variants | inspect |
| `2016:9474`, `2016:9475` | Marketing / banner collage | ignore for app UI |
| `2016:7627` | Home variant | v1 |

Open any listed node with the base URL and `node-id` using dashes.

## Production mapping (authoritative)

| Product destination | Figma inspiration | Do not copy from Figma |
|---|---|---|
| Today | Home / Today’s Task frames | Community tab, recommendation rails, exact “1 cup / 100mg” copy |
| My Plants | Plant Collection / plant cards (banner collage + plant pages) | Favourites social graph, Community CTAs |
| Discover | Search Page + Scan Photo + identification results | Treating Scan as the only bottom destination |
| Settings | Profile/settings rows | Accounts, logout, Community, weather alerts as first-class v1 |
| Onboarding | Splash + Onboarding frames | Claims that conflict with the PRD promise |

## Anti-patterns to avoid in implementation

1. **Community** as a bottom tab or plant-detail CTA
2. **Exact watering/fertilizer quantities** without sourced care content
3. **Recommendation feeds** before the care loop is proven
4. **Account / logout** chrome in a local-first v1
5. **Colour-only status** without icon + text
