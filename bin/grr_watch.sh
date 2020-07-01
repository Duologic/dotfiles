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

export GRAFANA_URL=http://localhost:3100/grafana

grr watch "$WATCH" "$APPLY" &
GPID=$!

_trap_grr_watch () {
  # kill not really needed, subshell will kill the background job
  kill $GPID
  kill $FPID
  unset GRAFANA_URL
}
trap _trap_grr_watch EXIT

while inotifywait -e modify "$WATCH"; do
  sleep 3
  CURRENT_WID=$(xdotool getwindowfocus)
  WID=`xdotool search --name "Mozilla Firefox" | head -1`
  xdotool windowactivate --sync $WID
  xdotool key --clearmodifiers ctrl+r
  sleep 1
  xdotool windowactivate $CURRENT_WID
done
