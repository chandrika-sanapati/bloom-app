# Bloom Technical Spike Sequence

**Status:** Spike 1 adopted. Spike 2 wired (hardware reboot/OEM/TZ gates still open — runbook [`spikes/REMINDERS_HARDWARE_SMOKE.md`](./spikes/REMINDERS_HARDWARE_SMOKE.md)). Spike 3 (camera) **open** — provider **Pl@ntNet Adopted** ([`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md)). See [`spikes/PERSISTENCE_SPIKE.md`](./spikes/PERSISTENCE_SPIKE.md), [`spikes/REMINDERS_SPIKE.md`](./spikes/REMINDERS_SPIKE.md).
**Last reviewed:** 2026-07-26

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

**Unlocked** — provider **Pl@ntNet Adopted** ([`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md)). Discover → Scan uses `image_picker` (camera + gallery), client/parser under `lib/data/identification/`, and confirm → Add plant. Manual search remains on every failure path.

Proxy scaffold: [`services/identify-proxy/`](../services/identify-proxy/) (`POST /v1/identify`, Worker secrets, rate limit). App calls `{BLOOM_IDENTIFY_PROXY_URL}/v1/identify`.

Still open before store release:

1. Deploy the Worker (`wrangler secret put` + `npm run deploy`); set app `BLOOM_IDENTIFY_PROXY_URL` — never ship `BLOOM_PLANTNET_API_KEY` in release APKs.
2. Hardware smoke: activity recreation during picker, permission denial, offline/timeout/429.
3. Closed-beta quality smoke vs PRD top-1/top-3; fill [`phase2/benchmark_scores.csv`](./phase2/benchmark_scores.csv).
4. Confirm upload copies strip EXIF/GPS (picker already uses `requestFullMetadata: false` + resize/quality).

## Decision order

1. Accept the persistence package and schema/migration approach.
2. Freeze stable IDs and repository contracts used by care tasks and events.
3. Run reminder and identification spikes against those contracts.
4. Record accepted adapters and package choices in the execution-plan decision log.
5. Start the Phase 5 production skeleton only when all three spike exit criteria pass.
