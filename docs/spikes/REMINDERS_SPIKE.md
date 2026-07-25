# Reminders Spike — Decision Record

**Status:** Light production wire-up + cold-start hardening  
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
6. Cold-start / background actions:
   - Action buttons use `showsUserInterface: true` so the main isolate can apply them.
   - `getNotificationAppLaunchDetails` applies a pending action during bootstrap.
   - `bloomNotificationBackground` applies SQLite mutations if a background engine is used.
   - `ReminderActionBridge` pings the UI isolate to refresh tabs after a background mutation.

## Architecture

| Piece | Role |
|---|---|
| `ReminderScheduler` | Platform adapter interface |
| `FlutterReminderScheduler` | Real plugin wrapper + background entry |
| `RecordingReminderScheduler` | In-memory fake for tests |
| `CareReminderService` | Projector: enable/disable, reconcile, actions |
| Settings switch | Permission-in-context gate |
| `BloomApp` lifecycle | Reconcile on resume; listen for bridge pings |

## Manual smoke checklist (emulator / device)

Run on API 36 emulator first, then API 26 and one physical device before accepting Spike 2.

### Cold-start actions

1. Enable Care reminders in Settings; grant notification permission.
2. Force-stop Bloom (`adb shell am force-stop design.chandrika.bloom`).
3. Trigger or wait for a care notification.
4. Tap **Done** from the shade → reopen Bloom → task is completed once, no duplicate care event.
5. Repeat for **Snooze** (due time moves later; reminder rescheduled) and **Skip**.

### Reboot survival

1. With reminders enabled and at least one open task scheduled, reboot the device/emulator.
2. After boot, confirm the OS still shows the pending care notification when due (plugin boot receiver).
3. Open Bloom once → Today matches SQLite; pending notifications reconcile without duplicates (`adb shell dumpsys notification` / shade check).

### Still open hardware gates

- OEM battery restrictions on a physical device.
- Timezone change and DST transition acceptance.
- Missed/duplicate rate vs PRD threshold after device testing.

## Accept criteria status

| Prove | Status |
|---|---|
| Inexact schedule, no exact-alarm | Proven in adapter + unit tests |
| Permission in context | Wired in Settings |
| Done/Snooze/Skip idempotent | Unit tested |
| Reconcile without dupes | Unit tested |
| Cold-start action wiring | Code + unit test; manual smoke open |
| Reboot / TZ / DST / OEM / physical device | Checklist ready; hardware **open** |

Do **not** treat Spike 2 as fully accepted until the open matrix rows pass on hardware.
