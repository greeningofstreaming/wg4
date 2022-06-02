#!/bin/bash

usage() {
  echo "Usage: $0 <period> <provider_name>"
}

if [[ $# -ne 2 ]]; then
    usage
    exit 1
fi

log_file=$2-energy-logs.json
rm -f $log_file

record_date=$(date +%Y%m%d%H%M%S%N)

while :
do
	date=$(date --utc +%FT%T.%3NZ)
	power=$(ipmitool dcmi power reading | grep Instantaneous | awk {'print $4'})
	idle_cpu=$(top -bn1 | grep "Cpu(s)" | sed "s/.*, *\([0-9.]*\)%* id.*/\1/")
	used_cpu=$(bc <<< "100 - $idle_cpu")
	sleep $1
(
cat << EOF
{
	"id": "gos:test-$2-$record_date",
	"context": "test",
	"provider": "$2",
	"date": "$date",
	"metric": "watts",
	"value": "$power",
	"supplemental":
	{
		"cpu": "$used_cpu",
	}
},
EOF
) >> $log_file

done
