#!/bin/bash

usage() {
  echo "Usage: $0 <period> <provider_name> <bmc_ip_address>"
}

if [[ $# -ne 3 ]]; then
    usage
    exit 1
fi

log_file=$2-energy-logs.json
rm -f $log_file

record_date=$(date +%Y%m%d%H%M%S%N)

echo -n Login: 
read login
echo -n Password: 
read -s password
echo

PATH=$PATH:~/.local/bin

while :
do
        date=$(date --utc +%FT%T.%3NZ)
        power=$(redfishtool -r $3 -u $login -p $password Chassis getPowerReading consumed | grep Power | awk {'print $2'})
        sleep $1
(
cat << EOF
{
        "id": "gos:test-$2-$record_date",
        "context": "test",
        "provider": "$2",
        "date": "$date",
        "metric": "watts",
        "value": "$power"
},
EOF
) >> $log_file

done
