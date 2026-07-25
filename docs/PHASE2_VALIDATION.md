# Bloom Phase 2 Validation Pack

**Status:** Camera-blocking gates closed — care locked; scanning **deferred**; prototype sessions still owner-owned  
**Last reviewed:** 2026-07-25  
**Market context:** English-only app; initial Play markets are Europe, the United States, and India

Care ownership is locked and camera identification is explicitly deferred until a provider is Adopted from the benchmark kit. Spike 3 stays closed. Prototype recruitment/sessions continue in parallel and do not by themselves unlock the camera.

### Working artifacts

| Artifact | Path |
|---|---|
| Consent + session templates | [`phase2/CONSENT_AND_SESSION.md`](./phase2/CONSENT_AND_SESSION.md) |
| Recruitment tracker | [`phase2/RECRUITMENT_TRACKER.md`](./phase2/RECRUITMENT_TRACKER.md) |
| ID provider benchmark kit | [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md) |
| Score rollup helper | [`phase2/summarize_benchmark_scores.dart`](./phase2/summarize_benchmark_scores.dart) |
| Score + photo CSVs | [`phase2/benchmark_scores.csv`](./phase2/benchmark_scores.csv), [`phase2/benchmark_photo_log.csv`](./phase2/benchmark_photo_log.csv) |
| Care-content decision note | [`phase2/CARE_CONTENT_DECISION.md`](./phase2/CARE_CONTENT_DECISION.md) (**locked**) |
| Catalog ↔ taxonomy map | [`phase2/catalog_mapping.csv`](./phase2/catalog_mapping.csv) |

## Success thresholds

Use the PRD outcomes as pass/fail gates:

| Area | Pass if |
|---|---|
| Activation | At least 70% of observed participants who start Add Plant confirm a plant and editable care plan |
| Time to activation | Median measured; under one minute remains a design target, not a claim |
| First value | Every activated plant produces a clear next task or explicit no-task-yet state |
| Identification latency | Median ≤ 5s and p95 ≤ 10s on the supported network profile |
| Identification quality | Top-1 ≥ 70% and top-3 ≥ 90% on the approved benchmark set |
| Manual fallback | Available for 100% of attempts; investigate if > 30% of attempts require it |
| Care content | Every v1 care rule has a source, version, and cautious language; no unsupported exact quantities |

## 2.1 Participant recruitment

### Criteria

Recruit **6–8** plant owners who were not the original three concept participants.

Include:

- At least 4 novices (0–2 years caring for houseplants)
- At least 2 moderately experienced owners
- Owners of approximately 2–8 indoor plants
- Mix of Android device sizes where possible (small phone, large phone, one foldable or tablet if available)
- Participants living in or familiar with Europe, the United States, or India

### Screening questions

1. How many indoor plants do you currently care for?
2. How long have you been caring for houseplants?
3. Which Android phone do you use day to day?
4. Have you used a plant-care or plant-identification app before?
5. Are you comfortable testing an English-only prototype?

Exclude people who primarily care for outdoor gardens, professional horticulturists, and anyone unable to consent to recording.

### Consent

Before the session, obtain written consent covering:

- Session recording (screen and optional voice)
- Use of anonymized quotes in internal product notes
- Whether the participant allows named or identifiable case-study use

Default to pseudonyms unless the participant explicitly consents to public identification.

### Session logistics

- Duration: 45–60 minutes
- Format: moderated remote or in-person
- Artifact: clickable Android-first prototype or interactive Figma flow covering the tasks below
- Facilitator does not coach task completion; only clarifies when a prototype dead-end blocks the session

## 2.2 Prototype test script

Run tasks in order. Mark each as Pass / Struggle / Fail and capture verbatim friction.

