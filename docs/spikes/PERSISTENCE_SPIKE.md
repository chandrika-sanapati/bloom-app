# Persistence Spike — Decision Record

**Status:** Adopted into app data layer (`lib/data/`); feature UI reads/writes SQLite  
**Date:** 2026-07-25 (spike), adopted 2026-07-25  
**Production code:** [`lib/data/`](../../lib/data/)  
**Tests:** [`test/spikes/persistence/`](../../test/spikes/persistence/), [`test/widget_test.dart`](../../test/widget_test.dart)

## Decision

**Selected:** [Drift](https://pub.dev/packages/drift) with a main-isolate `NativeDatabase` for relational local data.  
**Preferences:** [`shared_preferences`](https://pub.dev/packages/shared_preferences) for non-relational settings only.

## Rejected alternative

**sqflite (direct):** Rejected because typed queries, reactive streams, and first-class migration helpers reduce hand-written SQL as care-task/event volume grows. Code generation cost is accepted and checked in via `*.g.dart`.

## What was proven (spike)

1. Persist one of each: `PlantSpecies`, `UserPlant`, `CarePlan` (items), `CareTask`, `CareEvent`.
2. Recreate Today open-task ordering after closing and reopening a file-backed database.
3. Forward schema migration without losing existing plants (now through schema v3).
4. Call sites use [`CareRepository`](../../lib/data/domain/care_repository.dart) / [`SettingsRepository`](../../lib/data/domain/settings_repository.dart).
5. Round-trip preferences via `shared_preferences`.

## Adoption notes

- Bootstrap: [`BloomServices.bootstrap`](../../lib/data/bloom_services.dart) opens `BloomDatabase.defaults()`, seeds sample data once via [`FixtureSeeder`](../../lib/data/local/fixture_seeder.dart), and is provided through [`BloomScope`](../../lib/app/bloom_scope.dart).
- Today / My Plants / plant detail load and mutate through `CareRepository`.
- Schema v3 adds `overview` and `accent_argb` on species for UI.
- Disposable `lib/spikes/persistence/` copy removed in favor of `lib/data/`.

## Codegen

```sh
fvm dart run build_runner build
```

Commit generated [`bloom_database.g.dart`](../../lib/data/local/drift/bloom_database.g.dart).

## Backup / recovery stance

- **Now:** SQLite file is the source of truth; sample seed runs once per install prefs flag.
- **Before Play release:** Decide export/delete-all behavior and Android Auto Backup inclusion. On failed migration, prefer recoverable error over wiping data.

## Unresolved risks / remaining gates

- API 26 + physical-device smoke before freezing platform behavior.
- `IdentificationAttempt` entity still deferred.
- Stable task/event string IDs should stay frozen before the reminder spike.
- Discover add-to-collection still fixture/snackbar only.
