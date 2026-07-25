# Bloom — Product Requirements Document

**Version:** 1.3
**Status:** Android-first implementation brief  
**Platform:** Android first; preserve future iOS and web portability

**Delivery note (2026-07-25):** Camera identification is **deferred** until the Phase 2 provider benchmark records Adopt. V1 add-plant is **search-first**; Discover may keep a non-blocking scan entry that routes to search until Spike 3 is unlocked. See [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md).

---

## Overview

Bloom is a local-first plant care app for non-experts with approximately 2–8 indoor plants. Users can search for a houseplant (and later identify one by camera once a provider is Adopted), review and edit a suggested care plan for their conditions, and see what care is due today.

The core promise:

> Search for a houseplant (camera when unlocked), review a suggested care plan for your conditions, and know what to do today.

Care guidance is a cautious, editable suggestion rather than a guarantee.

---

## Geography and language

- **App language:** English only in v1. No localized UI, notifications, or care copy.
- **Initial Play markets:** Europe, the United States, and India.
- **Store listing language:** English.
- **Deferred:** non-English localization unless closed-beta evidence shows a blocking language barrier in a priority market.

Europe means the Google Play country set for Europe available at release time. Exact country enablement is confirmed in Play Console before closed beta; the product itself stays English-only across all enabled markets.

---

## Target User

Someone who owns approximately 2–8 indoor plants, genuinely wants them to thrive, but doesn't have deep horticultural knowledge. They forget watering schedules and are unsure how general care guidance applies to their home. They need understandable suggestions, editable reminders, and a dependable daily care loop rather than expert diagnosis.

---

## Navigation

The production app has three bottom destinations:

1. **Today** — overdue, due, upcoming, and completed care tasks
2. **My Plants** — the saved collection, plant details, and care history
3. **Discover** — manual search (primary); camera identification when Phase 2 Adopt unlocks Spike 3

Settings is opened from the top app bar. Manual search is always available. When camera ships, search remains next to scanning and available when camera permission, connectivity, confidence, or the identification provider fails. Community is not part of production navigation.

---

## MVP Features

### 1. Plant Collection

Users can build a personal collection of their plants. Each plant in the collection has:

- A name (e.g. "Rubber Plant", "Monstera")
- A photo (taken by the user or auto-filled during identification)
- Care information: watering frequency, light requirement, temperature range, humidity preference
- A log of when it was last watered, misted, or fertilised
- Personal notes the user has written

The collection is displayed as a grid of cards. Each card shows the plant photo, name, and a quick status — when it next needs attention.

Empty state: a friendly prompt to add the first plant, with two options — search by name or scan with the camera.

---

### 2. Watering Reminders

Bloom tracks the care schedule for every plant in the collection and tells users what needs attention today.

The home screen ("Today") shows a list of tasks for the current day, sorted by urgency:

- **Overdue** — plants that needed care yesterday or earlier and haven't been tended to
- **Due today** — plants that need watering or care today
- **Upcoming** — plants whose care is due in the next few days (shown so users can plan ahead)

Each task shows the plant name, the care action (Water, Mist, Fertilise), and how frequently this task repeats.

When a user marks a task as done, it disappears from the list and the next reminder is automatically scheduled based on the plant's care frequency.

If all tasks are done, the screen shows a positive empty state: "All caught up — your garden is thriving."

---

### 3. Plant Identification via Camera

Users can point their camera at a plant and Bloom will return ranked identification candidates with confidence messaging.

The flow:
1. User opens the Discover tab and taps "Scan a Plant"
2. A camera viewfinder opens with a framing guide overlay
3. User takes a photo
4. Bloom returns ranked candidates with common name, scientific name, and confidence guidance
5. The user confirms a candidate or chooses search/retake when confidence is low
6. A result sheet shows a sourced care summary
7. The user reviews and edits the suggested care plan before adding the plant

If identification fails or confidence is low, the user can retake the image or use manual search. Bloom does not silently accept the first result.

---

### 4. Plant Search

Users can search for any plant by name (common or scientific) without using the camera.

The search returns a list of matching plants with their name and a difficulty chip (Easy, Moderate, or Expert). Tapping a result shows the same result sheet as the camera scan, with the option to add to collection.

This is useful when a user already knows what plant they have but wants Bloom to track its care schedule.

---

### 5. Plant Detail

Each plant in the collection has a detail screen with three tabs:

**Care tab**
Shows the plant's care schedule as a set of rows:
- Watering (frequency + last watered date)
- Sunlight (requirement type)
- Temperature (ideal range)
- Humidity (preference)

