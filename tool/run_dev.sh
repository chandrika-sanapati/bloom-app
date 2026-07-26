#!/usr/bin/env bash
# Run Bloom with local dart-defines from `.env` (never commit that file).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ ! -f .env ]]; then
  echo "Missing .env — copy .env.example to .env and configure identify settings." >&2
  exit 1
fi

set -a
# shellcheck disable=SC1091
source .env
set +a

DEFINES=()
if [[ -n "${BLOOM_IDENTIFY_PROXY_URL:-}" ]]; then
  DEFINES+=(--dart-define="BLOOM_IDENTIFY_PROXY_URL=${BLOOM_IDENTIFY_PROXY_URL}")
fi
if [[ -n "${BLOOM_IDENTIFY_APP_TOKEN:-}" ]]; then
  DEFINES+=(--dart-define="BLOOM_IDENTIFY_APP_TOKEN=${BLOOM_IDENTIFY_APP_TOKEN}")
fi
if [[ -n "${BLOOM_PLANTNET_API_KEY:-}" ]]; then
  DEFINES+=(--dart-define="BLOOM_PLANTNET_API_KEY=${BLOOM_PLANTNET_API_KEY}")
fi

if [[ ${#DEFINES[@]} -eq 0 ]]; then
  echo "Warning: no identify dart-defines set — Scan will use demo results." >&2
fi

exec fvm flutter run "${DEFINES[@]}" "$@"
