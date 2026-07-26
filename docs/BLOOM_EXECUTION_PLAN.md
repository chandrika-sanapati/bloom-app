# Bloom Flutter App & Case Study — Execution Plan

**Status:** Phase 2 camera-blocking gates closed (care locked; scanning deferred); app foundation continues search-first  
**Last updated:** 2026-07-25

**Primary goal:** Publish a focused, trustworthy Bloom app on Google Play, then rebuild the portfolio case study around evidence from the working product.  
**Product thesis:** Search (and later identification, once Adopted) activates the user; dependable, editable care reminders and history retain them.

---

## How to use this document

- Work through the phases in order.
- Do not start the next phase until its **exit gate** is satisfied.
- Check off completed tasks with `[x]`.
- Record meaningful decisions in the decision log at the bottom.
- Treat time ranges as planning guidance, not commitments.
- Keep the public case study honest about whether an artifact is a concept, prototype, beta, or released product.

## Non-negotiable product decisions

- Flutter and Dart, with an Android-first release and future iOS/web portability.
- Use the FVM-pinned Flutter SDK and standard Material 3 components.
- Use `design.chandrika.bloom` as the application ID.
- No mandatory account in v1.
- No community or other user-generated content in v1.
- Manual plant search must always remain available as a fallback.
- Identification results show ranked candidates and uncertainty; Bloom does not pretend the first match is always correct.
- Care schedules are clearly labeled as suggestions and are editable before activation.
- A local SQLite-backed data source is the source of truth for plants, tasks, and care history; select the persistence package in the Phase 4 spike.
- Saved plants and tasks remain usable offline; identification may require a connection.
- No exact watering quantities without enough contextual evidence.
- Status never relies on color alone.
- Store screenshots and case-study claims show only functionality that exists.

## Target v1 scope

### Include

- Today screen with overdue, due, upcoming, and completed tasks
- Plant collection
- Add plant through manual search
- Add plant through camera identification
- Ranked identification candidates and confidence messaging
- Low-confidence retake and manual fallback
- Short environment questionnaire
- Suggested, editable care plan
- Plant detail and chronological care history
- Reminder actions: Done, Snooze, Skip, Reschedule
- Reminder preferences and permission management
- Offline access to saved plants and tasks
- Privacy policy, delete-all-local-data, and support information

### Explicitly defer

- Community, friends, likes, comments, and sharing
- Personalized recommendation feeds
- Social comparison and milestones
- Disease diagnosis and recovery predictions
- Chatbot
- Accounts, cloud sync, and shared households
- Ads, subscriptions, and other monetization
- Marketplace or e-commerce
- Outdoor/garden plants
- Hardware or sensor integration
- Photo growth timeline unless the core build is stable and comfortably within scope

---

# Phase 0 — Establish the working baseline

**Objective:** Create a clean, trackable home for the app and remove ambiguity between the portfolio concept and the product being built.

## 0.1 Repository and ownership

- [x] Use the separate `bloom-app` repository.
- [x] Initialize and maintain it as a Flutter/Dart project using the FVM-pinned Flutter SDK.
- [x] Configure the Android application ID as `design.chandrika.bloom`; document any naming risk before publication.
- [x] Add `docs/` to the mobile repository.
- [x] Copy this plan into `docs/BLOOM_EXECUTION_PLAN.md`.
- [x] Move revised product and design documents into `docs/` so they are tracked.
- [x] Keep signing keys and secrets outside Git.
- [x] Add secret scanning and a clear `.gitignore` before any API work.

Current source material:

- [`PRD.md`](./PRD.md)
- [`DESIGN.md`](./DESIGN.md)
- [`components/case-studies/bloom-case-study.tsx`](./components/case-studies/bloom-case-study.tsx)
- [`public/figma/bloom/`](./public/figma/bloom/)

Note: the copies in this repository's `docs/` directory become the implementation source of truth; the portfolio repository copies remain source material.

## 0.2 Product identity checks

- [x] Search Google Play for conflicting products named Bloom.
- [ ] Perform an appropriate trademark/name availability check.
- [ ] Confirm the final public app name and verify that the configured `design.chandrika.bloom` application ID can remain permanent.
- [ ] Reserve a matching domain or subdomain if desired.
- [ ] Decide the public developer name and support email.

Search evidence recorded 2026-07-24: `design.chandrika.bloom` did not appear in public results, but multiple unrelated apps use **Bloom** and an existing plant-care product markets itself as **Bloom — Complete Plant Care Guide**. Treat the public name as a material collision risk until the owner completes store and trademark checks. The package ID is technically available based on public search only; Google Play Console remains authoritative.

Owner decision recorded 2026-07-24: keep **Bloom**, the public developer name, support email, release countries, and domain explicitly provisional during product validation. This accepts the naming risk for development only; it does not approve the public store identity.

## 0.3 Development accounts

