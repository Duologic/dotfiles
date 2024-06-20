#!/usr/bin/env bash
# Move plus from end of line to beginning
sed -i ':a;N;$!ba;s/+\n\( \+\){/\n\1+ {/g' $1
