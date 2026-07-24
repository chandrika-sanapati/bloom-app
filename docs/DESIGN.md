# Bloom — Design Specification

App: Bloom plant care app  
Platform: iOS + Android (Flutter / Material 3)  
Design tool: Figma (Page 5 — Redesign, file `n3dPoS2OakACxSrkbu8cfW`)  
Target feel: Clean, minimal, modern — like a premium lifestyle app

---

## Design Philosophy

- **White space over decoration.** Breathing room signals quality. Don't fill gaps with ornament.
- **One clear action per screen.** The eye should land somewhere immediately.
- **Status should be glanceable.** Colour alone communicates task urgency (overdue/today/upcoming/done).
- **Minimal chrome.** Navigation bars and tab bars recede; content leads.
- **iOS-influenced but cross-platform.** Large titles, grouped lists, bottom tab bar — patterns both iOS and Android users recognise intuitively.

---

## Colour Tokens

| Token | Hex | Usage |
|-------|-----|-------|
| `brand.green` | `#2AAA8A` | Primary actions, active tabs, CTAs, icons |
| `brand.greenLight` | `#E8F5F1` | Chip backgrounds, tinted fills, active tab pill |
| `bg.primary` | `#FFFFFF` | Card backgrounds, nav bars, tab bar |
| `bg.secondary` | `#F2F2F7` | Screen background (system gray) |
| `label.primary` | `#1C1C1E` | Headings, primary body text |
| `label.secondary` | `#6C6C70` | Supporting text, subtitles |
| `label.tertiary` | `#AEAEB2` | Placeholder text, inactive tab icons |
| `separator` | `#E5E5EA` | Dividers, card borders, tab bar top edge |
| `status.overdue` | `#FF3B30` | Overdue badge bg tint + text |
| `status.dueToday` | `#FF9500` | Due-today badge bg tint + text |
| `status.healthy` | `#34C759` | Healthy/done badge bg tint + text |
| `status.info` | `#007AFF` | Informational chips |

Status chips use `12% opacity` of the status colour as the background fill, with the full colour for the text label.

---

## Typography

Font family: **Inter** (all weights)  
Fallback: system-ui, -apple-system

| Style | Size | Weight | Line height | Usage |
|-------|------|--------|-------------|-------|
| `large-title` | 34 | Bold (700) | 41 | Screen large titles (Today, My Plants) |
| `title-1` | 28 | Bold (700) | 34 | Section hero headings |
| `title-2` | 22 | Bold (700) | 28 | Card primary headings |
| `title-3` | 20 | Semi Bold (600) | 25 | Sub-section headers |
| `headline` | 17 | Semi Bold (600) | 22 | Row labels, card titles |
| `body` | 17 | Regular (400) | 22 | General content |
| `callout` | 16 | Regular (400) | 21 | Descriptions, helper text |
| `subheadline` | 15 | Regular (400) | 20 | Metadata, secondary rows |
| `footnote` | 13 | Regular (400) | 18 | Captions, supporting info |
| `caption` | 12 | Regular (400) | 16 | Timestamps, micro labels |

---

## Spacing

Base unit: **8px**

| Token | Value | Usage |
|-------|-------|-------|
| `space.1` | 4px | Icon internal padding, micro gaps |
| `space.2` | 8px | Chip vertical padding, tight row gaps |
| `space.3` | 12px | Card internal padding (compact) |
| `space.4` | 16px | Screen horizontal margin, card padding |
| `space.5` | 20px | Section vertical padding |
| `space.6` | 24px | Large component gaps |
| `space.8` | 32px | Onboarding content padding |

---

## Corner Radius

| Token | Value | Usage |
|-------|-------|-------|
| `radius.chip` | 20px | Chips, badges, small pills |
| `radius.button` | 24px | CTA buttons (pill shape) |
| `radius.card` | 16px | Task cards, plant cards, care rows |
| `radius.sheet` | 20px | Bottom sheets (top corners only) |
| `radius.modal` | 24px | Full modal cards |

---

## Shadows / Elevation

| Name | Drop shadow | Usage |
|------|-------------|-------|
| `shadow.card` | `0 1px 3px rgba(0,0,0,0.04)` | Task rows, plant cards, settings rows |
| `shadow.sheet` | `0 -4px 20px rgba(0,0,0,0.08)` | Bottom sheets rising from bottom |
| `shadow.elevated` | `0 4px 16px rgba(0,0,0,0.10)` | Plant name card overlapping hero photo |

