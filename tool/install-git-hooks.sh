#!/usr/bin/env bash
# Point this clone at the tracked hooks in .githooks/ (shared with the team).
set -euo pipefail
ROOT="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT"
git config core.hooksPath .githooks
chmod +x .githooks/pre-commit
echo "Git hooks installed (core.hooksPath=.githooks)."
echo "Pre-commit will run: dart format check + flutter analyze."
