# Bloom Technical Spike Sequence

**Status:** Spike 1 (local persistence) implemented under `lib/spikes/persistence/`; not yet adopted into feature UI. See [`spikes/PERSISTENCE_SPIKE.md`](./spikes/PERSISTENCE_SPIKE.md).
**Last reviewed:** 2026-07-25

These spikes prove architecture-changing assumptions with disposable code. Each spike must record the selected approach, rejected alternatives, evidence, and unresolved risks before production implementation begins.

## Shared rules

- Use the FVM-pinned Flutter SDK and the existing Android API 36 emulator.
- Keep spike code outside production feature folders until the decision is accepted.
- Test on API 26 and API 36, plus at least one physical Android device before accepting platform behavior.
- Prefer maintained Flutter packages and narrow adapters over direct platform code.
- Add no vendor secret to the app, repository, build output, or CI logs.
- Treat every time, timezone, permission, process-death, offline, and retry boundary as explicit test data.

## Spike 1 — Local persistence

Start here because reminders and care history both depend on durable task state.

Evaluate `drift` against direct `sqflite`. Prefer Drift only if its typed queries, reactive reads, and migration tooling justify code generation for the working entities.

Prove:

1. Persist one `PlantSpecies`, `UserPlant`, `CarePlan`, `CareTask`, and `CareEvent`.
2. Recreate the Today screen state after process death without network access.
3. Complete a forward schema migration without losing user data.
4. Keep repository APIs independent of the selected SQLite package.
5. Select a maintained preferences package only for non-relational settings.

Accept when persistence tests cover create/read/update flows, migration, process restart, and a rollback/recovery decision. Record database backup behavior before production use.

## Spike 2 — Reminder projection

Begin after the persistence schema and stable task IDs are proven. Notifications are projections of persisted `CareTask` records; they are never the source of truth.

Evaluate `flutter_local_notifications` scheduled notifications first. Add WorkManager only if a demonstrated background-reconciliation requirement cannot be met by rescheduling from persisted state during app lifecycle events.

Prove:

1. Schedule an inexact care window without requesting exact-alarm access.
2. Request Android notification permission only in context.
3. Survive app exit, device reboot, timezone changes, and daylight-saving transitions.
4. Handle Done, Snooze, and Skip as idempotent operations keyed by stable task/event IDs.
5. Reconcile scheduled notifications from SQLite without duplicates.
6. Document OEM background restrictions and test at least one non-emulator device.

Accept when duplicate and missed-task rates remain below the PRD threshold across the reminder test matrix. Escalate to exact alarms only if research proves that care windows are insufficient and Play policy permits the use case.

## Spike 3 — Camera and identification

Begin only after the Phase 2 provider benchmark defines candidate quality and latency thresholds. It may run alongside the reminder spike once shared persistence contracts are stable.

Evaluate the official Flutter `camera` and `image_picker` packages. Confirm that gallery import uses Android Photo Picker on supported versions. Evaluate a maintained compressor that writes a resized upload copy with EXIF retention disabled.

Prove:

1. Capture a photo and import an existing image without broad media permission.
2. Recover when Android destroys the activity during image selection.
3. Correct orientation, resize, compress, and verify the upload copy contains no EXIF/GPS metadata.
4. Send the processed image only to a backend proxy.
5. Return ranked candidates with confidence data and stable taxonomy identifiers.
6. Handle permission denial, offline state, timeout, rate limit, malformed response, and cancellation.
7. Confirm raw photos are deleted unless the user explicitly chooses to retain one for their plant.

Accept when the approved provider meets the PRD benchmark, no secret is present in the APK, and all failure states preserve manual search.

## Decision order

1. Accept the persistence package and schema/migration approach.
2. Freeze stable IDs and repository contracts used by care tasks and events.
3. Run reminder and identification spikes against those contracts.
4. Record accepted adapters and package choices in the execution-plan decision log.
5. Start the Phase 5 production skeleton only when all three spike exit criteria pass.
