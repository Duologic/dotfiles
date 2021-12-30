#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME="$(dirname "$0")"

echo "Running from $DIRNAME"

if [ "$#" != 1 ]; then
  echo "Usage: $(basename "$0") <args>"
  exit 1
fi

function log() {
  echo -e "$(date -u): $*"
}


function finish {
  echo "cleanup"
}
trap finish EXIT
