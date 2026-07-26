# Bloom v1 Scope Decisions

**Last reviewed:** 2026-07-25

This artifact protects the local care loop from scope expansion. A feature moves into **Now** only when it supports activation, dependable care tasks, or release trust without invalidating the delivery plan.

## Now — Android v1

- English-only app and store listing
- Initial Play markets: Europe, the United States, and India
- Today view with overdue, due, upcoming, and completed tasks
- My Plants collection, plant detail, and chronological care history
- Manual plant search as the primary add-plant path (always available)
- Camera identification via **Pl@ntNet** (ranked candidates; search remains fallback)
- Short environment questionnaire and an editable suggested care plan
- Done, Snooze, Skip, and Reschedule reminder actions
- Reminder preferences and permission management
- Offline access to saved plants and care tasks
- Privacy policy, delete-all-local-data, support, and attribution
- Optional account (Supabase email/password + Google) — **not required** for care or scan; no cloud sync of plants yet

## Later — after the core build is stable

- Swap or dual-run Kindwise plant.id if Pl@ntNet houseplant quality fails PRD smoke
- iOS and web releases
- Optional photo growth timeline
- Additional catalog species and additional countries beyond Europe, the United States, and India
- Non-English localization if closed beta shows a blocking language barrier
- More sophisticated personalization based on validated evidence
- Cloud sync / multi-device backup of plants once auth is stable

Move a Later item into Now only when the Phase 6 care loop is stable, the beta quality gates pass, and the item does not delay Android release.

## Not yet — requires new evidence or operating capacity

- Community, friends, likes, comments, and sharing
- Shared households
- Disease diagnosis and precise recovery guidance
- Pet/child toxicity guidance without a verified licensed source
- Chatbot, marketplace, subscriptions, ads, or hardware integration
- Outdoor and garden plant support

Community is deferred because the original evidence is weak and user-generated content adds moderation and trust obligations. Cloud sync remains Later until auth is proven. Diagnosis, toxicity, and precise recovery guidance are deferred because inaccurate advice creates safety and trust risks.

Revisit these decisions only when repeated beta demand is documented, the core retention loop meets its targets, trustworthy content or provider evidence exists, and the project has the operational capacity to support the feature.