| # | Task | Observation focus |
|---|---|---|
| 1 | Add a known plant through search | Can the participant find search without coaching? |
| 2 | Add an unknown plant through the camera flow | Does the scan entry point next to search feel obvious? |
| 3 | Correct an inaccurate first identification result | Can they choose another candidate or fall back to search? |
| 4 | Understand and edit the suggested schedule | Do they recognize suggestions as editable, not fixed truth? |
| 5 | Mark a care task complete | Is Done a single clear action? |
| 6 | Snooze, skip, and reschedule a task | Are secondary actions discoverable without cluttering Done? |
| 7 | Recover after camera permission is denied | Does the flow preserve manual search? |
| 8 | Recover after notifications are denied | Can they continue using Today without reminders? |
| 9 | Find a plant’s care history | Can they reach history from My Plants or plant detail? |

### Post-task questions

1. In your own words, what does Bloom help you do?
2. What would make you trust or distrust the care schedule?
3. Would you keep reminders on? Why or why not?
4. What felt missing for your plants at home?

### Pass criteria for the prototype gate

- Tasks 1, 4, 5, and either 2 or 3 succeed without coaching for at least 5 of 6–8 participants
- Permission-denied recoveries (tasks 7–8) never strand the participant
- No participant believes Community or an account is required to complete the care loop

## 2.3 Identification vendor benchmark

### Candidate set

Start with [Pl@ntNet API](https://my.plantnet.org/doc/api/identify) as the first measurable candidate. Evaluate at least one alternative before committing. Treat every provider as disposable until the benchmark passes.

### Image corpus

Build **30–50** labeled houseplant samples covering:

- Common indoor species in Europe, the United States, and India homes
- Visually similar pairs or groups
- Healthy leaves and damaged or dusty leaves
- Poor lighting and cluttered backgrounds
- Non-plant images for rejection testing

Document ownership or permission for every photo before use.

### Metrics to record per provider

- Top-1 confirmation rate
- Top-3 confirmation rate
- Low-confidence behavior quality
- Non-plant rejection rate
- Median and p95 latency
- Failure or timeout rate
- Daily quota and projected cost at closed-beta and launch volume
- Image retention and training terms
- Taxonomy identifier stability and care-catalog compatibility

### Decision rule

- **Adopt** a provider only if top-1/top-3 and latency pass the PRD thresholds and terms are acceptable for a privacy-safe proxy upload.
- **Defer camera identification** if no candidate passes; keep manual search as the sole add-plant path and update the PRD/scope before Phase 3 freezes.

## 2.4 Care-content feasibility

### Required decisions

1. Licensed, reviewable taxonomy source
2. Licensed or originally authored care-content source
3. Curated v1 catalog of approximately 30–50 common houseplants
4. Source and content version on every care rule
5. Which environment answers change the suggested schedule
6. Cautious language for uncertainty and exceptions
7. Whether independent horticultural review is required before closed beta

### Content rules for v1

- No unsupported exact watering volumes
- No pet/child toxicity claims
- No disease diagnosis or recovery prescriptions
- Schedules are labeled as suggestions and remain editable
- Catalog entries must map cleanly to identification taxonomy IDs or a documented manual-mapping table

### Output artifact

Create a short care-content decision note that records the chosen sources, rejected alternatives, catalog size, review requirement, and known limitations. Link it from the execution-plan decision log when complete.

## Execution order

1. Finalize recruitment and consent templates.
2. Run prototype sessions with the script above.
3. Build the identification image corpus and run provider benchmarks in parallel with care-content source evaluation.
4. Record Pass / Defer decisions for scanning and care content.
5. Close the Phase 2 exit gate before Phase 3 design freeze or Phase 4 spikes.

## Phase 2 exit gate

- [ ] Core prototype tasks are understandable without coaching (tracker ready — [`phase2/RECRUITMENT_TRACKER.md`](./phase2/RECRUITMENT_TRACKER.md); sessions not yet run).
- [x] One identification approach passes the agreed benchmark, or scanning is explicitly deferred (**deferred** 2026-07-25).
- [x] Care-content ownership, sourcing, and limitations are documented (**locked** 2026-07-25).

### Camera unlock rule

Spike 3 may start only after [`phase2/IDENTIFICATION_BENCHMARK.md`](./phase2/IDENTIFICATION_BENCHMARK.md) decision log Winner is `plantnet` or `plant_id` with PRD thresholds passed (use the score rollup helper).
