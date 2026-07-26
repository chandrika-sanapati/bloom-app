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

```bash
npx wrangler login
npx wrangler secret put PLANTNET_API_KEY
# optional closed-beta gate:
npx wrangler secret put BLOOM_APP_TOKEN
npm run deploy
```

Set Flutter:

```bash
BLOOM_IDENTIFY_PROXY_URL=https://bloom-identify-proxy.<your-subdomain>.workers.dev
BLOOM_PLANTNET_API_KEY=
BLOOM_IDENTIFY_APP_TOKEN=<same as Worker secret if used>
```

## Abuse controls (v0.1)

- Optional `Authorization: Bearer <BLOOM_APP_TOKEN>`
- Per-IP in-memory rate limit (default 60/hour per isolate)
- Max upload size (default 5 MiB)

Taxonomy mapping to Bloom catalog IDs remains in the app (`catalog_match.dart`).
