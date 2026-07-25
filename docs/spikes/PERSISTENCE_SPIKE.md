# Persistence Spike — Decision Record

**Status:** Spike complete (not yet adopted into feature UI)  
**Date:** 2026-07-25  
**Code:** [`lib/spikes/persistence/`](../../lib/spikes/persistence/)  
**Tests:** [`test/spikes/persistence/`](../../test/spikes/persistence/)

## Decision

**Selected:** [Drift](https://pub.dev/packages/drift) (`drift` + `drift_flutter`) for relational local data.  
**Preferences:** [`shared_preferences`](https://pub.dev/packages/shared_preferences) for non-relational settings only.

## Rejected alternative

**sqflite (direct):** Rejected for this codebase because typed queries, reactive streams, and first-class migration helpers reduce hand-written SQL and keep repository adapters smaller as care-task/event volume grows. Code generation cost is accepted and checked in via `*.g.dart`.

## What was proven

1. Persist one of each: `PlantSpecies`, `UserPlant`, `CarePlan` (items), `CareTask`, `CareEvent`.
2. Recreate Today open-task ordering after closing and reopening a file-backed database (process-death analogue; offline).
3. Forward schema migration v1 → v2 (`user_plant_rows.notes`) without losing existing plants.
4. Feature/tests talk only to [`CareRepository`](../../lib/spikes/persistence/domain/care_repository.dart) / [`SettingsRepository`](../../lib/spikes/persistence/domain/settings_repository.dart) — no Drift types outside `data/drift/`.
5. Round-trip units + reminders-enabled via `shared_preferences`.

## Codegen

After changing tables or the `@DriftDatabase` class:

```sh
fvm dart run build_runner build
```

Commit generated [`bloom_spike_database.g.dart`](../../lib/spikes/persistence/data/drift/bloom_spike_database.g.dart) so CI does not need a separate codegen step.

## Backup / recovery stance

- **Now:** SQLite file is the source of truth; no automated backup/export in the spike.
- **Before production adopt:** Decide user-facing export/delete-all behavior and whether OS backup (Android Auto Backup) should include the DB file. Record rollback: keep previous DB file on failed migration and surface a recoverable error rather than wiping data.

## Unresolved risks / remaining gates

- API 26 + physical-device smoke before accepting platform behavior for production.
- Not wired into Today / My Plants / detail (fixtures remain).
- `IdentificationAttempt` entity deferred.
- Stable task/event IDs are strings; freeze these contracts before the reminder spike.
- OEM file-path / backup quirks not validated on device yet.

## Adopt next

When accepted: move or copy repository contracts into a production data layer, seed from fixtures on first launch if desired, and point Today/My Plants at `CareRepository` instead of `BloomFixtures`.
