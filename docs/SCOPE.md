# Bloom v1 Scope Decisions

**Last reviewed:** 2026-07-25

This artifact protects the local care loop from scope expansion. A feature moves into **Now** only when it supports activation, dependable care tasks, or release trust without invalidating the delivery plan.

## Now — Android v1

- English-only app and store listing
- Initial Play markets: Europe, the United States, and India
- Today view with overdue, due, upcoming, and completed tasks
- My Plants collection, plant detail, and chronological care history
- Manual plant search as the primary add-plant path (always available)
- Short environment questionnaire and an editable suggested care plan
- Done, Snooze, Skip, and Reschedule reminder actions
- Reminder preferences and permission management
- Offline access to saved plants and care tasks
- Privacy policy, delete-all-local-data, support, and attribution

## Later — after the core build is stable

- Camera identification with ranked candidates and confidence messaging (**deferred** until [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md) records Adopt for a passing provider)
- iOS and web releases
- Optional photo growth timeline
- Additional catalog species and additional countries beyond Europe, the United States, and India
- Non-English localization if closed beta shows a blocking language barrier
- More sophisticated personalization based on validated evidence

Move a Later item into Now only when the Phase 6 care loop is stable, the beta quality gates pass, and the item does not delay Android release.

## Not yet — requires new evidence or operating capacity

- Community, friends, likes, comments, and sharing
- Accounts, cloud sync, and shared households
- Disease diagnosis and precise recovery guidance
- Pet/child toxicity guidance without a verified licensed source
- Chatbot, marketplace, subscriptions, ads, or hardware integration
- Outdoor and garden plant support

Community is deferred because the original evidence is weak and user-generated content adds moderation and trust obligations. Accounts and cloud sync are deferred because the local-first MVP does not require identity or backend synchronization. Diagnosis, toxicity, and precise recovery guidance are deferred because inaccurate advice creates safety and trust risks.

Revisit these decisions only when repeated beta demand is documented, the core retention loop meets its targets, trustworthy content or provider evidence exists, and the project has the operational capacity to support the feature.
