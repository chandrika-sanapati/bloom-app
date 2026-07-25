# Bloom — Design System

**Status:** Android-first vision distilled from Figma  
**Last reviewed:** 2026-07-25  
**Figma file:** `n3dPoS2OakACxSrkbu8cfW` (see [`design/FIGMA_SOURCE.md`](./design/FIGMA_SOURCE.md))

## Authority

| Concern | Source of truth |
|---|---|
| Features, navigation, geography, scope | [`PRD.md`](./PRD.md), [`SCOPE.md`](./SCOPE.md), [`BLOOM_EXECUTION_PLAN.md`](./BLOOM_EXECUTION_PLAN.md) |
| Visual language | This document + [`design/reference/`](./design/reference/) |
| Live mockups | Figma (inspirational only) |

Figma may show Community, exact care volumes, recommendation rails, or a Home/Scan/Community tab bar. Those are **not** v1 product requirements.

---

## Design philosophy

- Calm lifestyle UI: soft gray canvas, white cards, generous breathing room.
- One primary action per screen.
- Glanceable care status with **icon + label + colour** (never colour alone).
- Minimal chrome: content leads; navigation recedes.
- Android-first Material 3 components, inspired by the Figma look rather than pixel-locked to iPhone frames.

Base frame for design review: **393×852**. Verify layouts at **360dp** width and large text scaling before freeze.

---

## Colour tokens

Aligned with Figma variables where they match the product brand.

| Token | Hex | Usage |
|---|---|---|
| `brand.green` | `#2AAA8A` | Primary actions, active nav, key accents |
| `brand.greenLight` | `#D8F3DC` | Tinted fills, soft chips (Figma Primary/Nyanza) |
| `brand.greenSoft` | `#E8F5F1` | Alternate soft tint for large surfaces |
| `bg.canvas` | `#FBFCFD` | Default screen background |
| `bg.seaSalt` | `#F8F9FA` | Grouped areas, search field fills |
| `bg.card` | `#FFFFFF` | Cards, sheets, bars |
| `label.primary` | `#343A40` | Headings and primary body (Figma Secondary/Onyx) |
| `label.secondary` | `#495057` | Supporting text (Outer space) |
| `label.tertiary` | `#6C757D` | Placeholders, inactive icons (Slate grey) |
| `border.subtle` | `#CED4DA` | Card borders, checkbox outline (French grey2) |
| `border.hairline` | `#E9ECEF` | Dividers |
| `neutral.disabled` | `#EAEAEB` | Disabled fills |
| `status.overdue` | `#FF3B30` | Overdue (with icon + text) |
| `status.dueToday` | `#FF9500` | Due today |
| `status.healthy` | `#34C759` | Healthy / done |
| `status.info` | `#007AFF` | Informational |

Status chip fill: approximately **12% opacity** of the status colour, full colour for label and icon.

---

## Typography

**Family:** Poppins (from Figma text styles)  
**Fallback:** `sans-serif` / platform default if Poppins is unavailable during early scaffolding

| Style | Size | Weight | Flutter `TextTheme` hint | Usage |
|---|---|---|---|---|
| `display` | 22–24 | SemiBold 600 | `titleLarge` | Greetings, hero titles |
| `title` | 16 | SemiBold 600 | `titleMedium` | Section headers (“Today’s Task”) |
| `titleSmall` | 14 | Medium 500 | `titleSmall` | Card / row titles |
| `body` | 14 | Regular 400 | `bodyMedium` | Primary body |
| `bodySmall` | 12 | Regular 400 | `bodySmall` | Metadata, helper text |
| `label` | 12 | SemiBold 600 | `labelMedium` | Active tab labels, chip labels |
| `labelInactive` | 12 | Medium 500 | `labelSmall` | Inactive tab labels |

Keep line length short on task rows. Prefer sentence case.

---

## Spacing

Base unit: **8px**

| Token | Value | Usage |
|---|---|---|
| `space.1` | 4 | Tight icon gaps |
| `space.2` | 8 | Compact stacking |
| `space.3` | 12 | Avatar / text gaps |
| `space.4` | 16 | Screen horizontal margin, card padding |
| `space.5` | 20 | Nav bar side padding |
| `space.6` | 24 | Large section gaps |
| `space.8` | 32 | Onboarding breathing room |

Content width inside phone frames is typically **345** within a **393** canvas (24px side margin).

---

## Corner radius

| Token | Value | Usage |
|---|---|---|
| `radius.control` | 8 | Checkboxes, small image tiles |
| `radius.image` | 12 | Thumbnails in task rows |
| `radius.card` | 16 | Task cards, search field, plant cards |
| `radius.chip` | 20 | Soft pills / badges |
| `radius.button` | 24 | Primary CTAs |
| `radius.sheet` | 20 | Top corners of bottom sheets |

