# Reminders — Hardware Smoke Runbook

**Parent:** [`REMINDERS_SPIKE.md`](./REMINDERS_SPIKE.md)  
**Goal:** Close Spike 2 reboot / TZ / DST / OEM / physical-device gates.

Use a debug build (`design.chandrika.bloom`). Enable **Care reminders** in Settings and grant notification permission before each path.

## 1. Cold-start notification actions

1. Ensure at least one open Today task exists.
2. `adb shell am force-stop design.chandrika.bloom`
3. Wait for (or trigger) a care notification.
4. From the shade, tap **Done** → reopen Bloom → task completed once; one care event.
5. Repeat with **Snooze** and **Skip**.

## 2. Reboot survival

1. With reminders enabled and an open task due soon, reboot the device/emulator.
2. After boot, confirm the pending notification still fires when due (plugin boot receiver).
3. Open Bloom once → Today matches SQLite; no duplicate shade entries.
4. Optional: `adb shell dumpsys notification | grep -i bloom`

## 3. Timezone change

1. Schedule a reminder a few minutes ahead.
2. Change device timezone (forward and backward by several hours).
3. Return to Bloom (resume triggers timezone refresh + reconcile).
4. Confirm the projected notification time still matches the task `dueAt` calendar intent (no duplicate IDs).

## 4. DST boundary (when applicable)

1. Before a spring-forward / fall-back weekend, schedule a task due across the boundary.
2. After the transition, open Bloom and confirm one pending notification and correct Today urgency.

## 5. OEM battery restrictions (physical device)

On at least one non-Pixel OEM (Samsung / Xiaomi / Oppo / etc.):

1. Note whether care reminders arrive with the screen off after 30+ minutes.
2. If delayed/missing, document the OEM battery screen path for the case study (do not force users into Autostart yet).
3. Record device model + Android version in the spike accept matrix.

## Accept when

| Gate | Pass criteria |
|---|---|
| Cold-start actions | Done / Snooze / Skip each apply once |
| Reboot | Pending care window survives; reconcile is duplicate-free |
| TZ / DST | Resume reconcile keeps one schedule per open task |
| OEM | Behavior documented; no silent data loss |

Mark the matching rows in [`REMINDERS_SPIKE.md`](./REMINDERS_SPIKE.md) only after evidence is recorded.
