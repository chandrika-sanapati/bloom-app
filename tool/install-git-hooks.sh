#!/usr/bin/env bash
# Point this clone at the tracked hooks in .githooks/ (shared with the team).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit .githooks/commit-msg
echo "Git hooks installed (core.hooksPath=.githooks)."
echo "Pre-commit: dart format check + flutter analyze."
echo "Commit-msg: strip Cursor Co-authored-by / Made-with trailers."
