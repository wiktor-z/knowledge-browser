#!/usr/bin/env bash
set -euo pipefail

if [[ ! -x ".venv/bin/python" ]]; then
  echo "Missing virtualenv. Run make bootstrap first." >&2
  exit 1
fi

# shellcheck disable=SC1091
source .venv/bin/activate

python -m pytest -c libs/kb_core/pyproject.toml libs/kb_core/tests
python -m pytest -c services/api/pyproject.toml services/api/tests
python -m pytest -c services/worker/pyproject.toml services/worker/tests
