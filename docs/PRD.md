# Bloom — Product Requirements Document

**Version:** 1.0  
**Status:** Ready for design generation  
**Platform:** iOS and Android

---

## Overview

Bloom is a personal plant care app that helps people keep their houseplants alive. It removes the guesswork from plant care by telling you exactly what each plant needs and when. Users can build a collection of their plants, get reminded when to water or fertilise them, and identify unknown plants using their camera.

The core promise: you should never accidentally kill a plant because you forgot to water it, or because you didn't know what it needed.

---

## Target User

Someone who owns 2–8 houseplants, genuinely wants them to thrive, but doesn't have deep horticultural knowledge. They forget watering schedules, aren't sure what "indirect light" really means for their specific plant, and feel guilty when a plant dies. They're not a hobbyist or expert — they just want a plant to look good in their home.

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

Users can point their camera at any plant and Bloom will identify it.

The flow:
1. User opens the Discover tab and taps "Scan a Plant"
2. A camera viewfinder opens with a framing guide overlay
3. User takes a photo
4. Bloom returns the plant name, scientific name, and confidence level
5. A result sheet slides up showing care summary (light, water, difficulty)
6. User can tap "Add to My Plants" to add it to their collection with all care info pre-filled

If identification fails or confidence is low, the user is shown the closest matches and can pick the correct one manually.

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
Background information about the plant:
- Origin / native habitat
- Growth habit (fast, slow, trailing, upright)
- Toxicity to pets and children
- Common problems and how to spot them

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

Users can adjust:
- Notification preferences (which types, what time)
- Unit preference (Celsius/Fahrenheit, metric/imperial)
- App appearance (follows system light/dark mode)

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
- Outdoor / garden plants (houseplants only)
- Watering hardware integration
- Multi-user households or shared plant collections
