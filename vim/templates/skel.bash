#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME=$(dirname $0)

if [ "$#" != 1 ]; then
  echo "Usage: `basename $0` <args>"
  exit 1
fi
