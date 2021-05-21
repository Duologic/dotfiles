#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

INPUT=${1:=$(</dev/stdin)}
BASE='https://jsonnet-libs.github.io/k8s-alpha'
VERSION='1.16'
OUT=$(echo $INPUT | sed 's/[k$].\([a-zA-Z0-9.]\+\)[;,]/\1/g' | sed 's/\./\//g')

firefox $BASE/$VERSION/$OUT
