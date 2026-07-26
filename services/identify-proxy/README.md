# Bloom identify proxy

Cloudflare Worker that accepts Bloom scan uploads and forwards them to Pl@ntNet.
The vendor API key stays in Worker secrets — never in the Flutter APK.

## Endpoints

| Method | Path | Purpose |
|---|---|---|
| `GET` | `/health` | Liveness |
| `POST` | `/v1/identify` | Multipart identify (`images` + optional `organs`) |

Query params forwarded to Pl@ntNet: `lang`, `nb-results`.

Uploaded image bytes are **not** written to durable storage; they exist only for the upstream request.

## Local setup

```bash
cd services/identify-proxy
npm install
cp .dev.vars.example .dev.vars
# Put PLANTNET_API_KEY in .dev.vars
npm run dev
```

Worker listens on `http://127.0.0.1:8787` by default.

### Point the Android emulator at local proxy

In repo-root `.env`:

```bash
BLOOM_IDENTIFY_PROXY_URL=http://10.0.2.2:8787
# Leave BLOOM_PLANTNET_API_KEY empty so the app uses the proxy path
BLOOM_PLANTNET_API_KEY=
# Optional, must match Worker BLOOM_APP_TOKEN if set:
BLOOM_IDENTIFY_APP_TOKEN=
```

Then:

```bash
./tool/run_dev.sh -d emulator-5554
```

`10.0.2.2` is the emulator’s alias for the host machine.

## Deploy to Cloudflare

### One-time secrets (local)

```bash
npx wrangler login   # or CLOUDFLARE_API_TOKEN
npx wrangler secret put PLANTNET_API_KEY
# optional closed-beta gate:
npx wrangler secret put BLOOM_APP_TOKEN
```

Worker secrets are **not** rewritten by CI. Set them once; later deploys keep them.

### CI (GitHub Actions)

Workflow: [`.github/workflows/deploy-identify-proxy.yml`](../../.github/workflows/deploy-identify-proxy.yml).

On every push to `main` that touches `services/identify-proxy/**` (or manual **Run workflow**), GitHub deploys the Worker.

Add repository secrets (Settings → Secrets and variables → Actions):

| Secret | Value |
|---|---|
| `CLOUDFLARE_API_TOKEN` | API token with **Edit Cloudflare Workers** |
| `CLOUDFLARE_ACCOUNT_ID` | From `npx wrangler whoami` or the Cloudflare dashboard URL |

### Manual deploy

```bash
npm run deploy
```

Production URL: `https://bloom-identify-proxy.bloom-app.workers.dev`

Set Flutter:

```bash
BLOOM_IDENTIFY_PROXY_URL=https://bloom-identify-proxy.bloom-app.workers.dev
BLOOM_PLANTNET_API_KEY=
BLOOM_IDENTIFY_APP_TOKEN=<same as Worker secret if used>
```

## Abuse controls (v0.1)

- Optional `Authorization: Bearer <BLOOM_APP_TOKEN>`
- Per-IP in-memory rate limit (default 60/hour per isolate)
- Max upload size (default 5 MiB)

Taxonomy mapping to Bloom catalog IDs remains in the app (`catalog_match.dart`).