---

## Elevation

Keep shadows subtle.

| Name | Value | Usage |
|---|---|---|
| `shadow.card` | Soft gray, ~`0 4px 15px rgba(124,124,124,0.15)` for bars; lighter for rows | Bottom nav, floating bars |
| `shadow.row` | Border `#CED4DA` preferred over heavy shadow | Task rows, search results |
| `shadow.sheet` | Soft upward shadow | Identification result sheets |

Prefer a **1px border** on task rows over stacked decorative shadows.

---

## Navigation (product)

Bottom destinations (locked):

1. **Today**
2. **My Plants**
3. **Discover**

Settings opens from the top app bar / profile affordance, not a fourth permanent tab.

Figma’s Home / Scan / Community bar is inspirational chrome only. Map:

| Figma | Product |
|---|---|
| Home | Today |
| Scan | Discover (camera entry inside Discover) |
| Community | Deferred — do not ship |

---

## Components (v1)

### Primary button

- Height 48, pill radius 24, fill `brand.green`, white label
- One primary CTA per screen
- Material mapping: `FilledButton`

### Secondary / tonal button

- Fill `brand.greenLight`, text `brand.green`
- Material mapping: `FilledButton.tonal`

### Search field

- Height 48, radius 16, fill `#F0F3F6` / `bg.seaSalt`, subtle border
- Placeholder in `label.tertiary`
- Trailing search icon
- Material mapping: styled `SearchBar` or `TextField`

### Task row

- Height ~84, radius 16, white fill, `#CED4DA` border
- Left: 56×56 plant thumbnail, radius 12
- Center: plant name (`titleSmall`) + care action (`bodySmall`)
- Right: rounded-square checkbox (24), not a tiny Material default only
- Done: checked state; keep row readable

Exact copy like “Water 1 cup” or “Fertilize 100mg” is **Figma placeholder language**. Production copy must use sourced, cautious care guidance.

### Plant card

- Soft white card, radius 16, photo area + name + short status
- Collection uses a responsive 2-column grid on phone widths

### Status chip

- Icon + text + tinted fill
- Variants: Overdue, Due today, Upcoming, Healthy / Done, Easy / Moderate (catalog difficulty)

### Bottom navigation

- Material 3 `NavigationBar`
- Three destinations only
- Active colour `brand.green`
- Inactive `label.tertiary`

### Identification result sheet

- Ranked candidates with confidence messaging
- Clear confirm / retake / search fallback
- Care summary is suggested and editable before add

---

## Screen patterns (v1)

| Screen | Visual inspiration | Required product behavior |
|---|---|---|
| Today | [`design/reference/today-home.png`](./design/reference/today-home.png), [`today-all-done.png`](./design/reference/today-all-done.png) | Overdue / due / upcoming / done; positive empty state |
| My Plants | Plant cards + collection frames in inventory | Grid, empty add via search or scan |
| Discover | [`search-discover.png`](./design/reference/search-discover.png), scan references | Search always visible next to scan |
| Plant detail | [`plant-detail.png`](./design/reference/plant-detail.png), [`plant-detail-timeline.png`](./design/reference/plant-detail-timeline.png) | Care plan, history; no Community |
| Settings | [`profile-settings.png`](./design/reference/profile-settings.png) | Reminders, units, privacy, support; no account logout |
| Onboarding | splash + onboarding PNGs | Short English value path into empty Today |

Full node list: [`design/SCREEN_INVENTORY.md`](./design/SCREEN_INVENTORY.md).

---

## Anti-patterns (do not ship in v1)

1. Community tab, community CTAs, likes, comments, or shared posts
2. Unsupported exact watering or fertilizer quantities
3. Recommendation / “for you” feeds as a retention core
4. Accounts, logout, or social profile chrome
5. Status communicated by colour alone
6. Hiding manual search behind identification failure only

---

## Flutter theme mapping

See [`design/FLUTTER_THEME.md`](./design/FLUTTER_THEME.md) for how these tokens should land in `ThemeData` / `ColorScheme` later. Do not treat that note as implemented code until a foundation theme pass lands in `lib/`.

---

## Assets

| Asset | Notes |
|---|---|
| Brand green leaf mark | Prefer real vector/PNG over emoji for shipping |
| Plant placeholders | Neutral silhouette for empty cards |
| Care icons | Water, light, prune/fertilise — consistent stroke |
| Tab icons | Today, My Plants, Discover — 24dp |

Icon direction may follow the Figma Vuesax-style outlines, but prefer a maintained Flutter icon set or committed SVGs when implementing.
