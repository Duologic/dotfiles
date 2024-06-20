#!/usr/bin/env bash
set -euo pipefail
IFS=$'\n\t'

if [ "$#" != 1 ]; then
  echo "Usage: $(basename "$0") <FILE>"
  exit 1
fi

F=$PWD/$1

sed -i 's/j.fieldname.id/a.id.new/' $F
sed -i 's/j.fieldname.string/a.string.new/' $F
sed -i 's/j.object.members/a.object.new/' $F
sed -i 's/j.importF/a.import_statement.new/' $F
sed -i 's/j.field.field/a.field.new/' $F
sed -i 's/j.parenthesis/a.parenthesis.new/' $F
sed -i 's/j.literal/a.literal.new/' $F
sed -i "s/break='\\\\n'//" $F
sed -i 's/jutils/atils/' $F
sed -i 's/Duologic\/jsonnet-libsonnet/crdsonnet\/astsonnet/' $F
