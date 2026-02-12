#!/usr/bin/env bash
set -euo pipefail

if [[ ! -x ".venv/bin/python" ]]; then
  echo "Missing virtualenv. Run make bootstrap first." >&2
  exit 1
fi

# shellcheck disable=SC1091
source .venv/bin/activate

python -m ruff check \
  libs/kb_core/src \
  libs/kb_core/tests \
  services/api/src \
  services/api/tests \
  services/worker/src \
  services/worker/tests

python -m mypy --config-file libs/kb_core/pyproject.toml libs/kb_core/src
python -m mypy --config-file services/api/pyproject.toml services/api/src
python -m mypy --config-file services/worker/pyproject.toml services/worker/src
