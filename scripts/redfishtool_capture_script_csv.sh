#!/bin/bash

usage() {
  echo "Usage: $0 <event_id> <provider_id> <meter_id> <bmc_ip_address>"
  echo "	- event_id: name of the measured event"
  echo "	- provider_id: name of the provider"
  echo "	- meter_id: name of the server"
  echo "	- bmc_ip_address: IP address of the BMC to access via redfish API"
}

if [[ $# -ne 4 ]]; then
    usage
    exit 1
fi

log_file=$2-$3-energy-logs.csv
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
  start_date=$(date +%s)
  formatted_start_date=$(date -d @$start_date +%FT%T.%3NZ)
  echo $formatted_start_date
  power=$(redfishtool -r $4 -u $login -p $password Chassis getPowerReading | grep AverageConsumedWatts | awk {'print $2'} | sed 's/,/ /g')
  echo $power
  end_date=$(date +%s)
  while [[ $((end_date-start_date)) -lt 60 ]]
  do
    sleep 1
    end_date=$(date +%s)
  done
  formatted_end_date=$(date -d @$end_date +%FT%T.%3NZ)
(
cat << EOF
$2,$3,$1,$formatted_start_date,$formatted_end_date,watts,$power
EOF
) >> $log_file

done
