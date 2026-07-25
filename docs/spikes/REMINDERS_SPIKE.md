# Reminders Spike — Decision Record

**Status:** Light production wire-up under `lib/data/reminders/` + Settings toggle  
**Date:** 2026-07-25  
**Production code:** [`lib/data/reminders/`](../../lib/data/reminders/), Settings + app lifecycle  
**Tests:** [`test/spikes/reminders/`](../../test/spikes/reminders/)

## Decision

**Selected:** [`flutter_local_notifications`](https://pub.dev/packages/flutter_local_notifications) with `timezone` + `flutter_timezone`.  
**Schedule mode:** `AndroidScheduleMode.inexactAllowWhileIdle` only — no exact-alarm permission.  
**Source of truth:** SQLite `CareTask` rows via [`CareReminderService`](../../lib/data/reminders/care_reminder_service.dart). Notifications are a projection.

## Rejected (for now)

**WorkManager:** Not required yet. Reconcile on app bootstrap, `notifyDataChanged()`, and resume covers current product needs. Revisit only if reboot/OEM gaps show missed care windows after lifecycle-only reschedule.

**Exact alarms:** Rejected for Play policy / user friction. Care windows use inexact scheduling.

## What was proven (this pass)

1. Schedule inexact care reminders from open tasks without exact-alarm access.
2. Request notification permission only when enabling Care reminders in Settings.
3. Done / Snooze / Skip are idempotent via stable care-event IDs  
   `action-{action}-{taskId}-{dueAtMs}`.
4. Reconcile cancels Bloom schedules then reschedules open tasks (no duplicates).
5. Boot receiver + `POST_NOTIFICATIONS` declared in AndroidManifest for reboot survival path.

## Architecture

| Piece | Role |
|---|---|
| `ReminderScheduler` | Platform adapter interface |
| `FlutterReminderScheduler` | Real plugin wrapper |
| `RecordingReminderScheduler` | In-memory fake for tests |
| `CareReminderService` | Projector: enable/disable, reconcile, actions |
| Settings switch | Permission-in-context gate |
| `BloomApp` lifecycle | Reconcile on resume |

## Remaining gates (not accepted yet)

- API 26 + physical Android device smoke (OEM battery restrictions).
- Reboot, timezone change, and DST acceptance matrix.
- Missed/duplicate rate vs PRD threshold after device testing.
- Background action delivery when process is dead (notification actions may need cold-start wiring).

## Accept criteria status

| Prove | Status |
|---|---|
| Inexact schedule, no exact-alarm | Proven in adapter + unit tests |
| Permission in context | Wired in Settings |
| Done/Snooze/Skip idempotent | Unit tested |
| Reconcile without dupes | Unit tested |
| Reboot / TZ / DST / OEM / physical device | **Open** |

Do **not** treat Spike 2 as fully accepted until the open matrix rows pass on hardware.