Do not stack multiple shadows or use coloured shadows. Elevation should be subtle.

---

## Components

### Button

Three tiers:

| Variant | Fill | Text colour | Use |
|---------|------|-------------|-----|
| Primary | `brand.green` solid | White | One main CTA per screen |
| Secondary | `brand.greenLight` solid | `brand.green` | Supportive positive actions |
| Ghost | Transparent, `brand.green` 1.5px border | `brand.green` | Low-emphasis actions |

Specs: height 48px, border-radius 24px (pill), horizontal padding 24px, font `headline` (17px Semi Bold).  
Disabled state: fill `#EAEAEB`, text `#AEAEB2`.

### Chip / Badge

Specs: height auto, border-radius 20px, horizontal padding 10px, vertical padding 4px, font `caption` (12px Semi Bold).  
Background: `12% opacity` of the status colour.

Variants: `Overdue`, `Due Today`, `Healthy`, `Info`, `Easy`, `Moderate`.

### Task Row

Specs: width fill, height 72px, border-radius 16px, white fill, `shadow.card`.  
Layout (horizontal, center-aligned):
- Left: 44×44px circle icon (status colour fill, white icon)
- Center (FILL): plant name (`subheadline` Semi Bold) + task description (`footnote` Regular, secondary colour)
- Right: status chip

Done state: strikethrough on plant name, all text in `label.tertiary`.

### Plant Card

Specs: width 172px (2-column grid), height 200px, border-radius 16px, white fill, `shadow.card`, clips content.
- Top 116px: photo area with soft tinted background (per-plant accent colour)
- Bottom 84px: plant name (`subheadline` Semi Bold) + care status (`caption` Regular, secondary) — 12px padding

### Navigation Bar — Large Title

Specs: full-width, height 80px, white fill.  
Layout (vertical, bottom-aligned): date string (`footnote`, secondary) above large title (`title-1`, primary).  
Horizontal padding 20px.

### Navigation Bar — Standard (with Back)

Specs: height 44px, white fill. Back chevron + label left-aligned in `brand.green`; title centred in `headline` Semi Bold.

### Tab Bar

Specs: full-width, height 82px (includes 24px home indicator padding), white fill, 0.5px top separator.  
4 equal slots (98px wide each).  
Active tab: icon + label in `brand.green`; soft pill 56×28px, `brand.greenLight` fill, radius 14px, behind icon.  
Inactive tab: icon + label in `label.tertiary`.  
Tab labels: 10px Regular (inactive) / Semi Bold (active).

Tabs: **Today** · **Plants** · **Discover** · **Settings**

---

## Screen Inventory

### Onboarding — Welcome

Full-screen illustration area (top ~360px, `brand.greenLight` tint bg) + bottom content card.  
Bottom content: progress pill indicator (3 steps) → large title → subtitle → Primary CTA "Get Started".  
No tab bar.

### Onboarding — Features

Same structure. Progress pill at step 2. Different accent bg (`#DBF0FF`).  
Title: "Smart reminders". CTA: "Next". Skip link below in `label.tertiary`.

### Onboarding — Notifications

Same structure. Progress pill at step 3. Accent bg (`#FFF5E0`).  
Title: "Stay on track". CTA: "Allow Notifications". Skip link "Skip for now".

### Today — Tasks

- Large title nav: date in `footnote` secondary + "Today" in `title-1`
- Screen bg: `bg.secondary`
- Section header row: "Your tasks" (`title-3` Semi Bold) + "See all" (`subheadline` `brand.green`)
- Task rows (4): stacked vertically, 10px gap
- Bottom: tip card (`brand.greenLight` fill, radius 16, leaf emoji + "Tip of the day" + body text)
- Tab bar, Today active

### Plants — Collection

- Large title nav: "My Plants" + green "+ Add" pill button (right-aligned, bottom of nav)
- 2-column grid, 17px gap, 16px screen margin
- Plant cards (4): each 172×200px, soft tinted photo area, name + care status text
- Tab bar, Plants active

### Plant Detail — Care

- Full-bleed hero (296px, `brand.greenLight` tint). Back button (white 90% opacity pill, top-left in hero).
- Floating name card (white, `shadow.elevated`, radius 20): plant name (`title-3` Bold) + scientific name + Healthy chip. Positioned at y=250, overlapping bottom of hero.
- Tab switcher (Care / Info / Notes): height 48px, active tab in `brand.green` with 2px underline pill.
- Care rows (4): same structure as Task Row but with teal icon bg and value chip on right.
  - Watering: "Every 7d" chip
  - Sunlight: "Indirect" chip
  - Temperature: "18–27°C" chip
  - Humidity: "Normal" chip