- [ ] Create or verify the Google Play developer account early.
- [ ] Record whether it is a personal or organization account.
- [ ] If it is a personal account created after 2023-11-13, plan for the current 12-testers-for-14-days production-access requirement.
- [x] Defer creating the plant-identification provider account until the technical spike is approved.

Account status recorded 2026-07-24: no Google Play developer account exists yet, so account type and the applicable production-access path cannot be determined. Account creation and classification are required before closed-beta scheduling.

### Exit gate

- [x] Mobile repository exists and builds locally.
- [x] Product documents are tracked.
- [x] App name risk and Play account status/type are documented; unresolved store-identity choices remain explicit release blockers.

---

# Phase 1 — Lock the product definition

**Objective:** Replace the conflicting concept descriptions with one buildable Android-first brief.

## 1.1 Rewrite the core promise

Use this as the working promise:

> Identify or search for a houseplant, review a suggested care plan for your conditions, and know what to do today.

- [x] Remove claims such as “never kill a plant,” “exactly what it needs,” and “care on autopilot.”
- [x] Treat “under one minute” as a design target until it is measured.
- [x] Define the target user as a non-expert with approximately 2–8 indoor plants.
- [x] Define initial geography and language scope: English only; Europe, the United States, and India.
- [x] Exclude pet/child toxicity content until a verified, licensed source is approved.

## 1.2 Define the navigation

Recommended information architecture:

1. **Today** — current and upcoming care tasks
2. **My Plants** — saved collection and history
3. **Discover** — manual search and camera identification
4. **Settings** — accessed from the top app bar rather than a permanent bottom destination

- [x] Confirm these three bottom destinations.
- [x] Remove Community from production navigation.
- [x] Keep manual search next to scanning, not hidden as an error-only fallback.

## 1.3 Write measurable product outcomes

- [x] Define activation: a plant is added and its care plan is confirmed.
- [x] Define first value: the user sees a meaningful next care task.
- [x] Define week-two retention.
- [x] Define acceptable scan latency.
- [x] Define acceptable top-1 and top-3 candidate confirmation rates.
- [x] Define acceptable manual-fallback rate.
- [x] Define acceptable duplicate/missed notification rate.
- [x] Define crash-free and ANR targets.

Suggested validation metrics:

- Median time from Add Plant to activated plan
- Top-1 and top-3 identification confirmation
- Low-confidence rejection quality
- Manual search/fallback use
- Care-plan edit rate
- Notification opt-in rate
- Done, Snooze, Skip, and Reschedule rates
- Week-two and week-four retained carers
- Users disabling reminders because of excessive frequency

## 1.4 Create a scope decision artifact

- [x] Create a one-page `Now / Later / Not yet` artifact in [`SCOPE.md`](./SCOPE.md).
- [x] Record why Community was cut.
- [x] Record why accounts and cloud sync were cut.
- [x] Record why diagnosis and precise recovery guidance were cut.
- [x] Record the criteria required to revisit each deferred feature.

### Exit gate

- [x] One product promise, one target user, and one v1 scope are documented.
- [x] Success measures are written before UI production begins.
- [x] The PRD no longer conflicts with the production navigation or MVP.

---

# Phase 2 — Validate the riskiest assumptions

**Objective:** Test the product loop and identification feasibility before polishing or building the whole app.

Runnable checklist, script, benchmark method, and pass/fail rules live in [`PHASE2_VALIDATION.md`](./PHASE2_VALIDATION.md).

## 2.1 Recruit research participants

- [x] Write recruitment criteria, screening questions, and consent requirements ([`phase2/CONSENT_AND_SESSION.md`](./phase2/CONSENT_AND_SESSION.md), tracker [`phase2/RECRUITMENT_TRACKER.md`](./phase2/RECRUITMENT_TRACKER.md)).
- [ ] Recruit 6–8 new plant owners for prototype testing (owner calendar; tracker ready).
- [ ] Avoid relying only on the original three participants.
- [ ] Include novice and moderately experienced plant owners.
- [ ] Include different Android devices and screen sizes where possible.
- [ ] Obtain explicit consent for quotes, recordings, names, and public case-study use.
- [ ] Use pseudonyms if public-identification consent is unclear.

## 2.2 Prototype tasks

Test these tasks without coaching. Full script and observation focus are in the validation pack.

- [x] Publish the moderated prototype task script.
- [ ] Add a known plant through search.
- [ ] Add an unknown plant through the camera flow.
- [ ] Correct an inaccurate first identification result.
- [ ] Understand and edit the suggested schedule.
- [ ] Mark a care task complete.
- [ ] Snooze, skip, and reschedule a task.
- [ ] Recover after camera permission is denied.
- [ ] Recover after notifications are denied.
- [ ] Find a plant’s care history.

## 2.3 Identification vendor benchmark

Build a representative benchmark set. Method and decision rule are in the validation pack.

