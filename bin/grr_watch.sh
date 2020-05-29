#!/bin/bash
set -u
IFS=$'\n\t'

DIRNAME=$(dirname $0)

if [ "$#" != 2 ]; then
  echo "Usage: `basename $0` watch_glob apply_file"
  exit 1
fi

WATCH=$1
APPLY=$2

KUBE_CONTEXT=$(kubectl config current-context 2>/dev/null)
echo "Starting port-forward on cluster $(tput setaf 1)$KUBE_CONTEXT$(tput sgr 0)"

kubectl port-forward svc/nginx 3100:80 &
FPID=$!
echo $FPID

kill_grr_port_forward () {
  # kill not really needed, subshell will kill the background job
  kill $FPID
  unset GRAFANA_URL
}
trap kill_grr_port_forward EXIT

export GRAFANA_URL=http://localhost:3100/grafana

grr watch "$WATCH" "$APPLY"
