#!/usr/bin/env bash
# Run Bloom with local dart-defines from `.env` (never commit that file).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"

if [[ ! -f .env ]]; then
  echo "Missing .env — copy .env.example to .env and configure identify/auth." >&2
  exit 1
fi

set -a
# shellcheck disable=SC1091
source .env
set +a

DEFINES=()
add_define() {
  local name="$1"
  local value="${!name:-}"
  if [[ -n "$value" ]]; then
    DEFINES+=(--dart-define="${name}=${value}")
  fi
}

add_define BLOOM_IDENTIFY_PROXY_URL
add_define BLOOM_IDENTIFY_APP_TOKEN
add_define BLOOM_PLANTNET_API_KEY
add_define BLOOM_SUPABASE_URL
add_define BLOOM_SUPABASE_ANON_KEY
add_define BLOOM_GOOGLE_SERVER_CLIENT_ID

if [[ -z "${BLOOM_IDENTIFY_PROXY_URL:-}" && -z "${BLOOM_PLANTNET_API_KEY:-}" ]]; then
  echo "Warning: no identify dart-defines set — Scan will use demo results." >&2
fi

exec fvm flutter run "${DEFINES[@]}" "$@"
