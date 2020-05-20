#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

DIRNAME=$(dirname $0)
CHAIN_PEM="${1}"

if [ "$#" != 1 ]; then
  echo "Usage: `basename $0` BASE64_CERTIFICATE_CHAIN_FILE"
  exit 1
fi

if ! openssl x509 -in "${CHAIN_PEM}" -noout 2>/dev/null ; then
    echo "${CHAIN_PEM} is not a certificate" >&2
    exit 1
fi

awk -F'\n' '
        BEGIN {
            showcert = "openssl x509 -noout -subject -issuer -dates"
        }

        /-----BEGIN CERTIFICATE-----/ {
            printf "%2d: ", ind
        }

        {
            printf $0"\n" | showcert
        }

        /-----END CERTIFICATE-----/ {
            close(showcert)
            ind ++
        }
    ' "${CHAIN_PEM}"

echo
openssl verify -untrusted "${CHAIN_PEM}" "${CHAIN_PEM}"