- Tab bar, Plants active

### Discover

- Large title nav: "Discover"
- Search bar: pill shape (radius 24, white fill, `shadow.card`), magnifier icon + "Search plants…" placeholder
- Scan card (120px, dark fill `#1C1C1E`, radius 20): left-aligned text ("Identify a Plant" bold + subtitle) + right-aligned "Scan Now" green pill button. Subtle green accent circle (opacity 15%) in top-right corner.
- "Popular plants" section header
- Search result rows (3): 68px, radius 16, white. Leaf icon circle (44px, `brand.greenLight`) + plant name + scientific name + difficulty chip.
- Tab bar, Discover active

### Settings

- Large title nav: "Settings" (on `bg.secondary`, no white bg)
- 4 grouped sections with caps label above each:
  - **NOTIFICATIONS**: Watering reminders (toggle ON), Care tips (toggle ON), Weekly summary (toggle OFF)
  - **PREFERENCES**: Reminder time (8:00 AM), Measurement units (Metric)
  - **ABOUT**: Rate Bloom, Privacy Policy, Version (1.0.0)
  - **ACCOUNT**: Sign Out (red text, no chevron)
- Each section is a white rounded card (radius 16, `shadow.card`). Rows are 56px, separated by 1px `separator` lines (inset 16px from each side).
- Toggle: 51×31px pill. ON = `brand.green` fill, knob at right. OFF = gray, knob at left.
- Tab bar, Settings active

---

## Navigation / Prototype Flow

```
Onboarding Welcome
  → "Get Started" → Onboarding Features
    → "Next" → Onboarding Notifications
      → "Allow Notifications" or "Skip" → Today

Today (tab bar active)
  ↔ Plants ↔ Discover ↔ Settings  (tab bar)
  → task row tap → Plant Detail — Care
  → tip card (no destination)

Plants
  → plant card tap → Plant Detail — Care

Plant Detail — Care
  → back button → Plants

Discover
  → result row tap → Plant Detail — Care
  → scan card (no destination — future: camera screen)
```

---

## Key Patterns for Code Generation

### Flutter / Material 3 mapping

| Design element | Flutter widget |
|----------------|----------------|
| Screen background | `Scaffold(backgroundColor: bgSecondary)` |
| Large Title nav | `SliverAppBar(expandedHeight, flexibleSpace: FlexibleSpaceBar)` |
| Standard nav | `AppBar(leading: BackButton, title: Text)` |
| Task / care row | `Card` + `ListTile` or custom `Row` in `Padding` |
| Plant card grid | `GridView.count(crossAxisCount: 2)` |
| Tab bar | `NavigationBar` (Material 3) |
| Primary CTA | `FilledButton` |
| Secondary CTA | `FilledButton.tonal` |
| Ghost CTA | `OutlinedButton` |
| Toggle | `Switch` (Material 3) |
| Bottom sheet | `showModalBottomSheet` with `shape: RoundedRectangleBorder` |
| Status chip | `Chip` with `backgroundColor` and `labelStyle` |

### NativeWind / Tailwind equivalent (if React Native)

- `brand.green` → `text-teal-600 bg-teal-600`
- `bg.secondary` → `bg-gray-100`
- Card: `bg-white rounded-2xl shadow-sm`
- Pill button: `rounded-full px-6 py-3`

---

## Assets Required

| Asset | Format | Notes |
|-------|--------|-------|
| App icon | 1024×1024px | Green leaf on white, no rounded corners (OS clips) |
| Onboarding illustration 1 | SVG | Leaf / plant — currently 🌿 emoji placeholder |
| Onboarding illustration 2 | SVG | Water drop — currently 💧 emoji placeholder |
| Onboarding illustration 3 | SVG | Bell — currently 🔔 emoji placeholder |
| Plant placeholder photo | 200×232px | Neutral plant silhouette for empty card states |
| Tab icons | SVG set (24px) | Today (home), Plants (leaf), Discover (search), Settings (gear) |
| Care icons | SVG set (20px) | Water drop, sun, thermometer, humidity drop |

Replace all emoji placeholders with proper SVG icons before shipping. Recommended icon library: **Phosphor Icons** (clean, consistent weight, MIT licence).
