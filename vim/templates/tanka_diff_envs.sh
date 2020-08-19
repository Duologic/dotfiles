#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

# template to check for diff, if so, then print summary and/or apply

envs=() // add envs here
for e in ${envs[@]}; do
    set +e
    tk diff $e > /dev/null 2>&1 
    ret=$?
    set -e
    if [ $ret -ne 0 ]; then
        echo $e has diff
        set +e
        tk diff -s $e
        #tk apply $e
        set -e
    fi
done