Users can log a care action (e.g. "just watered") directly from this tab, which updates the schedule.

**Info tab**
Shows sourced, versioned catalog information that is approved for v1. Pet/child toxicity and diagnosis or recovery guidance are excluded until a verified, licensed source and appropriate review are in place.

**Notes tab**
A personal journal for the plant. Users can write free-form notes with timestamps — e.g. "Repotted today", "New leaf appeared", "Noticed yellowing on lower leaves". Each note shows the date it was written.

---

### 6. Notifications

Bloom sends push notifications to remind users when their plants need attention. The notification says which plant needs care and what action is required.

Users can control:
- Whether reminders are on or off
- What time of day reminders arrive (default: 8:00 AM)
- Whether they want a weekly summary of upcoming tasks

---

### 7. Settings

Settings is accessed from the Today top app bar rather than a fourth bottom-navigation destination.

Users can adjust:
- Notification preferences (which types, what time)
- Unit preference (Celsius/Fahrenheit, metric/imperial)
- App appearance (follows system light/dark mode)
- Permission status
- Privacy and delete-all-local-data controls
- Support, version, and attribution information

---

## Product Outcomes

These are initial validation thresholds, not launch claims. Revisit them after prototype and closed-beta evidence.

- **Activation:** at least 70% of observed participants who start Add Plant confirm a plant and an editable care plan.
- **Time to activation:** design target under one minute; measure the median and do not claim it publicly until demonstrated.
- **First value:** every activated plant immediately produces a clear next task or an explicit no-task-yet state.
- **Week-two retention:** at least 30% of activated closed-beta users complete or intentionally reschedule a care task during days 8–14.
- **Identification latency:** median response at or below 5 seconds and p95 at or below 10 seconds on the supported network profile.
- **Identification quality:** top-1 confirmation at or above 70% and top-3 confirmation at or above 90% on the approved benchmark set.
- **Manual fallback:** available for 100% of identification attempts; investigate if more than 30% of attempts require it.
- **Reminder reliability:** fewer than 1% duplicate or missed scheduled care tasks in the reminder test matrix.
- **Stability:** at least 99.5% crash-free sessions and Android vitals below the current bad-behavior thresholds.

---

## User Flows

### First-time user

1. Opens app → sees Welcome screen
2. Shown what Bloom does in 2 more onboarding screens (reminders, identification)
3. Asked to allow notifications
4. Lands on Today screen (empty — no plants yet)
5. Prompted to add first plant

### Returning user — morning check

1. Opens app or taps morning push notification
2. Today screen shows tasks sorted by urgency
3. User waters the overdue plant, marks it done
4. Task disappears; next task shown
5. When all done, sees "All caught up" state

### Adding a plant by scanning

1. Taps Discover tab → "Scan a Plant"
2. Points camera at plant → takes photo
3. Result sheet: "Monstera deliciosa — High confidence"
4. Taps "Add to My Plants"
5. Plant appears in collection with care schedule pre-filled
6. First reminder scheduled automatically

### Adding a plant by search

1. Taps Discover tab → search bar
2. Types "rubber plant"
3. Selects "Rubber Plant (Ficus elastica)"
4. Sees care summary → taps "Add to My Plants"
5. Enters a custom name (optional) → confirms
6. Plant added to collection

### Viewing plant detail

1. Taps a plant card in collection (or a task row on Today)
2. Detail screen opens — Care tab shown by default
3. User can swipe to Info or Notes tabs
4. Taps "Log care" to record watering → schedule updates

---

## Key UX Principles

**Urgency is always visible.** Overdue tasks are red, today's tasks are green, upcoming tasks are gray. Users should understand the state of their garden in under 3 seconds.

**Friction to add a plant should be near zero.** Scan → confirm → done. No manual form entry required if the plant is identified.

**Logging care is a single tap.** Users shouldn't need to navigate or fill a form to say "I just watered this."

**Empty states are encouraging, not punishing.** If there's nothing to do, that's a good thing — show it positively.

**The app should feel calm.** Plant care is a low-stress activity. The design, copy, and interactions should feel gentle and unhurried.

---

## Out of Scope (not in v1)

- Social features, community feed, or sharing
- Plant marketplace or e-commerce
- Pest and disease diagnosis
- Pet/child toxicity guidance without a verified, licensed source
- Outdoor / garden plants (houseplants only)
- Watering hardware integration
- Multi-user households or shared plant collections
- Accounts and cloud sync
- Ads, subscriptions, and other monetization
