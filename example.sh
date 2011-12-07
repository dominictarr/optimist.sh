#!/usr/bin/env bash

#source optimist.sh into your bash script
#
. optimist.sh
. <(argv "$@")

for key in ${!argv_*}; do
  value="${!key}"
  echo "$key"="$value"
done