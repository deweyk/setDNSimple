#!/bin/bash

LOGIN="<enter your login>"
PASSWORD="<enter your password>"
DOMAIN_ID="<your domain>"
RECORD_ID="<record on dnsimple>"

echo "Getting current external IP"
IP="`curl http://jsonip.com | sed 's/{"ip":"\(.*\)"/\1/g' | sed 's/}//'`"
echo "Current external IP is $IP"

echo "Updating external record to $IP"
curl -H "Accept: application/json" \
     -H "Content-Type: application/json" \
     -u "$LOGIN:$PASSWORD" \
     -X "PUT" \
     -i "https://dnsimple.com/domains/$DOMAIN_ID/records/$RECORD_ID" \
     -d "{\"record\":{\"content\":\"$IP\"}}"

echo "Set record"

