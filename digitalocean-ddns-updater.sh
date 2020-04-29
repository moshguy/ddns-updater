#!/bin/bash

printf "$(date)\n"

while getopts t:d: option
  do
    case "${option}"
    in
      t) TOKEN=${OPTARG};;
      d) DOMAIN=${OPTARG};;
  esac
done


#TOKEN="Get token from https://cloud.digitalocean.com/settings/applications"
#DOMAIN=example.com
#RECORD_ID=12345
IP=`curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'`


# to get record id:
RECORD_ID=`curl -X GET -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/domains/$DOMAIN/records" | jq '.domain_records[] | select(.type == "A") | .id'`
echo $RECORD_ID

# update domain record
curl -s -X PUT -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"data\":\"$IP\"}" "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"
