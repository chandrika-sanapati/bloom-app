# Bloom Privacy Policy

**Last updated:** 2026-07-26  
**Status:** In-app policy for local-first development and closed testing. Not legal advice. A public URL and Play Data Safety form must match this document before store release.  
**Contact:** chandrika.sanapati@gmail.com *(provisional support address)*

## Summary

Bloom is a **local-first** houseplant care app. Your plants, care plans, tasks, history, preferences, and optional plant photos are stored on your device. Bloom does not require an account.

## Data Bloom stores on your device

| Data | Purpose | Leaves the device? |
|---|---|---|
| Plant species and nicknames | Collection and care | No |
| Environment answers (light, climate, pot, experience) | Suggested care cadence | No |
| Care plan items and edit flags | Schedules you confirm or change | No |
| Care tasks and history events | Today list and timeline | No |
| Reminder and unit preferences | Notification and display settings | No |
| Optional plant photos you add | Show your plant in the app | No (kept in app-private storage) |
| Bundled catalog photos | Discover placeholders | Shipped in the app package |

## Permissions

- **Notifications** — requested when you enable care reminders (after adding a plant or in Settings). Used only to schedule inexact care windows for open tasks.
- **Camera** — used if you choose **Take photo** for a plant photo or for **Scan a plant** identification.
- **Photo picker / gallery** — used if you choose a gallery image for a plant photo or for identification. Bloom uses the system Photo Picker where available and does not request broad media-library access for that flow.

Denying a permission does not delete your plants. Manual search and local care tracking remain available.

## What Bloom does not do today

- No mandatory account (sign-in is optional)
- No cloud sync of plants or care data (local storage remains the source of truth)
- No advertising SDKs
- No analytics or crash-reporting SDKs in the current build
- No sale of personal data

## Third parties

- **Android / Google Play services** — OS notification delivery and Photo Picker behavior follow the device platform. Google Sign-In may be used if you choose Continue with Google.
- **Bundled catalog imagery** — royalty-free / Creative Commons placeholders; see in-app **Attribution**.
- **Pl@ntNet** — when you tap **Identify** on Scan, the photo is sent for species ranking. Production builds must use the Bloom identify proxy so the vendor API key stays off-device. The proxy does not retain raw uploads (request-scoped forward only). Ranked names/scores may be shown briefly in the app session. Without a configured proxy (or debug key), the app shows demo sample results and does not upload.
- **Supabase** — if you sign in, email/auth tokens are processed by Supabase Auth. Bloom does not upload your plant collection to Supabase in the current build.

## Retention and deletion

- Data remains on the device until you delete it.
- **Delete all local data** in Settings removes plants, plans, tasks, history, preferences, and scheduled Bloom reminders, and deletes stored plant photos Bloom copied into app-private storage.
- Uninstalling the app removes the on-device database and private files according to Android storage rules.

## Children

Bloom is not directed at children under 13. Do not use the app to store information about children.

## Changes

We may update this policy as features change. The **Last updated** date above will change when material terms change. Significant changes before public release will be reflected in the Play listing privacy URL and Data Safety form.

## Contact

Questions about privacy or data deletion: **chandrika.sanapati@gmail.com** (provisional).