- [x] Publish the identification benchmark method and provider decision rule.
- [x] Select 30–50 common houseplant species (40 listed in [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md)).
- [x] Include visually similar species (confusion pairs documented).
- [x] Include healthy and damaged leaves (condition codes in benchmark kit).
- [x] Include poor lighting and cluttered backgrounds (condition codes in benchmark kit).
- [x] Include non-plant images to test rejection (condition `N` in benchmark kit).
- [ ] Document ownership/permission for every benchmark photo (use [`phase2/benchmark_photo_log.csv`](./phase2/benchmark_photo_log.csv)).

Measure each candidate provider (owner run; currently **deferred** without scores):

- [ ] Top-1 confirmation
- [ ] Top-3 confirmation
- [ ] Low-confidence behavior
- [ ] Non-plant rejection
- [ ] Median and p95 latency
- [ ] Failure rate
- [ ] Daily quota and projected cost
- [ ] Image retention and training terms
- [ ] Taxonomy identifiers and care-data compatibility

Candidates to measure: [Pl@ntNet API](https://my.plantnet.org/doc/api/identify) and [Kindwise plant.id](https://www.kindwise.com/plant-id). **2026-07-25 decision: defer scanning** until scores are filled and a provider is Adopted. Kit + rollup: [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md), `dart run docs/phase2/summarize_benchmark_scores.dart`.

## 2.4 Care-content feasibility

- [x] Publish the care-content decision checklist and v1 content rules.
- [x] Select a licensed and reviewable taxonomy source (**locked: GBIF** — see [`phase2/CARE_CONTENT_DECISION.md`](./phase2/CARE_CONTENT_DECISION.md)).
- [x] Select or author a licensed care-content source (**locked: Bloom-authored plans with cited public sources**).
- [x] Start with a curated catalog of approximately 30–50 common houseplants (40-species list shared with ID benchmark).
- [ ] Give every care rule a source and content version (catalog authoring remaining).
- [x] Define which environmental answers influence the schedule.
- [x] Avoid unsupported exact quantities.
- [x] Define cautious language for uncertainty and exceptions.
- [x] Decide whether horticultural review is required before beta (**locked: required**).

### Exit gate

- [ ] Core prototype tasks are understandable without coaching (recruitment tracker ready; sessions owner-owned).
- [x] One identification approach passes the agreed benchmark or scanning is deferred (**deferred** — see [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md)).
- [x] Care-content ownership, sourcing, and limitations are documented (**locked**).

---

# Phase 3 — Redesign the Android-first experience in Figma

**Objective:** Produce a complete, testable Android flow rather than another collection of happy-path screens.

## 3.1 Android design foundation

- [ ] Use standard Material 3 components and interaction behavior, avoiding unnecessary platform-specific UI.
- [ ] Use an Android system status/navigation bar, not an iPhone shell.
- [ ] Design a 412×915 base frame.
- [ ] Verify layouts at 360dp width.
- [ ] Verify 200% font scaling.
- [ ] Design edge-to-edge with correct safe insets.
- [ ] Define light and dark color roles if dark mode remains in v1.
- [ ] Validate text and non-text contrast.
- [ ] Use at least 48dp interactive targets.
- [ ] Pair status color with an icon and explicit label.

## 3.2 Component library

- [ ] Buttons: Primary, Secondary, Ghost, Disabled, Loading
- [ ] Navigation bar and top app bar
- [ ] Task row states: Overdue, Due today, Upcoming, Completed, Snoozed
- [ ] Plant card states: Healthy, Due soon, Needs attention, Archived
- [ ] Status chips with icon + text + color
- [ ] Search field
- [ ] Candidate result row with confidence explanation
- [ ] Environment question controls
- [ ] Editable schedule row
- [ ] Notification action pattern
- [ ] Empty, loading, offline, and error states
- [ ] Confirmation and destructive-action dialogs
- [ ] Snackbar/toast conventions

## 3.3 Complete screen and state inventory

### Activation

- [ ] Welcome/value screen
- [ ] Empty Today state
- [ ] Empty My Plants state
- [ ] Add Plant choice: Search or Scan
- [ ] Search and search results
- [ ] Camera rationale
- [ ] Camera permission denied
- [ ] Camera viewfinder
- [ ] Capture review/retake
- [ ] Identification processing
- [ ] Ranked result candidates
- [ ] Low-confidence result
- [ ] No result
- [ ] Offline/provider unavailable
- [ ] Environment questions
- [ ] Review and edit care plan
- [ ] Reminder explanation and permission request
- [ ] Plant-added confirmation

### Daily loop

- [ ] Today with overdue/due/upcoming sections
- [ ] All caught up
- [ ] Task details/action sheet
- [ ] Done confirmation
- [ ] Snooze options
- [ ] Skip confirmation
- [ ] Reschedule

### Plant management

- [ ] My Plants collection
- [ ] Plant detail
- [ ] Care history
- [ ] Edit schedule
- [ ] Edit plant identity/name/photo
- [x] Archive/delete plant

### Settings and trust

- [ ] Reminder preferences
- [ ] Permission status
- [ ] Privacy policy
- [x] Delete all local data
- [ ] About, version, support, and attribution

## 3.4 Prototype validation

- [ ] Connect every core happy path.
- [ ] Connect every permission-denied and low-confidence recovery path.
- [ ] Run task-based tests with new users.
- [ ] Measure setup time rather than estimating it.
- [ ] Record observed issue → design response → retest result.
- [ ] Freeze the MVP design only after critical failures are addressed.

### Exit gate

- [ ] Complete Android prototype includes happy paths and failure states.
- [ ] No production-critical flow ends at a dead screen.
- [ ] Accessibility review and retest are complete.

---

# Phase 4 — Run technical risk spikes

**Objective:** Prove the difficult integrations before committing to the full implementation.

## 4.1 Project baseline

- [x] Flutter and Dart with standard Material 3 components
- [x] Use the FVM-pinned Flutter SDK for local development and automation.
- [x] Keep the architecture portable to future iOS and web targets while releasing Android first.
- [x] Configure Android application ID `design.chandrika.bloom`.
- [x] Target Android 16 / API 36
- [ ] Decide `minSdk` after checking target-user device coverage; `minSdk 26` is the working assumption.
- [ ] Organize code by feature, with presentation, domain, and data layers where each layer adds value.
- [ ] Use immutable screen state, explicit events/actions, and unidirectional state flow.
- [ ] Keep platform channels and Android-native code behind narrow plugin or adapter boundaries.
- [ ] Choose a lightweight dependency-injection/state-management approach only after comparing Flutter-native options.
- [x] CI build, `flutter analyze`, unit/widget tests, and Android debug artifact

## 4.2 Local data spike

- [ ] Compare maintained Flutter SQLite persistence packages and record the selected package and rejected alternatives.
- [ ] Create a minimal SQLite-backed local database through the selected Flutter package.
- [ ] Persist one user plant, one care plan, one task, and one event.
- [ ] Recreate Flutter UI state from persisted data after process death.
- [ ] Select and test a Flutter preferences package for non-relational settings.
- [ ] Test a schema migration with the selected persistence package.

Working entities:

- `PlantSpecies`
- `UserPlant`
- `CarePlan`
- `CareTask`
- `CareEvent`
- `IdentificationAttempt`

## 4.3 Reminder spike

- [ ] Evaluate a maintained Flutter notifications/background-scheduling plugin and its Android-native configuration.
- [ ] Schedule an inexact care reminder through the selected Flutter plugin, using Android-native persistent work configuration where required.
- [ ] Prove it survives app exit and device reboot.
- [ ] Add Done, Snooze, and Skip notification actions through Flutter plugin APIs, with narrow Android-native integration where required.
- [ ] Make every action idempotent.
- [ ] Prove timezone and daylight-saving transitions do not duplicate or lose tasks.
- [ ] Reframe reminder time as a care window if exact delivery is not guaranteed.

Reference: [Android persistent work guidance](https://developer.android.com/develop/background-work/background-tasks/persistent). Use it to validate the selected Flutter plugin's Android behavior and configuration.

## 4.4 Camera and identification spike

- [ ] Evaluate a maintained Flutter camera plugin and its Android-native configuration.
- [ ] Capture through the selected Flutter camera plugin.
- [ ] Import one image through a Flutter picker plugin backed by Android Photo Picker, without broad media permission.
- [ ] Resize and compress the image.
- [ ] Strip EXIF/GPS metadata.
- [ ] Upload through a backend proxy.
- [ ] Return ranked candidates.
- [ ] Handle timeout, rate limit, malformed response, and offline state.
- [ ] Confirm no vendor API key is present in the APK.

Reference: [Android camera](https://developer.android.com/media/camera) and [Android Photo Picker](https://developer.android.com/training/data-storage/shared/photo-picker) guidance. Use these to validate plugin behavior and any required Android-native configuration.

### Exit gate

- [ ] SQLite persistence, reminders, and identification work independently in disposable Flutter spikes.
- [ ] Technical decisions and rejected alternatives are documented.
- [ ] No unresolved risk can invalidate the MVP architecture.

---

# Phase 5 — Build the app foundation

**Objective:** Create a maintainable local-first production skeleton.

## 5.1 Suggested package structure

```text
lib/
  app/
    navigation/
    theme/
  core/
    database/
    notifications/
    camera/
  features/
    today/
      data/
      domain/
      presentation/
    plants/
      data/
      domain/
      presentation/
    discover/
      data/
      domain/
      presentation/
    settings/
      data/
      domain/
      presentation/
  shared/
    widgets/
```

- [x] Keep the first release in one Flutter package unless build complexity justifies splitting packages.
- [ ] Keep state transitions unidirectional: UI emits events/actions, state holders coordinate domain work, and immutable state renders back to widgets.
- [x] Add Flutter navigation shell for Today / My Plants / Discover with Settings from the app bar; deep links from notifications remain later.
- [x] Create initial design tokens and Material 3 theme from the local design system.
- [ ] Add widget fixtures and golden-test data.
- [ ] Set up Flutter entry points and Android debug, internal, and release flavors as needed.
- [ ] Configure backups deliberately for the database and plant photos.

## 5.2 Source-of-truth rules

- [ ] The SQLite-backed local data layer owns plants, plans, tasks, and events; repositories expose it to feature layers.
- [ ] Notifications are projections of persisted tasks and are scheduled through a Flutter plugin with Android-native configuration where required.
- [ ] User-edited schedules are never silently overwritten by catalog updates.
- [ ] Every care action has a stable ID to prevent duplicates.
- [ ] Catalog data has a version and migration strategy.
- [ ] Raw identification photos are not retained by default.

### Exit gate

- [x] App launches into a navigable production skeleton.
- [ ] Persistence, dependency injection, error handling, and test infrastructure are in place.

---

# Phase 6 — Implement the local care loop

**Objective:** Deliver the retention product before depending on camera identification.

## 6.1 Plant collection and search

- [ ] Seed the approved plant catalog.
- [ ] Implement common/scientific-name search.
- [ ] Add a plant manually.
- [ ] Add a nickname and photo.
- [ ] Show empty and populated collection states.
- [ ] Open plant details from the collection.

## 6.2 Care-plan creation

- [ ] Capture the minimum environment answers.
- [ ] Generate a suggested plan from catalog rules.
- [ ] Let users review and edit every schedule.
- [ ] Mark whether each rule is default or user-modified.
- [ ] Confirm the plan before scheduling reminders.

## 6.3 Today and task actions

- [x] Calculate Overdue, Due today, Upcoming, and Completed states.
- [x] Mark Done with one tap.
- [x] Snooze without changing the underlying schedule unless confirmed.
- [x] Skip once.
- [x] Reschedule explicitly.
- [x] Add every action to care history.
- [x] Show an encouraging All caught up state.
- [x] Prevent duplicate events from repeated taps.

### Exit gate

- [ ] A user can search, add, plan, receive a task, act on it, and inspect history without any remote service.
- [ ] The app remains useful when identification is unavailable.

---

# Phase 7 — Integrate identification

**Objective:** Add camera activation without compromising trust or local reliability.

## 7.1 Backend proxy

- [ ] Create `POST /v1/identify`.
- [ ] Authenticate or attest legitimate app requests as appropriate.
- [ ] Add per-device/IP rate limiting and abuse controls.
- [ ] Keep vendor credentials only on the server.
- [ ] Delete uploaded images immediately after inference unless explicit retention consent exists.
- [ ] Store minimal operational logs.
- [ ] Map vendor taxonomy IDs to Bloom canonical species IDs.
- [ ] Define provider outage and quota behavior.

## 7.2 App integration

- [ ] Ask for camera permission through a Flutter plugin only when Scan is chosen; configure Android permissions natively where required.
- [ ] Provide manual search after denial.
- [ ] Guide capture framing and lighting.
- [ ] Let users review/retake before upload.
- [ ] Show progress and allow cancellation.
- [ ] Show ranked candidates with plain-language confidence.
- [ ] Never auto-add the top candidate without confirmation.
- [ ] Support low-confidence retake and manual search.
- [ ] Record confirmed candidate and correction rate without retaining the raw photo by default.

### Exit gate

- [ ] Identification passes the benchmark on representative devices and network conditions.
- [ ] Denial, low confidence, offline, timeout, and quota paths all recover gracefully.

---

# Phase 8 — Notifications, privacy, and production trust

**Objective:** Make the app safe, transparent, and policy-ready.

## 8.1 Permissions

- [ ] Request `POST_NOTIFICATIONS` through a Flutter plugin only after the first plan is confirmed, with Android manifest/runtime configuration where required.
- [ ] Request camera access through a Flutter plugin only at Scan, with Android manifest/runtime configuration where required.
- [ ] Use a Flutter picker plugin backed by Android Photo Picker instead of broad photo-library permission.
- [ ] Explain the effect of denial without pressuring users.
- [ ] Provide manual alternatives after denial.
- [ ] Verify the final manifest contains no unused permissions.

## 8.2 Privacy

- [ ] Document every data type collected, transmitted, stored, and shared.
- [ ] Include every third-party SDK and provider.
- [ ] Publish a public privacy policy.
- [ ] Link the privacy policy from inside the app.
- [ ] Document retention and deletion.
- [x] Implement Delete all local data.
- [ ] Strip EXIF/GPS before upload.
- [ ] Confirm TLS and server-side secret handling.
- [ ] Confirm identification images are not used for model training without separate consent.
- [ ] Obtain appropriate EEA/GDPR review before release; do not treat this checklist as legal advice.

## 8.3 Accessibility

- [ ] TalkBack labels and meaningful roles
- [ ] Logical focus and reading order
- [ ] 48dp touch targets
- [ ] 200% font scaling
- [ ] No color-only status
- [ ] Contrast checks
- [ ] Reduced-motion behavior where relevant
- [ ] Keyboard/switch navigation spot check
- [ ] Automated accessibility checks plus manual TalkBack testing

Reference: [Android accessibility guidance](https://developer.android.com/guide/topics/ui/accessibility/apps.html).

### Exit gate

- [ ] Data inventory matches real app behavior.
- [ ] Privacy policy and Play Data Safety draft agree.
- [ ] Critical flows pass accessibility testing.

---

# Phase 9 — Quality assurance and closed beta

**Objective:** Prove reliability over repeated real-world care, not just a one-session usability test.

## 9.1 Engineering tests

- [ ] Unit-test recurrence rules.
- [ ] Test timezone, DST, reboot, and manual clock changes.
- [ ] Test snooze, skip, reschedule, and overdue transitions.
- [ ] Test idempotency and deduplication.
- [ ] Test catalog updates without overwriting user edits.
- [ ] Test migrations through the selected Flutter SQLite persistence package.
- [ ] Test camera denial, cancellation, rotation, and process death.
- [ ] Test offline, timeout, rate limit, and malformed API responses.
- [ ] Test notification actions while the app is closed.
- [ ] Test deep links from notifications.
- [ ] Run Flutter navigation, widget, and happy-path integration tests.
- [ ] Add golden/screenshot regression tests for core screens.
- [ ] Verify EXIF removal and server deletion behavior.
- [ ] Run dependency, secret, and security scans.

## 9.2 Device matrix

- [ ] Current Pixel device/emulator
- [ ] Samsung device
- [ ] Xiaomi/Redmi device if available
- [ ] Motorola or another mid-range device
- [ ] Small 360dp-width device
- [ ] Large/foldable layout smoke test
- [ ] Low-memory/process-recreation scenario
- [ ] Android versions across the supported range

## 9.3 Internal and closed testing

- [ ] Upload an internal-test Android App Bundle.
- [ ] Use Play pre-launch reports.
- [ ] Fix blocking crashes, ANRs, accessibility failures, and policy warnings.
- [ ] Recruit at least 12 representative testers if the account requires it.
- [ ] Run the required continuous 14-day closed test.
- [ ] Give testers specific core-loop tasks.
- [ ] Maintain a feedback channel.
- [ ] Run a two-week diary study.
- [ ] Record what changed because of beta evidence.

## 9.4 Beta success review

- [ ] Review activation and setup time.
- [ ] Review top-1/top-3 identification confirmation.
- [ ] Review care-plan edits.
- [ ] Review notification opt-in and action rates.
- [ ] Review week-two retention.
- [ ] Review excessive-reminder feedback.
- [ ] Review crash/ANR and battery behavior.
- [ ] Decide Launch / Fix and retest / Reduce scope.

### Exit gate

- [ ] Closed-test requirement is satisfied where applicable.
- [ ] No unresolved release-blocking quality, policy, privacy, or accessibility issue remains.
- [ ] Production readiness decision is documented with evidence.

---

# Phase 10 — Google Play release

**Objective:** Publish a compliant, accurately represented production app.

## 10.1 Build and signing

- [ ] Target API 36 or the current required API level at submission time.
- [ ] Generate a release Android App Bundle (`.aab`).
- [ ] Create and securely back up the upload key.
- [ ] Enroll in Play App Signing.
- [ ] Verify release signing and provider fingerprints if required.
- [ ] Enable code shrinking/obfuscation and test the release build.
- [ ] Increment and document version code/name.

## 10.2 Store listing

- [ ] Final app name and short description
- [ ] Full description limited to shipped functionality
- [ ] 512×512 Play Store icon
- [ ] 1024×500 feature graphic
- [ ] At least four high-quality 1080×1920 phone screenshots
- [ ] Screenshot alt text
- [ ] Support email and website
- [ ] Privacy policy URL
- [ ] Release notes
- [ ] Correct category, target audience, content rating, and ads declaration
- [ ] App-access instructions if any part requires authentication

Reference: [Google Play preview asset requirements](https://support.google.com/googleplay/android-developer/answer/9866151?hl=en).

## 10.3 Policy declarations

- [ ] Data Safety
- [ ] Privacy policy
- [ ] Target audience
- [ ] Content rating
- [ ] Ads declaration
- [ ] Permissions declarations if applicable
- [ ] Identification provider/SDK behavior verified against declarations

## 10.4 Rollout

- [ ] Submit production-access application if required.
- [ ] Resolve review feedback.
- [ ] Use a staged production rollout.
- [ ] Monitor Android vitals, crashes, ANRs, reviews, and support.
- [ ] Define rollback and hotfix procedure.
- [ ] Confirm the Play Store listing is live before claiming “published” in the case study.

### Exit gate

- [ ] Bloom is publicly installable from Google Play.
- [ ] Privacy and store declarations match the production binary.
- [ ] Monitoring and support processes are active.

---

# Phase 11 — Rebuild the portfolio case study

**Objective:** Turn the old concept story into an evidence-backed product story.

## 11.1 Recommended title and thesis

Working title:

> **Bloom: narrowing a broad plant-care concept into a trustworthy Android MVP**

Working case-study structure:

1. Focused Android hero and honest release status
2. Executive summary: problem, role, evidence, constraints, outcome
3. Three research insights and their limitations
4. The pivotal `Now / Later / Not yet` scope decision
5. Identification-to-care journey
6. Three key decisions:
   - Confidence over false certainty
   - Editable defaults over rigid schedules
   - Low-noise reminders with escape routes
7. Observed issue → response → retest evidence
8. Edge cases, accessibility, privacy, and technical feasibility
9. Beta and Play Store results
10. Remaining uncertainty and next experiment

## 11.2 Content corrections

- [ ] Move the MVP scope decision directly after research.
- [ ] Remove Community from the hero and production outcome.
- [ ] Label the old V3 work as exploratory, not the final product.
- [ ] Replace percentages from the original sample with participant counts.
- [ ] Remove unsupported causal explanations for satisfaction-score changes.
- [ ] Replace “under 60 seconds” with measured timing.
- [ ] Replace “removes the barrier entirely” with calibrated language.
- [ ] Resolve the Berlin/Munich cohort inconsistency.
- [ ] Confirm quote and identity consent or pseudonymize participants.
- [ ] Replace retrofitted heuristic badges with product principles and evidence.
- [ ] Show actual Android screenshots and working states.
- [ ] Add the Play Store link only after release.

## 11.3 Page implementation cleanup

- [ ] Break the 1,600-line case-study component into structured content data and reusable sections.
- [ ] Render static editorial content on the server.
- [ ] Keep only the sidebar and collapsible interactions client-side.
- [ ] Localize the eight remote Framer assets to prevent link rot.
- [ ] Replace repeated prototype CTAs with one primary CTA and one embedded walkthrough.
- [ ] Add `aria-expanded` and `aria-controls` to collapsible sections.
- [ ] Align the active sidebar color with Bloom’s identity.
- [ ] Update route metadata to describe the actual Android MVP.
- [ ] Verify desktop and mobile layouts visually.
- [ ] Run lint, build, accessibility, and link checks.

### Exit gate

- [ ] Case-study claims are traceable to research, beta evidence, or shipped behavior.
- [ ] The page clearly separates exploration, MVP decision, beta, and final release.
- [ ] The live page contains real product evidence and a working Play Store link.

---

# Phase 12 — Post-launch learning

**Objective:** Improve the care loop before expanding scope.

- [ ] Monitor reviews, support requests, crashes, ANRs, and notification complaints weekly.
- [ ] Review activation and retention monthly.
- [ ] Re-run the identification benchmark after provider/model updates.
- [ ] Version care-content changes and preserve user edits.
- [ ] Test improvements with users before broad rollout.
- [ ] Use staged releases for meaningful changes.
- [ ] Revisit deferred features only when a clear retention or user-value problem justifies them.

Do not add Community simply because it appeared in the original prototype. Require evidence of demand, a moderation plan, reporting/blocking, privacy impact, and sustainable content density.

---

# Decision log

Record decisions as they happen.

| Date | Decision | Evidence/rationale | Owner | Revisit when |
|---|---|---|---|---|
| 2026-07-25 | Defer camera identification until the published Pl@ntNet vs plant.id benchmark is measured and Adopted | Kit and scoring helper are ready; no completed score corpus yet. V1 add-plant stays search-first; Spike 3 stays closed until Adopt | Product owner | Owner fills [`phase2/benchmark_scores.csv`](./phase2/benchmark_scores.csv) and records Adopt for a passing provider |
| 2026-07-25 | Lock care stack: GBIF taxonomy + Bloom-authored schedules with cited sources; no toxicity; horticultural review required before closed beta | Matches v1 content rules; rejects quantitative/toxicity datasets that fight scope | Product owner | Catalog authoring or beta review proves a source change is required |
| 2026-07-25 | Phase 2 ID benchmark measures Pl@ntNet and Kindwise plant.id against a 40-species houseplant corpus | Two maintained APIs with clear commercial paths; kit records quality, latency, cost, and retention terms before any camera spike | Engineering | Benchmark scores complete → flip Defer to Adopt or keep Defer with evidence |
| 2026-07-25 | Ship English-only across Europe, the United States, and India | Owner wants one English product experience while covering the primary launch regions; non-English localization waits for closed-beta evidence of a blocking language barrier | Product owner | Closed-beta feedback shows language blocks activation or retention in a priority market |
| 2026-07-24 | Keep release identity provisional during validation | Public search found multiple Bloom products, including a plant-care product; no Play developer account, final developer name, support email, domain, or trademark clearance exists yet. Geography was later locked separately. | Product owner | Before closed-beta scheduling or any public store asset is produced |
| 2026-07-24 | Use Today, My Plants, and Discover as bottom destinations; open Settings from the top app bar | Keeps the daily care loop primary and manual search visible without spending a permanent destination on infrequent settings | Product owner | Prototype tests show users cannot find settings or manual search |
| 2026-07-24 | Exclude toxicity guidance from v1 | No verified, licensed source or review process has been approved; unsupported safety guidance creates unacceptable trust risk | Product owner | A licensed source and review process are approved |
| 2026-07-24 | Sequence technical spikes as persistence, then reminder projection and identification | Persisted tasks and stable event IDs are prerequisites for reliable, idempotent reminder behavior; identification can proceed independently after shared contracts stabilize | Engineering | A spike disproves the dependency or architecture |
| 2026-07-24 | Build with Flutter/Dart, release Android first, and preserve iOS/web portability | Google Play remains the first release target; Flutter supports one product codebase while platform-specific capabilities stay behind plugins/adapters and Android-native configuration | TBD | iOS or web release work is prioritized, or a required capability cannot be supported reliably |
| 2026-07-19 | Local-first MVP | Dependable offline care tasks and history are the retention core | TBD | A validated cross-device sync need justifies cloud infrastructure |
| 2026-07-19 | Defer Community | Weak original signal, high moderation cost, distracts from care loop | TBD | Repeated beta demand and moderation capacity exist |
| 2026-07-19 | Manual search is always available | Protects against permission denial, low confidence, offline/provider failure | TBD | Never remove; only improve |
| 2026-07-19 | Care plans are suggested and editable | Plant needs vary by home, season, pot, soil, and current condition | TBD | Never remove; validate better defaults |

---

# Current risks

| Risk | Impact | Earliest mitigation |
|---|---|---|
| Plant identification performs poorly on indoor plants | Core activation fails and trust drops | Provider benchmark in Phase 2 |
| Care guidance lacks a licensed, trustworthy source | Unsafe or misleading product content | Content-source decision in Phase 2 |
| Reminder behavior duplicates or misses tasks | Retention product becomes unreliable | Scheduling spike in Phase 4 |
| Scope expands back into Community/social features | Delayed launch and moderation burden | Enforce v1 scope and exit gates |
| “Bloom” name conflicts with existing products | Rebrand/package disruption | Name check in Phase 0 |
| Google Play developer account has not been created or classified | Closed testing and production-access timing are unknown | Create the account and record its type before scheduling closed beta |
| Privacy declarations do not match SDK/provider behavior | Play rejection or user-trust damage | Data inventory before beta |
| First-time Flutter/mobile development takes longer than planned | Missed schedule or rushed release | Use the FVM-pinned SDK, build vertical slices, and preserve scope |

---

# Rough planning range

For an experienced solo Flutter developer shipping Android first, with content and provider decisions ready:

- Product definition and validation: 2–3 weeks
- Android-first Material 3 redesign: 2–3 weeks
- Technical spikes: 1–2 weeks
- MVP implementation: 6–8 weeks
- Hardening and closed testing: 2–4 weeks, partially overlapping
- Case-study rebuild: after real beta/release evidence exists

Overall working range: approximately **10–15 weeks**, plus additional learning time for a first Flutter/mobile project. The required closed-test period, when applicable, cannot be compressed below the current Google Play minimum.

---

# Official references

- [Flutter architecture guide](https://docs.flutter.dev/app-architecture/guide)
- [Flutter SDK archive and versioning](https://docs.flutter.dev/install/archive)
- [Flutter Material 3](https://docs.flutter.dev/release/breaking-changes/material-3-migration)
- [Flutter packages](https://pub.dev/flutter)
- [Android persistent work guidance for validating Flutter plugin behavior](https://developer.android.com/develop/background-work/background-tasks/persistent)
- [Android camera guidance for validating Flutter plugin behavior](https://developer.android.com/media/camera)
- [Notification runtime permission](https://developer.android.com/develop/ui/views/notifications/notification-permission)
- [Android Photo Picker](https://developer.android.com/training/data-storage/shared/photo-picker)
- [Android accessibility guidance](https://developer.android.com/guide/topics/ui/accessibility/apps.html)
- [Google Play target API requirements](https://support.google.com/googleplay/android-developer/answer/11926878?hl=en-GB_ALL)
- [Google Play testing requirements](https://support.google.com/googleplay/android-developer/answer/14151465?hl=en)
- [Google Play Data Safety](https://support.google.com/googleplay/android-developer/answer/10787469?hl=en)
- [Publishing Android App Bundles](https://developer.android.com/studio/publish/)
- [Google Play preview assets](https://support.google.com/googleplay/android-developer/answer/9866151?hl=en)
- [Pl@ntNet identification API](https://my.plantnet.org/doc/api/identify)
- [Pl@ntNet pricing](https://my.plantnet.org/pricing)
