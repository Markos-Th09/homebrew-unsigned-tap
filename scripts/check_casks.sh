#!/usr/bin/env bash
set -euo pipefail

# Usage:
#  ./scripts/check_casks.sh [base-branch]
# If no base-branch provided, falls back to origin/master.

BASE=${1:-origin/master}

echo "Fetching base branch info..."
git fetch origin --quiet || true

echo "Determining changed Cask files vs $BASE..."
if git rev-parse --verify "$BASE" >/dev/null 2>&1; then
  FILES=$(git diff --name-only "$BASE" HEAD -- 'Casks/*.rb' || true)
else
  FILES=$(find Casks -name '*.rb' | sort)
  echo "No base found — checking all Casks."
fi

if [ -z "$FILES" ]; then
  echo "No Cask files changed. Exiting."
  exit 0
fi

echo "Found Cask files:" >&2
for f in $FILES; do
  echo " - $f" >&2
done

EXIT_CODE=0

for f in $FILES; do
  token=$(basename "$f" .rb)
  echo
  echo "==== Checking $f ($token) ===="

  echo "Ruby syntax check:"
  if command -v ruby >/dev/null 2>&1; then
    if ruby -c "$f" 2>&1 | sed -n '1,200p'; then
      echo "ruby -c: OK"
    else
      echo "ruby -c: FAILED"
      EXIT_CODE=2
    fi
  else
    echo "ruby not found — skipping ruby -c"
  fi

  echo
  echo "RuboCop / style checks (if available):"
  if command -v rubocop >/dev/null 2>&1; then
    rubocop --format simple "$f" || EXIT_CODE=3
  else
    echo "rubocop not found — you can install with: gem install rubocop"
  fi

  echo
  echo "Simulate CI audit (brew audit --cask --except=signing):"
  if command -v brew >/dev/null 2>&1; then
    echo "Running: brew update (may take a while)"
    brew update
    brew audit --cask --except=signing "SoftwareRat/homebrew-unsigned-tap/$token" || EXIT_CODE=4
  else
    echo "brew not found — cannot run brew audit locally on non-macOS hosts."
    echo "If on macOS, run the following manually:"
    echo "  brew update"
    echo "  brew audit --cask --except=signing SoftwareRat/homebrew-unsigned-tap/$token"
  fi
done

exit $EXIT_CODE
