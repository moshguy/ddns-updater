#!/bin/bash

#The Digitalocean ddns updater is meant to be run as a script from the command line.  There are two parameters -d for the domain to be updated and -t for your Digitalocean api token

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

#Get external IP address
IP=`curl -s checkip.dyndns.org | grep -Eo '[0-9\.]+'`


# Get all records for domain and parse out RECORD_ID
RECORD_ID=`curl -X GET -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" "https://api.digitalocean.com/v2/domains/$DOMAIN/records" | jq '.domain_records[] | select(.type == "A") | .id'`
echo $RECORD_ID

# Update domain record
curl -s -X PUT -H 'Content-Type: application/json' -H "Authorization: Bearer $TOKEN" -d "{\"data\":\"$IP\"}" "https://api.digitalocean.com/v2/domains/$DOMAIN/records/$RECORD_ID"
