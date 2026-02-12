#!/usr/bin/env bash
set -euo pipefail

venvDir=".venv"
pythonBin="python3"

printUsage() {
  cat <<'USAGE'
Usage: infra/scripts/bootstrap.sh [-v <venv-dir>] [-p <python-bin>]

Options:
  -v  Virtual environment directory (default: .venv)
  -p  Python binary (default: python3)
  -h  Show this help message
USAGE
}

while getopts ":v:p:h" opt; do
  case "${opt}" in
    v) venvDir="${OPTARG}" ;;
    p) pythonBin="${OPTARG}" ;;
    h)
      printUsage
      exit 0
      ;;
    *)
      printUsage >&2
      exit 1
      ;;
  esac
done

"${pythonBin}" -m venv "${venvDir}"
# shellcheck disable=SC1090
source "${venvDir}/bin/activate"

python -m pip install --upgrade pip
python -m pip install \
  -e libs/kb_core[dev] \
  -e services/api[dev] \
  -e services/worker[dev]
